import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:survey_flutter_ic/extension/toast_extension.dart';
import 'package:survey_flutter_ic/navigation/app_router.dart';
import 'package:survey_flutter_ic/ui/home/home_header.dart';
import 'package:survey_flutter_ic/ui/home/home_view_model.dart';
import 'package:survey_flutter_ic/ui/home/home_widget_id.dart';
import 'package:survey_flutter_ic/ui/surveys/survey_view.dart';
import 'package:survey_flutter_ic/widget/pager_indicator.dart';
import 'package:survey_flutter_ic/widget/survey_shimmer_loading.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 0), () {
      ref.read(homeViewModelProvider.notifier).init();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(homeViewModelProvider);

    return Scaffold(
      body: state.maybeWhen(
        loading: () => const SurveyShimmerLoading(),
        success: () => _buildHomeContent(),
        error: (message) => showToastMessage(message),
        orElse: () => const SizedBox.shrink(),
      ),
    );
  }

  Widget _buildHomeContent() => Consumer(
        builder: (context, ref, child) {
          final profile = ref.watch(profileStream).value;
          final today = ref.watch(todayStream).value;
          final surveys = ref.watch(surveysStream).value ?? [];
          final visibleIndex = ref.watch(visibleIndexStream).value ?? 0;
          return Stack(
            children: [
              SurveyView(
                surveys: surveys,
                onPageChanged: (visibleIndex) {
                  ref
                      .read(homeViewModelProvider.notifier)
                      .setVisibleSurveyIndex(visibleIndex);
                },
                onSurveySelected: (survey) {
                  context.goNamed(
                    RoutePath.details.routeName,
                    extra: surveys[visibleIndex],
                  );
                },
              ),
              SafeArea(
                child: HomeHeader(
                  date: today ?? '',
                  avatar: profile?.avatarUrl ?? '',
                ),
              ),
              _buildPagerIndicator(),
            ],
          );
        },
      );

  Widget _buildPagerIndicator() => Consumer(
        builder: (context, ref, child) {
          final visibleIndex = ref.watch(visibleIndexStream).value ?? 0;
          final surveys = ref.watch(surveysStream).value ?? [];
          return Positioned(
            bottom: 206,
            child: PagerIndicator(
              key: HomeWidgetId.surveysPagerIndicator,
              pagerIndicatorSize: surveys.length,
              visibleIndex: visibleIndex,
            ),
          );
        },
      );
}
