import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:survey_flutter_ic/model/question_display_type_model.dart';
import 'package:survey_flutter_ic/theme/dimens.dart';
import 'package:survey_flutter_ic/ui/questions/survey_question_ui_model.dart';
import 'package:survey_flutter_ic/ui/questions/survey_questions_view_model.dart';
import 'package:survey_flutter_ic/ui/questions/survey_questions_widget_id.dart';
import 'package:survey_flutter_ic/widget/answer_dropdown.dart';
import 'package:survey_flutter_ic/widget/answer_emoji.dart';

class SurveyQuestionView extends ConsumerStatefulWidget {
  final List<SurveyQuestionUiModel> questions;
  final Function(int) onPageChanged;

  const SurveyQuestionView({
    super.key,
    required this.questions,
    required this.onPageChanged,
  });

  @override
  ConsumerState<SurveyQuestionView> createState() => _SurveyQuestionViewState();
}

class _SurveyQuestionViewState extends ConsumerState<SurveyQuestionView> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    ref.listen(nextQuestionStream, (previous, next) {
      nextPage();
    });
    return PageView.builder(
      // physics: const NeverScrollableScrollPhysics(),
      controller: _pageController,
      onPageChanged: (index) {
        widget.onPageChanged.call(index);
      },
      itemCount: widget.questions.length,
      itemBuilder: (_, index) {
        return _buildPageItem(widget.questions[index]);
      },
    );
  }

  Widget _buildPageItem(SurveyQuestionUiModel question) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: space20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildQuestionText(question),
                const Expanded(child: SizedBox.shrink()),
                _buildAnswers(question),
                const Expanded(child: SizedBox.shrink()),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuestionText(SurveyQuestionUiModel question) {
    return Text(
      question.text.trim(),
      key: SurveyQuestionsWidgetId.questionText,
      style: const TextStyle(
        color: Colors.white,
        fontSize: fontSize34,
        fontWeight: FontWeight.w800,
      ),
    );
  }

  Widget _buildAnswers(SurveyQuestionUiModel question) {
    switch (question.displayType) {
      case QuestionDisplayType.dropdown:
        return AnswerDropdown(
          key: SurveyQuestionsWidgetId.answersDropdown,
          answers: question.answers,
        );
      case QuestionDisplayType.star:
      case QuestionDisplayType.heart:
      case QuestionDisplayType.smiley:
        return AnswerEmoji(
          displayType: question.displayType,
          answers: question.answers,
        );
      default:
        return const SizedBox.shrink();
    }
  }

  void nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
