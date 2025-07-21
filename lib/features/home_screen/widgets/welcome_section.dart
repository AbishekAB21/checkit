import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:checkit/utils/theme/app_colors.dart';
import 'package:checkit/utils/fontstyles/fontstyles.dart';
import 'package:checkit/utils/constants/app_constants.dart';
import 'package:checkit/common/taransitions/custom_page_fade_transition.dart';
import 'package:checkit/features/home_screen/core/providers/home_screen_provider.dart';
import 'package:checkit/features/settings_screen/container/settings_screen_container.dart';

class WelcomeTextSection extends ConsumerWidget {
  const WelcomeTextSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final username = ref.watch(userNameProvider);

    return username.when(
      data:
          (name) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${AppConstants.hi}, ${name ?? "User"}",
                style: Fontstyles.roboto25px(context, ref),
              ),
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
          ),
      error:
          (error, stack) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Looks like we forgot your name -_-",
                style: Fontstyles.roboto25px(context, ref),
              ),
            ],
          ),
      loading: () => CircularProgressIndicator(),
    );
  }
}
