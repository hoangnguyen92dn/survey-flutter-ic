import 'package:flutter/material.dart';
import 'package:survey_flutter_ic/theme/dimens.dart';
import 'package:survey_flutter_ic/ui/questions/survey_answer_ui_model.dart';

class AnswerForm extends StatefulWidget {
  final List<SurveyAnswerUiModel> answers;

  const AnswerForm({Key? key, required this.answers}) : super(key: key);

  @override
  State<AnswerForm> createState() => _AnswerFormState();
}

class _AnswerFormState extends State<AnswerForm> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: _buildForm(widget.answers),
    );
  }

  Widget _buildForm(List<SurveyAnswerUiModel> answers) {
    return Column(
      children: [
        for (final answer in answers) ...[
          _buildTextInputField(answer),
          SizedBox.fromSize(size: const Size.fromHeight(space16)),
        ],
      ],
    );
  }

  Widget _buildTextInputField(SurveyAnswerUiModel answer) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(borderRadius10),
      ),
      child: TextField(
        keyboardType: _getTextInputType(answer),
        textAlign: TextAlign.start,
        textAlignVertical: TextAlignVertical.center,
        cursorColor: Colors.white,
        style: const TextStyle(
          color: Colors.white,
          fontSize: fontSize17,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: answer.text,
          hintStyle: TextStyle(
            color: Colors.white.withOpacity(0.3),
            fontSize: fontSize17,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: space10,
            vertical: space16,
          ),
        ),
      ),
    );
  }

  TextInputType _getTextInputType(SurveyAnswerUiModel answer) {
    final hintText = answer.text.toLowerCase();
    if (hintText.contains('@') || hintText.contains('email')) {
      return TextInputType.emailAddress;
    } else if (hintText.contains('phone')) {
      return TextInputType.phone;
    } else if (hintText.contains('number') || hintText.contains('no.')) {
      return TextInputType.number;
    } else {
      return TextInputType.text;
    }
  }
}
