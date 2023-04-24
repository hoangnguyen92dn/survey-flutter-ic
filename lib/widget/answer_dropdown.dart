import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:survey_flutter_ic/api/request/submit_survey_answers_request.dart';
import 'package:survey_flutter_ic/api/request/submit_survey_questions_request.dart';
import 'package:survey_flutter_ic/theme/dimens.dart';
import 'package:survey_flutter_ic/ui/questions/survey_answer_ui_model.dart';
import 'package:survey_flutter_ic/ui/questions/survey_questions_view_model.dart';

class AnswerDropdown extends ConsumerStatefulWidget {
  final List<SurveyAnswerUiModel> answers;
  final String questionId;

  const AnswerDropdown({
    super.key,
    required this.answers,
    required this.questionId,
  });

  @override
  ConsumerState<AnswerDropdown> createState() => _AnswerDropdownState();
}

class _AnswerDropdownState extends ConsumerState<AnswerDropdown> {
  late var selectedAnswerIndex = 0;

  @override
  Widget build(BuildContext context) {
    ref.listen(nextQuestionStream, (previous, next) {
      ref
          .watch(surveyQuestionsViewModelProvider.notifier)
          .cacheAnswers(SubmitSurveyQuestionsRequest(
            questionId: widget.questionId,
            answers: [
              SubmitSurveyAnswersRequest(
                  answerId: widget.answers[selectedAnswerIndex + 1].id)
            ],
          ));
    });
    return Picker(
      height: 215,
      itemExtent: dropdownItemHeight,
      containerColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      adapter: PickerDataAdapter<SurveyAnswerUiModel>(
        pickerData: widget.answers,
      ),
      hideHeader: true,
      selectionOverlay: SizedBox(
        height: dropdownItemHeight,
        child: Column(
          children: [
            _buildDropdownItemDivider(),
            const Expanded(child: SizedBox.shrink()),
            _buildDropdownItemDivider(),
          ],
        ),
      ),
      onSelect: (Picker picker, int index, List value) {
        selectedAnswerIndex = index;
      },
      onBuilderItem: (
        BuildContext context,
        String? text,
        Widget? child,
        bool selected,
        int col,
        int index,
      ) {
        return _buildDropdownItem(index, selected);
      },
    ).makePicker();
  }

  Widget _buildDropdownItem(int index, bool selected) {
    return Container(
      height: dropdownItemHeight,
      alignment: Alignment.center,
      child: Text(
        widget.answers[index].text,
        style: TextStyle(
          color: selected ? Colors.white : Colors.white.withOpacity(0.5),
          fontSize: fontSize20,
          fontWeight: selected ? FontWeight.w800 : FontWeight.w400,
        ),
      ),
    );
  }

  Widget _buildDropdownItemDivider() {
    return const Divider(
      color: Colors.white,
      height: dropdownItemDividerHeight,
      indent: dropdownItemIndent,
      endIndent: dropdownItemIndent,
    );
  }
}
