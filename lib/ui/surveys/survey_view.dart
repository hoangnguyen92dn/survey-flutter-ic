import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:survey_flutter_ic/gen/assets.gen.dart';
import 'package:survey_flutter_ic/model/survey_model.dart';
import 'package:survey_flutter_ic/widget/circle_button.dart';

class SurveyView extends ConsumerStatefulWidget {
  final List<SurveyModel> surveys;
  final Function(int) onPageChanged;
  final Function(SurveyModel) onSurveySelected;

  const SurveyView(
      {Key? key,
      required this.surveys,
      required this.onPageChanged,
      required this.onSurveySelected})
      : super(key: key);

  @override
  ConsumerState<SurveyView> createState() => _SurveyViewState();
}

class _SurveyViewState extends ConsumerState<SurveyView> {
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView.builder(
          controller: _pageController,
          onPageChanged: (index) {
            widget.onPageChanged.call(index);
          },
          itemCount: widget.surveys.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              // TODO: Load image from network
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(Assets.images.bgSplash.path),
                    fit: BoxFit.fill),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      widget.surveys[index].title,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Text(
                            widget.surveys[index].description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                                fontSize: 17,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        const SizedBox(width: 20),
                        CircleButton(
                          onPressed: () => widget.onSurveySelected
                              .call(widget.surveys[index]),
                        ),
                      ],
                    ),
                    const SizedBox(height: 54),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
