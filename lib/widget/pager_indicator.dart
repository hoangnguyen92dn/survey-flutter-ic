import 'package:flutter/material.dart';
import 'package:survey_flutter_ic/theme/dimens.dart';

class PagerIndicator extends StatefulWidget {
  final int pagerIndicatorSize;
  final int visibleIndex;

  const PagerIndicator({
    super.key,
    required this.pagerIndicatorSize,
    required this.visibleIndex,
  });

  @override
  State<PagerIndicator> createState() => _PagerIndicatorState();
}

class _PagerIndicatorState extends State<PagerIndicator> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Padding(
        padding: const EdgeInsets.all(space20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: List.generate(
            widget.pagerIndicatorSize,
            (index) {
              return Container(
                width: pagerIndicatorSize,
                height: pagerIndicatorSize,
                margin: const EdgeInsets.symmetric(horizontal: space5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.visibleIndex == index
                      ? Colors.white
                      : Colors.white.withOpacity(0.2),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
