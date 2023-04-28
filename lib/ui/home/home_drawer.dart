import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:survey_flutter_ic/extension/context_extension.dart';
import 'package:survey_flutter_ic/gen/assets.gen.dart';
import 'package:survey_flutter_ic/theme/dimens.dart';
import 'package:survey_flutter_ic/ui/home/home_view_model.dart';

class HomeDrawer extends ConsumerWidget {
  final VoidCallback onSignOutPressed;

  const HomeDrawer({
    super.key,
    required this.onSignOutPressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileStream).value;
    final profileAvatar = profile?.avatarUrl ?? '';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: space20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 80),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Text(
                  profile?.name ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: fontSize34,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: space5),
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: circleAvatarProfileSize / 2,
                backgroundImage: profileAvatar.isEmpty
                    ? Assets.images.placeholderAvatar.image().image
                    : FadeInImage.assetNetwork(
                            placeholder: Assets.images.placeholderAvatar.path,
                            image: profileAvatar)
                        .image,
              )
            ],
          ),
          const SizedBox(height: space20),
          Divider(color: Colors.white.withOpacity(0.2)),
          const SizedBox(height: space32),
          GestureDetector(
            onTap: () => onSignOutPressed.call(),
            child: Text(
              context.localization.home_sign_out,
              style: TextStyle(
                color: Colors.white.withOpacity(0.5),
                fontSize: fontSize20,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(height: space20),
        ],
      ),
    );
  }
}
