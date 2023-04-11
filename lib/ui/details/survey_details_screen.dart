import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:survey_flutter_ic/extension/context_extension.dart';
import 'package:survey_flutter_ic/gen/assets.gen.dart';
import 'package:survey_flutter_ic/navigation/app_router.dart';
import 'package:survey_flutter_ic/theme/dimens.dart';
import 'package:survey_flutter_ic/ui/details/survey_details_view_model.dart';
import 'package:survey_flutter_ic/ui/details/survey_details_widget_id.dart';
import 'package:survey_flutter_ic/ui/questions/survey_questions_screen.dart';
import 'package:survey_flutter_ic/ui/surveys/survey_ui_model.dart';
import 'package:survey_flutter_ic/widget/flat_button_text.dart';

class SurveyDetailsScreen extends ConsumerStatefulWidget {
  final SurveyUiModel survey;

  const SurveyDetailsScreen({
    super.key,
    required this.survey,
  });

  @override
  ConsumerState<SurveyDetailsScreen> createState() =>
      _SurveyDetailsScreenState();
}

class _SurveyDetailsScreenState extends ConsumerState<SurveyDetailsScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 0), () {
      ref
          .read(surveyDetailsViewModelProvider.notifier)
          .setSurvey(widget.survey);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(surveyDetailsViewModelProvider);
    return Scaffold(
      body: state.maybeWhen(
        success: () {
          // FIXME: The surveyStream emits null value before the survey is set
          final survey = ref.read(surveyStream).value ?? widget.survey;
          return _buildSurveyDetailsContent(survey);
        },
        // Read the survey from the stream
        orElse: () => const SizedBox.shrink(),
      ),
    );
  }

  Widget _buildSurveyDetailsContent(SurveyUiModel survey) {
    return Container(
      key: SurveyDetailsWidgetId.surveyBackgroundContainer,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: FadeInImage.assetNetwork(
            placeholder: Assets.images.placeholderAvatar.path,
            image: survey.largeCoverImageUrl,
          ).image,
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: space32),
          IconButton(
            key: SurveyDetailsWidgetId.backButton,
            onPressed: () => context.pop(),
            icon: SvgPicture.asset(Assets.images.icArrowLeft.path),
            padding: const EdgeInsets.all(space20),
          ),
          _buildSurveyTitle(survey.title),
          const SizedBox(height: space16),
          _buildSurveyDescription(survey.description),
          const Expanded(child: SizedBox.shrink()),
          _buildStartSurveyButton(survey),
        ],
      ),
    );
  }

  Widget _buildSurveyTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: space20),
      child: Text(
        key: SurveyDetailsWidgetId.surveyTitleText,
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: fontSize34,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  Widget _buildSurveyDescription(String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: space20),
      child: Text(
        key: SurveyDetailsWidgetId.surveyDescriptionText,
        description,
        style: TextStyle(
          color: Colors.white.withOpacity(0.7),
          fontSize: fontSize17,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget _buildStartSurveyButton(SurveyUiModel survey) => Consumer(
        builder: (context, _, __) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, space20, space57),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FlatButtonText(
                  key: SurveyDetailsWidgetId.startSurveyButton,
                  text: context.localization.survey_details_start_survey_button,
                  isEnabled: true,
                  onPressed: () => {
                    context.goNamed(
                      RoutePath.questions.routeName,
                      params: {surveyIdKey: survey.id},
                    ),
                  },
                ),
              ],
            ),
          );
        },
      );
}
