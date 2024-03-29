import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:survey_flutter_ic/gen/assets.gen.dart';
import 'package:survey_flutter_ic/theme/dimens.dart';
import 'package:survey_flutter_ic/ui/home/home_widget_id.dart';
import 'package:survey_flutter_ic/ui/surveys/survey_ui_model.dart';
import 'package:survey_flutter_ic/widget/white_right_arrow_button.dart';

class SurveyView extends ConsumerStatefulWidget {
  final List<SurveyUiModel> surveys;
  final Function(int) onPageChanged;
  final Function(SurveyUiModel) onSurveySelected;

  const SurveyView({
    super.key,
    required this.surveys,
    required this.onPageChanged,
    required this.onSurveySelected,
  });

  @override
  ConsumerState<SurveyView> createState() => _SurveyViewState();
}

class _SurveyViewState extends ConsumerState<SurveyView> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: PageView.builder(
        controller: _pageController,
        onPageChanged: (index) {
          widget.onPageChanged.call(index);
        },
        itemCount: widget.surveys.length,
        itemBuilder: (_, index) {
          return _buildPageItem(widget.surveys[index]);
        },
      ),
    );
  }

  Widget _buildPageItem(SurveyUiModel survey) {
    return Container(
      key: HomeWidgetId.surveyBackgroundContainer,
      padding: const EdgeInsets.symmetric(horizontal: space20),
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
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _buildSurveyTitle(survey),
          const SizedBox(height: 2),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: _buildSurveyDescription(survey),
              ),
              const SizedBox(width: space20),
              _buildSurveyButton(survey),
            ],
          ),
          const SizedBox(height: 54),
        ],
      ),
    );
  }

  Widget _buildSurveyTitle(SurveyUiModel survey) {
    return Text(
      survey.title,
      key: HomeWidgetId.surveyTitleText,
      style: const TextStyle(
        color: Colors.white,
        fontSize: fontSize28,
        fontWeight: FontWeight.w800,
      ),
    );
  }

  Widget _buildSurveyDescription(SurveyUiModel survey) {
    return Text(
      survey.description,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      key: HomeWidgetId.surveyDescriptionText,
      style: TextStyle(
        color: Colors.white.withOpacity(0.7),
        fontSize: fontSize17,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget _buildSurveyButton(SurveyUiModel survey) {
    return WhiteRightArrowButton(
      key: HomeWidgetId.surveyDetailsButton,
      onPressed: () => widget.onSurveySelected.call(survey),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
