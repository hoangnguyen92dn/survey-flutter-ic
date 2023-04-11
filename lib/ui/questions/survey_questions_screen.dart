import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:survey_flutter_ic/gen/assets.gen.dart';
import 'package:survey_flutter_ic/theme/dimens.dart';
import 'package:survey_flutter_ic/ui/details/survey_details_ui_model.dart';
import 'package:survey_flutter_ic/ui/questions/survey_question_ui_model.dart';
import 'package:survey_flutter_ic/ui/questions/survey_question_view.dart';
import 'package:survey_flutter_ic/ui/questions/survey_questions_view_model.dart';
import 'package:survey_flutter_ic/ui/questions/survey_questions_widget_id.dart';
import 'package:survey_flutter_ic/widget/white_right_arrow_button.dart';

const surveyIdKey = 'surveyId';

class SurveyQuestionsScreen extends ConsumerStatefulWidget {
  final String surveyId;

  const SurveyQuestionsScreen({
    super.key,
    required this.surveyId,
  });

  @override
  ConsumerState<SurveyQuestionsScreen> createState() =>
      _SurveyQuestionsScreenScreenState();
}

class _SurveyQuestionsScreenScreenState
    extends ConsumerState<SurveyQuestionsScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 0), () {
      ref
          .read(surveyQuestionsViewModelProvider.notifier)
          .getSurveyDetails(widget.surveyId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(surveyQuestionsViewModelProvider);
    return Scaffold(
      body: state.maybeWhen(
        loading: () => _buildLoadingIndicator(),
        success: () => _buildSurveyQuestionsContent(),
        orElse: () => const SizedBox.shrink(),
      ),
    );
  }

  Widget _buildSurveyQuestionsContent() => Consumer(
        builder: (_, ref, __) {
          final surveyDetails = ref.watch(surveyDetailsStream).value;
          final totalQuestions = surveyDetails?.questions.length ?? 0;
          final visibleIndex = ref.watch(visibleIndexStream).value ?? 0;
          if (surveyDetails == null) {
            return const SizedBox.shrink();
          } else {
            return _buildQuestionsContent(
              surveyDetails,
              visibleIndex,
              totalQuestions,
            );
          }
        },
      );

  Widget _buildQuestionsContent(SurveyDetailsUiModel surveyDetails,
          int visibleIndex, int totalQuestions) =>
      Container(
        key: SurveyQuestionsWidgetId.questionBackgroundContainer,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: FadeInImage.assetNetwork(
              placeholder: Assets.images.bgSplash.path,
              image: surveyDetails.largeCoverImageUrl,
            ).image,
            fit: BoxFit.cover,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black12, Colors.black26],
              ),
            ),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCloseSurveyButton(),
                  _buildQuestionIndicator(visibleIndex, totalQuestions),
                  const SizedBox(height: space8),
                  _buildQuestionsView(surveyDetails.questions),
                  _buildNextQuestionButton(visibleIndex, totalQuestions),
                  const SizedBox(height: space57)
                ],
              ),
            ),
          ),
        ),
      );

  Widget _buildCloseSurveyButton() => Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: space16, vertical: space20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              key: SurveyQuestionsWidgetId.closeSurveyButton,
              icon: SvgPicture.asset(Assets.images.icClose.path),
              onPressed: () => context.pop(), // TODO Add confirmation dialog
            )
          ],
        ),
      );

  Widget _buildQuestionIndicator(int visibleIndex, int totalQuestion) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: space20),
        child: Text(
          '${visibleIndex + 1}/$totalQuestion',
          key: SurveyQuestionsWidgetId.questionIndicator,
          style: TextStyle(
              color: Colors.white.withOpacity(0.5),
              fontSize: 15,
              fontWeight: FontWeight.bold),
        ),
      );

  Widget _buildQuestionsView(List<SurveyQuestionUiModel> questions) => Consumer(
        builder: (_, ref, __) {
          return Expanded(
            child: SurveyQuestionView(
              questions: questions,
              onPageChanged: (index) => {
                ref
                    .read(surveyQuestionsViewModelProvider.notifier)
                    .setVisibleSurveyIndex(index)
              },
            ),
          );
        },
      );

  Widget _buildNextQuestionButton(int visibleIndex, int totalQuestion) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: space20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // TODO Show the Submit survey button when the last question is shown
            Visibility(
              visible: visibleIndex < totalQuestion - 1,
              child: WhiteRightArrowButton(
                key: SurveyQuestionsWidgetId.nextQuestionButton,
                onPressed: () {
                  ref
                      .read(surveyQuestionsViewModelProvider.notifier)
                      .nextQuestion();
                },
              ),
            ),
          ],
        ),
      );

  // TODO: Extract to common widget for reuse
  Widget _buildLoadingIndicator() {
    return Center(
      child: Visibility(
        maintainSize: true,
        maintainAnimation: true,
        maintainState: true,
        visible: true,
        child: Container(
            margin: const EdgeInsets.symmetric(vertical: 50, horizontal: 50),
            child: const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white))),
      ),
    );
  }
}
