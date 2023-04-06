import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:survey_flutter_ic/extension/context_extension.dart';
import 'package:survey_flutter_ic/gen/assets.gen.dart';
import 'package:survey_flutter_ic/theme/dimens.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: FadeInImage.assetNetwork(
              placeholder: Assets.images.placeholderAvatar.path,
              image: widget.survey.largeCoverImageUrl.toString(),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: space20),
              child: Text(
                widget.survey.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: fontSize34,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const SizedBox(height: space16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: space20),
              child: Text(
                widget.survey.description,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: fontSize17,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const Expanded(child: SizedBox.shrink()),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                0,
                0,
                space20,
                space57,
              ),
              child: Row(
                children: [
                  const Expanded(
                    child: SizedBox.shrink(),
                  ),
                  FlatButtonText(
                    text:
                        context.localization.survey_details_start_survey_button,
                    isEnabled: true,
                    onPressed: () => {}, // TODO Start survey
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
