import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:survey_flutter_ic/extension/context_extension.dart';
import 'package:survey_flutter_ic/extension/toast_extension.dart';
import 'package:survey_flutter_ic/navigation/app_router.dart';
import 'package:survey_flutter_ic/ui/home/home_drawer.dart';
import 'package:survey_flutter_ic/ui/home/home_header.dart';
import 'package:survey_flutter_ic/ui/home/home_view_model.dart';
import 'package:survey_flutter_ic/ui/home/home_widget_id.dart';
import 'package:survey_flutter_ic/ui/surveys/survey_view.dart';
import 'package:survey_flutter_ic/widget/loading_indicator.dart';
import 'package:survey_flutter_ic/widget/pager_indicator.dart';
import 'package:survey_flutter_ic/widget/survey_shimmer_loading.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var _showLoadingIndicator = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 0), () {
      ref.read(homeViewModelProvider.notifier).init();
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(signOutStream, (_, __) {
      context.goNamed(RoutePath.signIn.routeName);
    });
    ref.listen<AsyncValue<bool>>(loadingIndicatorStream, (_, next) {
      setState(() {
        _showLoadingIndicator = next.value ?? false;
      });
    });

    final state = ref.watch(homeViewModelProvider);

    return Scaffold(
      key: _scaffoldKey,
      endDrawer: _buildHomeDrawer(),
      body: state.maybeWhen(
        init: () => const SurveyShimmerLoading(),
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
                  onProfilePressed: () {
                    _scaffoldKey.currentState?.openEndDrawer();
                  },
                ),
              ),
              _buildPagerIndicator(surveys.length, visibleIndex),
              LoadingIndicator(isVisible: _showLoadingIndicator),
            ],
          );
        },
      );

  Widget _buildPagerIndicator(int pagerIndicatorSize, int visibleIndex) {
    return Positioned(
      bottom: 206,
      child: PagerIndicator(
        key: HomeWidgetId.surveysPagerIndicator,
        pagerIndicatorSize: pagerIndicatorSize,
        visibleIndex: visibleIndex,
      ),
    );
  }

  Widget _buildHomeDrawer() => Drawer(
        width: MediaQuery.of(context).size.width * 0.75,
        backgroundColor: Colors.black.withOpacity(0.5),
        child: HomeDrawer(
          onSignOutPressed: () => showDialog(
            context: context,
            builder: (_) => _buildSignOutConfirmationDialog(),
          ),
        ),
      );

  Widget _buildSignOutConfirmationDialog() => AlertDialog(
        title: Text(context.localization.home_sign_out_confirmation_title),
        content: Text(
          context.localization.home_sign_out_confirmation_description,
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              context.pop();
              _scaffoldKey.currentState?.closeEndDrawer();
              ref.read(homeViewModelProvider.notifier).signOut();
            },
            child: Text(
              context.localization.home_sign_out_confirmation_logout,
            ),
          ),
          TextButton(
            onPressed: () => context.pop(),
            child: Text(
              context.localization.home_sign_out_confirmation_cancel,
            ),
          ),
        ],
      );
}
