import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:checkit/common/widgets/logo.dart';
import 'package:checkit/utils/fontstyles/fontstyles.dart';
import 'package:checkit/utils/constants/app_constants.dart';
import 'package:checkit/common/widgets/reusable_button.dart';
import 'package:checkit/common/taransitions/custom_page_fade_transition.dart';
import 'package:checkit/features/settings_screen/core/providers/theme_provider.dart';
import 'package:checkit/features/login_screen/container/log_in_screen_container.dart';

class WelcomeScreenComponent extends ConsumerWidget {
  const WelcomeScreenComponent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = ref.watch(themeProvider);

    return Scaffold(
      backgroundColor: color.background,

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Logo(height: 40, width: 40, iconSize: 20),
                    SizedBox(width: 5.0),
                    Text(
                      AppConstants.appName,
                      style: Fontstyles.roboto22px(context, ref),
                    ),
                  ],
                ),

                LottieBuilder.asset(
                  "assets/animations/ceD1ZS54hb.json",
                  height: 490,
                ),

                Text(
                  AppConstants.welcomeToCheckIt,
                  style: Fontstyles.roboto25px(context, ref),
                ),
                Text(
                  AppConstants.planPrioritizeCheck,
                  style: Fontstyles.roboto16pxLight(context, ref),
                ),
                SizedBox(height: 30),

                ReusableButton(
                  buttonText: AppConstants.logIn,
                  onpressed: () {
                    Navigator.of(context).pushReplacement(
                      CustomFadeTransition(route: LogInScreenContainer()),
                    );
                  },
                ),

                SizedBox(height: 20),

                RichText(
                  text: TextSpan(
                    text: AppConstants.newAroundHere,
                    style: Fontstyles.roboto16pxLight(context, ref),
                    children: [
                      TextSpan(
                        text: AppConstants.signUp,
                        style: Fontstyles.roboto16pxSemiBold(context, ref),
                        recognizer:
                            TapGestureRecognizer()
                              ..onTap = () {
                                //  SignUp navigation or logic
                              },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
