import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import 'package:checkit/utils/theme/app_colors.dart';
import 'package:checkit/utils/fontstyles/fontstyles.dart';
import 'package:checkit/utils/constants/app_constants.dart';
import 'package:checkit/common/widgets/reusable_alert_dialog.dart';
import 'package:checkit/common/taransitions/custom_page_fade_transition.dart';
import 'package:checkit/features/settings_screen/widgets/setting_screen_tile.dart';
import 'package:checkit/features/settings_screen/core/providers/theme_provider.dart';
import 'package:checkit/features/settings_screen/widgets/profile_picture_widget.dart';
import 'package:checkit/features/home_screen/core/providers/home_screen_provider.dart';
import 'package:checkit/features/welcome_screen/containers/welcome_screen_container.dart';
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
            Center(child: ProfilePictureWidget()),
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
                      AppConstants.forgotYourname,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Fontstyles.roboto22px(context, ref),
                    ),
                loading: () => CircularProgressIndicator(),
              ),
            ),
            SizedBox(height: 40),

            // Theme
            SettingScreenTile(
              tilename: AppConstants.darkMode,
              tileWidget: CupertinoSwitch(
                value: ref.watch(themeModeProvider) == ThemeMode.dark,
                onChanged: (_) {
                  ref.read(themeModeProvider.notifier).toggleTheme();
                },
                activeTrackColor: appcolor.secondaryGradient1,
              ),
            ),

            // Account details or settings
            SettingScreenTile(
              tilename: AppConstants.completedTasks,
              tileWidget: IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    CustomFadeTransition(route: CompletedTaskScreenContainer()),
                  );
                },
                icon: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: color.iconColor,
                ),
              ),
            ),

            // Log Out
            SettingScreenTile(
              tilename: AppConstants.logOut,
              tileWidget: IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder:
                        (context) => ReusableAlertDialog(
                          mainAlertDialogTitle: AppConstants.areYouSure,
                          onPressedLeft: () async {
                            await DefaultCacheManager().emptyCache();
                            await FirebaseAuth.instance.signOut();
                            ref.invalidate(userNameProvider); // Clears provider
                            Navigator.pushAndRemoveUntil(
                              context,
                              CustomFadeTransition(
                                route: WelcomeScreenContainer(),
                              ),
                              (route) => false,
                            );
                          },
                          onPressedRight: () {
                            Navigator.pop(context);
                          },
                          onPressedLeftTitle: AppConstants.confirm,
                          onPressedRightTitle: AppConstants.cancel,
                        ),
                  );
                },
                icon: Icon(Icons.logout_rounded, color: color.iconColor),
              ),
            ),

            Spacer(),

            Center(
              child: Text(
                AppConstants.version,
                style: Fontstyles.roboto15Hintpx(context, ref),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
