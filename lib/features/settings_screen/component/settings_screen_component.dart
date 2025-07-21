import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:checkit/utils/theme/app_colors.dart';
import 'package:checkit/utils/fontstyles/fontstyles.dart';
import 'package:checkit/utils/constants/app_constants.dart';
import 'package:checkit/common/taransitions/custom_page_fade_transition.dart';
import 'package:checkit/features/settings_screen/core/providers/theme_provider.dart';
import 'package:checkit/features/home_screen/core/providers/home_screen_provider.dart';
import 'package:checkit/features/completed_task_screen/containers/completed_task_screen_container.dart';

class SettingsScreenComponent extends ConsumerWidget {
  const SettingsScreenComponent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = ref.watch(themeProvider);
    final userName = ref.watch(userNameProvider);

    return Scaffold(
      backgroundColor: color.background,
      appBar: AppBar(
        backgroundColor: color.background,
        toolbarHeight: 30,
        iconTheme: IconThemeData(color: color.iconColor),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile section
            Center(
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: color.secondaryGradient1,
                  borderRadius: BorderRadius.circular(60),
                ),

                // TODO : Wrap with Inkwell or Gesturedetector to allow changing profile pic
                child: CircleAvatar(
                  backgroundColor: color.secondaryGradient1,
                  backgroundImage: AssetImage("assets/images/cast_test.jpeg"),
                  radius: 50,
                ),
              ),
            ),
            SizedBox(height: 5),
            Center(
              child: userName.when(
                data:
                    (name) => Text(
                      "$name",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Fontstyles.roboto22px(context, ref),
                    ),
                error:
                    (error, stack) => Text(
                      "Forgot your name -_-",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Fontstyles.roboto22px(context, ref),
                    ),
                loading: () => CircularProgressIndicator(),
              ),
            ),
            SizedBox(height: 40),

            // Theme
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppConstants.darkMode,
                  style: Fontstyles.roboto18px(context, ref),
                ),
                CupertinoSwitch(
                  value: ref.watch(themeModeProvider) == ThemeMode.dark,
                  onChanged: (_) {
                    ref.read(themeModeProvider.notifier).toggleTheme();
                  },
                  activeTrackColor: appcolor.secondaryGradient1,
                ),
              ],
            ),

            // Account details or settings
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppConstants.completedTasks,
                  style: Fontstyles.roboto18px(context, ref),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      CustomFadeTransition(
                        route: CompletedTaskScreenContainer(),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: color.iconColor,
                  ),
                ),
              ],
            ),

            Spacer(),

            Center(
              child: Text(
                "Version 1.0",
                style: Fontstyles.roboto15Hintpx(context, ref),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
