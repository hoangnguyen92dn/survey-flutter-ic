import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:survey_flutter_ic/extension/toast_extension.dart';
import 'package:survey_flutter_ic/ui/home/home_header.dart';
import 'package:survey_flutter_ic/ui/home/home_view_model.dart';
import 'package:survey_flutter_ic/ui/home/home_view_state.dart';
import 'package:survey_flutter_ic/ui/surveys/survey_ui_model.dart';
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
      ref.read(homeViewModelProvider.notifier).getProfile();
      ref.read(homeViewModelProvider.notifier).getSurveys();
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<HomeViewState>(homeViewModelProvider, (_, state) {
      state.maybeWhen(
        error: (message) => showToastMessage(message),
        orElse: () => {},
      );
    });
    bool isLoadingProfile = ref.watch(profileStream).value == null;
    bool isLoadingSurveys = ref.watch(surveysStream).value == null;
    return Scaffold(
        body: (isLoadingProfile && isLoadingSurveys)
            ? const SurveyShimmerLoading()
            : _buildHomeContent(ref.watch(surveysStream).value ?? []));
  }

  Widget _buildHomeContent(List<SurveyUiModel> surveys) => Consumer(
        builder: (context, ref, child) {
          final profile = ref.watch(profileStream).value;
          final today = ref.watch(todayStream).value;
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
                  // TODO: Navigate to survey details
                },
              ),
              SafeArea(
                child: HomeHeader(
                  date: today ?? '',
                  avatar: profile?.avatarUrl ?? '',
                ),
              ),
              _buildPagerIndicator(surveys.length),
            ],
          );
        },
      );

  Widget _buildPagerIndicator(int pagerIndicatorSize) => Consumer(
        builder: (context, ref, child) {
          final visibleIndex = ref.watch(visibleIndexStream).value ?? 0;
          return Positioned(
            bottom: 206,
            child: PagerIndicator(
              pagerIndicatorSize: pagerIndicatorSize,
              visibleIndex: visibleIndex,
            ),
          );
        },
      );
}
