import 'package:flutter/material.dart';
import 'package:survey_flutter_ic/extension/context_extension.dart';
import 'package:survey_flutter_ic/theme/dimens.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Padding(
          padding: const EdgeInsets.all(space20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      // TODO: Integrate with VM to get the current date
                      'Monday, June 15'.toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: fontSize13,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: space4),
                    Text(
                      context.localization.home_today,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: fontSize34,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
              const CircleAvatar(
                backgroundColor: Colors.white,
                radius: circleAvatarProfileSize / 2,
                child: Icon(
                  Icons.person,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
