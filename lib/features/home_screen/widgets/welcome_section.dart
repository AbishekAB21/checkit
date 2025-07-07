import 'package:flutter/material.dart';

import 'package:checkit/utils/theme/app_colors.dart';
import 'package:checkit/utils/fontstyles/fontstyles.dart';
import 'package:checkit/common/taransitions/custom_page_fade_transition.dart';
import 'package:checkit/features/settings_screen/container/settings_screen_container.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WelcomeTextSection extends ConsumerWidget {
  final String name;
  const WelcomeTextSection({super.key, required this.name});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Hi, $name", style: Fontstyles.roboto25px(context, ref)),

        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              CustomFadeTransition(route: SettingsScreenContainer()),
            );
          },
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: appcolor.secondaryGradient2,
              image: DecorationImage(
                image: AssetImage("assets/images/cast_test.jpeg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
