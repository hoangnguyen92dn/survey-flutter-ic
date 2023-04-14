import 'package:flutter/material.dart';
import 'package:survey_flutter_ic/extension/context_extension.dart';
import 'package:survey_flutter_ic/theme/dimens.dart';
import 'package:survey_flutter_ic/ui/questions/survey_answer_ui_model.dart';

class AnswerTextarea extends StatefulWidget {
  final List<SurveyAnswerUiModel> answers;

  const AnswerTextarea({Key? key, required this.answers}) : super(key: key);

  @override
  State<AnswerTextarea> createState() => _AnswerTextareaState();
}

class _AnswerTextareaState extends State<AnswerTextarea> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(borderRadius10),
        ),
        child: TextField(
          maxLines: null,
          keyboardType: TextInputType.multiline,
          textAlign: TextAlign.start,
          cursorColor: Colors.white,
          style: const TextStyle(
            color: Colors.white,
            fontSize: fontSize17,
            fontWeight: FontWeight.w400,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: context.localization.survey_question_textarea_hint,
            hintStyle: TextStyle(
              color: Colors.white.withOpacity(0.3),
              fontSize: fontSize17,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: space10,
              vertical: space18,
            ),
          ),
        ),
      ),
    );
  }
}
