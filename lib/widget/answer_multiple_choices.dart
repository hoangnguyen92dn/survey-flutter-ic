import 'package:flutter/material.dart';
import 'package:survey_flutter_ic/gen/colors.gen.dart';
import 'package:survey_flutter_ic/model/selection_answer_type_model.dart';
import 'package:survey_flutter_ic/theme/dimens.dart';
import 'package:survey_flutter_ic/ui/questions/survey_answer_ui_model.dart';

class AnswerMultipleChoices extends StatefulWidget {
  final List<SurveyAnswerUiModel> answers;
  final SelectionAnswerType answerType;

  const AnswerMultipleChoices({
    super.key,
    required this.answers,
    required this.answerType,
  });

  @override
  State<AnswerMultipleChoices> createState() => _AnswerMultipleChoicesState();
}

class _AnswerMultipleChoicesState extends State<AnswerMultipleChoices> {
  final List<String> _selectedAnswers = [];

  final _scrollController = ScrollController();
  int _visibleIndex = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      final index =
          (_scrollController.offset / multipleChoiceItemHeight).floor();
      setState(() {
        _visibleIndex = index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: multipleChoiceItemHeight * 3, // Show 3 items
      child: ListView.separated(
        controller: _scrollController,
        itemCount: widget.answers.length + 2,
        itemBuilder: (_, index) {
          if (index == 0 || index == widget.answers.length + 1) {
            return const SizedBox(height: multipleChoiceItemHeight);
          } else {
            return _buildItem(index - 1, _visibleIndex + 1 == index);
          }
        },
        separatorBuilder: (_, __) {
          return _buildItemDivider();
        },
      ),
    );
  }

  Widget _buildItem(int index, bool isVisible) {
    return Container(
      height: multipleChoiceItemHeight,
      alignment: Alignment.center,
      child: Row(
        children: [
          _buildItemText(isVisible, index),
          _buildItemCheckBox(isVisible, index),
        ],
      ),
    );
  }

  Widget _buildItemText(bool isVisible, int index) {
    return Expanded(
      child: Text(
        widget.answers[index].text,
        style: TextStyle(
          color: isVisible ? Colors.white : Colors.white.withOpacity(0.5),
          fontSize: fontSize20,
          fontWeight: isVisible ? FontWeight.w800 : FontWeight.w400,
        ),
      ),
    );
  }

  Widget _buildItemCheckBox(bool isVisible, int index) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.white.withOpacity(0.5);
      }
      return isVisible ? Colors.white : Colors.white.withOpacity(0.5);
    }

    return IgnorePointer(
      ignoring: !isVisible,
      child: Checkbox(
        checkColor: ColorName.gray,
        fillColor: MaterialStateProperty.resolveWith(getColor),
        value: _selectedAnswers.contains(widget.answers[index].id),
        shape: const CircleBorder(),
        side: BorderSide(
          color: isVisible ? Colors.white : Colors.white.withOpacity(0.5),
        ),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        onChanged: (bool? value) {
          setState(() {
            _buildAnswerSelection(value ?? false, index);
          });
        },
      ),
    );
  }

  void _buildAnswerSelection(bool value, int index) {
    if (widget.answerType == SelectionAnswerType.single) {
      _selectedAnswers.clear();
    }
    if (value == true) {
      _selectedAnswers.add(widget.answers[index].id);
    } else {
      _selectedAnswers.remove(widget.answers[index].id);
    }
  }

  Widget _buildItemDivider() {
    return const Divider(
      color: Colors.white,
      height: dropdownItemDividerHeight,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
