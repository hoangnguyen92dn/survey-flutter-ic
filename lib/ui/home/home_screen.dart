import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:survey_flutter_ic/extension/date_extension.dart';
import 'package:survey_flutter_ic/extension/toast_extension.dart';
import 'package:survey_flutter_ic/model/survey_model.dart';
import 'package:survey_flutter_ic/theme/dimens.dart';
import 'package:survey_flutter_ic/ui/home/home_header.dart';
import 'package:survey_flutter_ic/ui/home/home_view_model.dart';
import 'package:survey_flutter_ic/ui/home/home_view_state.dart';
import 'package:survey_flutter_ic/ui/surveys/survey_view.dart';
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
          success: () => {},
          loading: () {},
          error: (message) => {showToastMessage(message)},
          orElse: () => {});
    });
    bool isLoading = ref.watch(profileStream).value == null;
    return Scaffold(
        body: isLoading
            ? const SurveyShimmerLoading()
            : _buildHomeContent(mockSurveys));
  }

  Widget _buildHomeContent(List<SurveyModel> surveys) {
    final profile = ref.watch(profileStream).value;
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
            date: DateTime.now().getFormattedString(),
            avatar: profile?.avatarUrl ?? '',
          ),
        ),
        _pagerIndicator(mockSurveys),
      ],
    );
  }

  Widget _pagerIndicator(List<SurveyModel> surveys) {
    final visibleIndex = ref.watch(visibleIndexStream).value ?? 0;
    return Positioned(
      bottom: 206,
      child: SizedBox(
        height: 50,
        child: Padding(
          padding: const EdgeInsets.all(space20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: List.generate(
              surveys.length,
              (index) {
                return Container(
                  width: pagerIndicatorSize,
                  height: pagerIndicatorSize,
                  margin: const EdgeInsets.symmetric(horizontal: space5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: visibleIndex == index
                        ? Colors.white
                        : Colors.white.withOpacity(0.2),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
