import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:survey_flutter_ic/api/request/submit_survey_answers_request.dart';
import 'package:survey_flutter_ic/api/request/submit_survey_questions_request.dart';
import 'package:survey_flutter_ic/extension/context_extension.dart';
import 'package:survey_flutter_ic/theme/dimens.dart';
import 'package:survey_flutter_ic/ui/questions/survey_answer_ui_model.dart';
import 'package:survey_flutter_ic/ui/questions/survey_questions_view_model.dart';
import 'package:survey_flutter_ic/ui/questions/survey_questions_widget_id.dart';

class AnswerNps extends ConsumerStatefulWidget {
  final String questionId;
  final List<SurveyAnswerUiModel> answers;

  const AnswerNps({
    super.key,
    required this.questionId,
    required this.answers,
  });

  @override
  ConsumerState<AnswerNps> createState() => _AnswerNpsState();
}

class _AnswerNpsState extends ConsumerState<AnswerNps> {
  var _selectedAnswer = 0; // Default value

  @override
  Widget build(BuildContext context) {
    ref.listen(nextQuestionStream, (previous, next) {
      ref.watch(surveyQuestionsViewModelProvider.notifier).cacheAnswers(
            SubmitSurveyQuestionsRequest(
              questionId: widget.questionId,
              answers: [
                SubmitSurveyAnswersRequest(
                    answerId: widget.answers[_selectedAnswer].id)
              ],
            ),
          );
    });
    return Column(
      children: [
        _buildNps(widget.answers),
        SizedBox.fromSize(size: const Size.fromHeight(space16)),
        _buildNpsDescription(),
      ],
    );
  }

  Widget _buildNps(List<SurveyAnswerUiModel> answers) {
    return Center(
      key: SurveyQuestionsWidgetId.answersNps,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Skip the first index from the api response
            for (int i = 1; i < answers.length; i++)
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () => {
                    setState(() {
                      _selectedAnswer = i;
                    })
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: space18),
                    decoration: _buildNpsItemDivider(i),
                    child: _buildNpsItem(i),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildNpsDescription() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildNpsDescriptionText(
            context.localization.survey_question_nps_lowest_description,
            false,
          ),
          _buildNpsDescriptionText(
            context.localization.survey_question_nps_highest_description,
            true,
          ),
        ],
      ),
    );
  }

  Widget _buildNpsDescriptionText(String text, bool isHighestNps) {
    return Expanded(
      flex: 1,
      child: Text(
        text,
        textAlign: isHighestNps ? TextAlign.end : TextAlign.start,
        style: TextStyle(
          fontSize: fontSize17,
          color: isHighestNps ? Colors.white : Colors.white.withOpacity(0.5),
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  Widget _buildNpsItem(int index) {
    return Opacity(
      opacity: index <= _selectedAnswer ? 1 : 0.5,
      child: Text(
        index.toString(),
        style: TextStyle(
          fontSize: fontSize20,
          color: Colors.white,
          fontWeight:
              index <= _selectedAnswer ? FontWeight.w800 : FontWeight.w400,
        ),
      ),
    );
  }

  BoxDecoration _buildNpsItemDivider(int index) {
    return BoxDecoration(
      border: Border(
        left: index == 1
            ? BorderSide.none
            : const BorderSide(
                color: Colors.white,
                width: 0.5,
              ),
      ),
    );
  }
}
