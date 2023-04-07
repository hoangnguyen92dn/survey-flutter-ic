import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:survey_flutter_ic/extension/context_extension.dart';
import 'package:survey_flutter_ic/gen/assets.gen.dart';
import 'package:survey_flutter_ic/theme/dimens.dart';
import 'package:survey_flutter_ic/ui/details/survey_details_view_model.dart';
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
    ref.read(surveyDetailsViewModelProvider.notifier).setSurvey(widget.survey);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final survey = ref.watch(surveyDetailStream).value;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: FadeInImage.assetNetwork(
              placeholder: Assets.images.placeholderAvatar.path,
              image: survey?.largeCoverImageUrl ?? '',
            ).image,
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: space32),
            IconButton(
              onPressed: () => {context.pop()},
              icon: SvgPicture.asset(Assets.images.icArrowLeft.path),
              padding: const EdgeInsets.all(space20),
            ),
            _buildSurveyTitle(survey?.title ?? ''),
            const SizedBox(height: space16),
            _buildSurveyDescription(survey?.description ?? ''),
            const Expanded(child: SizedBox.shrink()),
            _buildStartSurveyButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildSurveyTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: space20),
      child: Text(
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
        description,
        style: TextStyle(
          color: Colors.white.withOpacity(0.7),
          fontSize: fontSize17,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget _buildStartSurveyButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, space20, space57),
      child: Row(
        children: [
          const Expanded(
            child: SizedBox.shrink(),
          ),
          FlatButtonText(
            text: context.localization.survey_details_start_survey_button,
            isEnabled: true,
            onPressed: () => {}, // TODO Start survey
          ),
        ],
      ),
    );
  }
}
