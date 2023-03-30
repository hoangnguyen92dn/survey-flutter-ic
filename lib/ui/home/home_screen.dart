import 'package:flutter/material.dart';
import 'package:survey_flutter_ic/ui/home/home_header.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: SafeArea(
          child: HomeHeader(),
        ),
      );
  }
}
