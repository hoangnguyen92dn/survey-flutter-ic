import 'package:flutter/material.dart';
import 'package:survey_flutter_ic/extension/context_extension.dart';
import 'package:survey_flutter_ic/gen/assets.gen.dart';
import 'package:survey_flutter_ic/theme/dimens.dart';
import 'package:survey_flutter_ic/ui/home/home_widget_id.dart';

class HomeHeader extends StatefulWidget {
  final String date;
  final String avatar;

  const HomeHeader({super.key, required this.date, required this.avatar});

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
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
                      widget.date,
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
              CircleAvatar(
                key: HomeWidgetId.profileAvatarImage,
                backgroundColor: Colors.white,
                radius: circleAvatarProfileSize / 2,
                backgroundImage: widget.avatar.isEmpty
                    ? Assets.images.placeholderAvatar.image().image
                    : FadeInImage.assetNetwork(
                            placeholder: Assets.images.placeholderAvatar.path,
                            image: widget.avatar)
                        .image,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
