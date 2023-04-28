import 'package:flutter/material.dart';

class LoadingIndicator extends StatefulWidget {
  final bool isVisible;

  const LoadingIndicator({
    super.key,
    this.isVisible = true,
  });

  @override
  State<LoadingIndicator> createState() => _LoadingIndicatorState();
}

class _LoadingIndicatorState extends State<LoadingIndicator> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Visibility(
        maintainSize: true,
        maintainAnimation: true,
        maintainState: true,
        visible: widget.isVisible,
        child: Container(
            margin: const EdgeInsets.symmetric(vertical: 50, horizontal: 50),
            child: const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white))),
      ),
    );
  }
}
