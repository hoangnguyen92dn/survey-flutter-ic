import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:survey_flutter_ic/extension/context_extension.dart';
import 'package:survey_flutter_ic/theme/dimens.dart';

const _animationDurationInMilliseconds = 2000;

class SurveySubmissionSuccessScreen extends StatefulWidget {
  const SurveySubmissionSuccessScreen({Key? key}) : super(key: key);

  @override
  State<SurveySubmissionSuccessScreen> createState() =>
      _SurveySubmissionSuccessScreenState();
}

class _SurveySubmissionSuccessScreenState
    extends State<SurveySubmissionSuccessScreen> with TickerProviderStateMixin {
  late final AnimationController _controller;
  bool _messageVisible = false;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: _animationDurationInMilliseconds),
    );
    Future.delayed(
        const Duration(milliseconds: _animationDurationInMilliseconds), () {
      setState(() {
        _messageVisible = true;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(space20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.network(
              'https://assets2.lottiefiles.com/packages/lf20_pmYw5P.json',
              controller: _controller,
              onLoaded: (composition) {
                _controller.duration = composition.duration;
                _controller.forward().then(
                      (_) => {
                        Future.delayed(
                          const Duration(
                            milliseconds: _animationDurationInMilliseconds,
                          ),
                          () => context.pop(),
                        ),
                      },
                    );
              },
            ),
            const SizedBox(height: space20),
            AnimatedOpacity(
              duration: const Duration(
                milliseconds: _animationDurationInMilliseconds,
              ),
              opacity: _messageVisible ? 1.0 : 0.0,
              child: Text(
                context.localization.survey_submission_success,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: fontSize28,
                  fontWeight: FontWeight.w800,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
