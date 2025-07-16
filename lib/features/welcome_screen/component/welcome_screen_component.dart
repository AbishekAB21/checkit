import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:checkit/common/widgets/logo.dart';
import 'package:checkit/utils/fontstyles/fontstyles.dart';
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
                  Text("CheckIt", style: Fontstyles.roboto22px(context, ref)),
                ],
              ),

              // TODO: Replace with lottie animation and match the size.

              LottieBuilder.asset("assets/animations/ceD1ZS54hb.json",
              height: 500,
              ),
              
              Text(
                "Welcome to CheckIt!",
                style: Fontstyles.roboto25px(context, ref),
              ),
              Text(
                "Plan it. Prioritize it. CheckIt.",
                style: Fontstyles.roboto16pxLight(context, ref),
              ),
              SizedBox(height: 30),

              ReusableButton(
                buttonText: "Log In",
                onpressed: () {
                  Navigator.of(context).pushReplacement(
                    CustomFadeTransition(route: LogInScreenContainer()),
                  );
                },
              ),

              SizedBox(height: 20),

              Text(
                "New around here? Sign Up",
                style: Fontstyles.roboto15px(context, ref),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
