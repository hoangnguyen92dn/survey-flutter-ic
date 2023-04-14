import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:survey_flutter_ic/theme/dimens.dart';
import 'package:survey_flutter_ic/widget/place_holders.dart';

class SurveyShimmerLoading extends StatelessWidget {
  const SurveyShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Shimmer.fromColors(
        baseColor: Colors.grey.shade500,
        highlightColor: Colors.grey.shade50,
        enabled: true,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: space20,
            vertical: 62,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeaderShimmer(),
              const Expanded(child: SizedBox.shrink()),
              _buildPagerIndicatorPlaceholder(),
              _buildSurveyContent(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderShimmer() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              TextPlaceholder(width: 117.0),
              SizedBox(height: space4),
              TextPlaceholder(width: 97.0),
            ],
          ),
        ),
        const CirclePlaceholder(),
      ],
    );
  }

  Widget _buildPagerIndicatorPlaceholder() {
    return const TextPlaceholder(width: 50);
  }

  Widget _buildSurveyContent(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: space20),
        TextPlaceholder(width: screenWidth * 0.7),
        const SizedBox(height: space4),
        TextPlaceholder(width: screenWidth * 0.4),
        const SizedBox(height: space16),
        TextPlaceholder(width: screenWidth * 0.8),
        const SizedBox(height: space4),
        TextPlaceholder(width: screenWidth * 0.6),
      ],
    );
  }
}
