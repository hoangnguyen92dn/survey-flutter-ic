import 'package:flutter/material.dart';
import 'package:survey_flutter_ic/model/question_display_type_model.dart';
import 'package:survey_flutter_ic/theme/dimens.dart';
import 'package:survey_flutter_ic/ui/questions/survey_answer_ui_model.dart';
import 'package:survey_flutter_ic/ui/questions/survey_questions_widget_id.dart';

enum EmojiStyle {
  emoji,
  smiley,
}

const Map<QuestionDisplayType, String> _emojiMap = {
  QuestionDisplayType.unknown: '👍🏻',
  QuestionDisplayType.star: '⭐',
  QuestionDisplayType.heart: '❤',
};

const List<String> _smileyMap = ['😡', '😕', '😐', '🙂', '😄'];

class AnswerEmoji extends StatefulWidget {
  final QuestionDisplayType displayType;
  final List<SurveyAnswerUiModel> answers;
  final Function(SurveyAnswerUiModel) onAnswerSelected;

  const AnswerEmoji({
    Key? key,
    required this.displayType,
    required this.answers,
    required this.onAnswerSelected,
  }) : super(key: key);

  @override
  State<AnswerEmoji> createState() => _AnswerEmojiState();
}

class _AnswerEmojiState extends State<AnswerEmoji> {
  var _selectedAnswer = 2; // Default value

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: space32),
      child: _buildAnswer(widget.answers),
    );
  }

  Widget _buildAnswer(List<SurveyAnswerUiModel> answers) {
    switch (widget.displayType) {
      case QuestionDisplayType.heart:
      case QuestionDisplayType.star:
        return _buildRating(widget.displayType, EmojiStyle.emoji, answers);
      case QuestionDisplayType.smiley:
        return _buildRating(widget.displayType, EmojiStyle.smiley, answers);
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildRating(
    QuestionDisplayType displayType,
    EmojiStyle answerEmojiType,
    List<SurveyAnswerUiModel> answers,
  ) {
    return Center(
      key: answerEmojiType == EmojiStyle.emoji
          ? SurveyQuestionsWidgetId.answersEmoji
          : SurveyQuestionsWidgetId.answersSmiley,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            for (int i = 0; i < answers.length; i++)
              GestureDetector(
                onTap: () => {
                  setState(() {
                    _selectedAnswer = i;
                    widget.onAnswerSelected.call(answers[i]);
                  })
                },
                child: SizedBox(
                  child: Opacity(
                    opacity: getOpacity(answerEmojiType, i, _selectedAnswer),
                    child: Text(
                      getEmoji(displayType, answerEmojiType, i),
                      style: const TextStyle(
                        fontSize: fontSize28,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  double getOpacity(
    EmojiStyle emojiStyle,
    int index,
    int selectedAnswer,
  ) {
    if (emojiStyle == EmojiStyle.smiley) {
      return index == selectedAnswer ? 1 : 0.5;
    } else {
      return index <= selectedAnswer ? 1 : 0.5;
    }
  }

  String getEmoji(
      QuestionDisplayType displayType, EmojiStyle emojiStyle, int index) {
    if (emojiStyle == EmojiStyle.smiley) {
      return _smileyMap[index];
    } else {
      return _emojiMap[displayType] ?? '';
    }
  }
}
