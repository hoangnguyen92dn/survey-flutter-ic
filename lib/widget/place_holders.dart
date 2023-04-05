import 'package:flutter/material.dart';

class CirclePlaceholder extends StatelessWidget {
  const CirclePlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36.0,
      height: 36.0,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
    );
  }
}

class TextPlaceholder extends StatelessWidget {
  final double width;

  const TextPlaceholder({
    super.key,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Colors.white,
      ),
      width: width,
      height: 24.0,
    );
  }
}
