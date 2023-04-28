import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:survey_flutter_ic/api/request/submit_survey_answers_request.dart';
import 'package:survey_flutter_ic/api/request/submit_survey_questions_request.dart';
import 'package:survey_flutter_ic/gen/colors.gen.dart';
import 'package:survey_flutter_ic/model/selection_answer_type_model.dart';
import 'package:survey_flutter_ic/theme/dimens.dart';
import 'package:survey_flutter_ic/ui/questions/survey_answer_ui_model.dart';
import 'package:survey_flutter_ic/ui/questions/survey_questions_view_model.dart';

class AnswerMultipleChoices extends ConsumerStatefulWidget {
  final String questionId;
  final List<SurveyAnswerUiModel> answers;
  final SelectionAnswerType answerType;

  const AnswerMultipleChoices({
    super.key,
    required this.questionId,
    required this.answers,
    required this.answerType,
  });

  @override
  ConsumerState<AnswerMultipleChoices> createState() =>
      _AnswerMultipleChoicesState();
}

class _AnswerMultipleChoicesState extends ConsumerState<AnswerMultipleChoices> {
  final List<String> _selectedAnswerIds = [];

  @override
  Widget build(BuildContext context) {
    ref.listen(nextQuestionStream, (previous, next) {
      ref.watch(surveyQuestionsViewModelProvider.notifier).cacheAnswers(
            SubmitSurveyQuestionsRequest(
              questionId: widget.questionId,
              answers: _selectedAnswerIds
                  .map((e) => SubmitSurveyAnswersRequest(answerId: e))
                  .toList(),
            ),
          );
    });
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        for (final answer in widget.answers) ...[
          _buildItem(
            answer,
            _selectedAnswerIds.contains(answer.id),
          ),
          if (answer.id != widget.answers.last.id) _buildItemDivider(),
        ],
      ],
    );
  }

  Widget _buildItem(SurveyAnswerUiModel answer, bool isSelectedAnswer) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _onAnswerClicked(answer.id, !isSelectedAnswer);
        });
      },
      child: Container(
        height: multipleChoiceItemHeight,
        alignment: Alignment.center,
        child: Row(
          children: [
            _buildItemText(answer, isSelectedAnswer),
            _buildItemCheckBox(answer, isSelectedAnswer),
          ],
        ),
      ),
    );
  }

  Widget _buildItemText(SurveyAnswerUiModel answer, bool isSelectedAnswer) {
    return Expanded(
      child: Text(
        answer.text,
        style: TextStyle(
          color:
              isSelectedAnswer ? Colors.white : Colors.white.withOpacity(0.5),
          fontSize: fontSize20,
          fontWeight: isSelectedAnswer ? FontWeight.w800 : FontWeight.w400,
        ),
      ),
    );
  }

  Widget _buildItemCheckBox(SurveyAnswerUiModel answer, bool isSelectedAnswer) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.white.withOpacity(0.5);
      }
      return isSelectedAnswer ? Colors.white : Colors.white.withOpacity(0.5);
    }

    return Checkbox(
      checkColor: ColorName.gray,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: _selectedAnswerIds.contains(answer.id),
      shape: const CircleBorder(),
      side: BorderSide(
        color: isSelectedAnswer ? Colors.white : Colors.white.withOpacity(0.5),
      ),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      onChanged: (bool? value) {
        setState(() {
          _onAnswerClicked(answer.id, value ?? false);
        });
      },
    );
  }

  void _onAnswerClicked(String answerId, bool isSelected) {
    if (widget.answerType == SelectionAnswerType.single) {
      _selectedAnswerIds.clear();
    }
    if (isSelected == true) {
      _selectedAnswerIds.add(answerId);
    } else {
      _selectedAnswerIds.remove(answerId);
    }
  }

  Widget _buildItemDivider() {
    return const Divider(
      color: Colors.white,
      height: dropdownItemDividerHeight,
    );
  }
}
