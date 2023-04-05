import 'package:flutter/material.dart';
import 'package:survey_flutter_ic/gen/assets.gen.dart';

class WhiteRightArrowButton extends StatelessWidget {
  final VoidCallback onPressed;

  const WhiteRightArrowButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      elevation: 0,
      fillColor: Colors.white,
      padding: const EdgeInsets.all(15.0),
      shape: const CircleBorder(),
      child: Assets.images.icArrowRight.svg(),
    );
  }
}
