import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:survey_flutter_ic/extension/date_extension.dart';
import 'package:survey_flutter_ic/extension/toast_extension.dart';
import 'package:survey_flutter_ic/ui/home/home_header.dart';
import 'package:survey_flutter_ic/ui/home/home_view_model.dart';
import 'package:survey_flutter_ic/ui/home/home_view_state.dart';

final _loadingStateProvider = StateProvider.autoDispose<bool>((_) => false);
final _profileAvatarProvider = StateProvider.autoDispose<String>((_) => '');

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
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<HomeViewState>(homeViewModelProvider, (_, state) {
      state.maybeWhen(
          getUserProfileSuccess: (profile) => {
                ref.read(_profileAvatarProvider.notifier).state =
                    profile.avatarUrl ?? '',
              },
          loading: () {
            ref.read(_loadingStateProvider.notifier).state = true;
          },
          error: (message) => {
                ref.read(_loadingStateProvider.notifier).state = false,
                showToastMessage(message)
              },
          orElse: () => {});
    });
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: SafeArea(
          child: Consumer(
            builder: (context, widgetRef, _) {
              return HomeHeader(
                date: DateTime.now().getFormattedString(),
                avatar: widgetRef.watch(_profileAvatarProvider),
              );
            },
          ),
        ),
      ),
    );
  }
}
