import 'package:flutter/material.dart';
import 'package:survey_flutter_ic/extension/context_extension.dart';
import 'package:survey_flutter_ic/theme/dimens.dart';
import 'package:survey_flutter_ic/ui/questions/survey_answer_ui_model.dart';
import 'package:survey_flutter_ic/ui/questions/survey_questions_widget_id.dart';

class AnswerNps extends StatefulWidget {
  final List<SurveyAnswerUiModel> answers;
  final Function(SurveyAnswerUiModel) onAnswerSelected;

  const AnswerNps({
    Key? key,
    required this.answers,
    required this.onAnswerSelected,
  }) : super(key: key);

  @override
  State<AnswerNps> createState() => _AnswerNpsState();
}

class _AnswerNpsState extends State<AnswerNps> {
  var _selectedAnswer = 5; // Default value

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildNps(widget.answers),
        SizedBox.fromSize(size: const Size.fromHeight(space16)),
        _buildNpsDescription()
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
                      widget.onAnswerSelected.call(answers[i]);
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
        textAlign: TextAlign.right,
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
