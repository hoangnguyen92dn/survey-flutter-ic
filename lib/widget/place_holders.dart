import 'package:flutter/material.dart';
import 'package:survey_flutter_ic/theme/dimens.dart';

class CirclePlaceholder extends StatelessWidget {
  final double size;

  const CirclePlaceholder({super.key, this.size = 36.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
    );
  }
}

class TextPlaceholder extends StatelessWidget {
  final double width;
  final double height;

  const TextPlaceholder({
    super.key,
    required this.width,
    this.height = 24.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius12),
        color: Colors.white,
      ),
      width: width,
      height: height,
    );
  }
}
