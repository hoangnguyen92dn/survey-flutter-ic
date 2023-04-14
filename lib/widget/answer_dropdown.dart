import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:survey_flutter_ic/theme/dimens.dart';
import 'package:survey_flutter_ic/ui/questions/survey_answer_ui_model.dart';

class AnswerDropdown extends StatefulWidget {
  final List<SurveyAnswerUiModel> answers;

  const AnswerDropdown({Key? key, required this.answers}) : super(key: key);

  @override
  State<AnswerDropdown> createState() => _AnswerDropdownState();
}

class _AnswerDropdownState extends State<AnswerDropdown> {
  @override
  Widget build(BuildContext context) {
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
      // TODO: Handle submit answer
      onConfirm: (Picker picker, List value) {},
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
