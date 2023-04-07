import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:survey_flutter_ic/extension/toast_extension.dart';
import 'package:survey_flutter_ic/model/survey_model.dart';
import 'package:survey_flutter_ic/ui/home/home_header.dart';
import 'package:survey_flutter_ic/ui/home/home_view_model.dart';
import 'package:survey_flutter_ic/ui/home/home_view_state.dart';
import 'package:survey_flutter_ic/ui/surveys/survey_view.dart';
import 'package:survey_flutter_ic/widget/pager_indicator.dart';
import 'package:survey_flutter_ic/widget/survey_shimmer_loading.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  // TODO: Remove on integration task
  final mockSurveys = const [
    SurveyModel(
        id: "1",
        title: "Working from home Check-In",
        description:
            "We would like to know how you feel about our work from home",
        isActive: false,
        coverImageUrl: "coverImageUrl",
        createdAt: "createdAt",
        surveyType: "surveyType"),
    SurveyModel(
        id: "2",
        title: "Career training and development",
        description:
            "We would like to know what are your goals and skills you wanted",
        isActive: false,
        coverImageUrl: "coverImageUrl",
        createdAt: "createdAt",
        surveyType: "surveyType"),
    SurveyModel(
        id: "3",
        title: "Inclusion and belonging",
        description:
            "Building a workplace culture that prioritizes belonging and inclusion",
        isActive: false,
        coverImageUrl: "coverImageUrl",
        createdAt: "createdAt",
        surveyType: "surveyType"),
  ];

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 0), () {
      ref.read(homeViewModelProvider.notifier).getProfile();
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
    bool isLoading = ref.watch(profileStream).value == null;
    return Scaffold(
        body: isLoading
            ? const SurveyShimmerLoading()
            : _buildHomeContent(mockSurveys));
  }

  Widget _buildHomeContent(List<SurveyModel> surveys) => Consumer(
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
              _buildPagerIndicator(mockSurveys.length),
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
