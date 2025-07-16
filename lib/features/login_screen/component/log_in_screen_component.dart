import 'package:checkit/common/taransitions/custom_page_fade_transition.dart';
import 'package:checkit/features/home_screen/containers/home_screen_container.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:checkit/common/widgets/logo.dart';
import 'package:checkit/utils/fontstyles/fontstyles.dart';
import 'package:checkit/common/widgets/reusable_button.dart';
import 'package:checkit/features/login_screen/widgets/phone_number_section.dart';
import 'package:checkit/features/settings_screen/core/providers/theme_provider.dart';

class LogInScreenComponent extends ConsumerWidget {
  LogInScreenComponent({super.key});

  final TextEditingController phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = ref.watch(themeProvider);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: color.background,

        appBar: AppBar(
          backgroundColor: color.background,
          iconTheme: IconThemeData(color: color.iconColor),
          title: Logo(height: 40, width: 40, iconSize: 20),
        ),

        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 100),
            Text("Welcome Back!", style: Fontstyles.roboto22px(context, ref)),
            SizedBox(height: 20),
            Text(
              "Enter your phone number",
              style: Fontstyles.roboto16pxLight(context, ref),
            ),
            SizedBox(height: 10),
            PhoneNumberSection(),
            SizedBox(height: 30),
            ReusableButton(
              buttonText: "Log In",
              onpressed: () {
                Navigator.of(context).pushReplacement(
                  CustomFadeTransition(route: HomeScreenContainer()),
                );
              },
            ),
            SizedBox(height: 10),
            Center(
              child: Text(
                "New around here? SignUp",
                style: Fontstyles.roboto15px(context, ref),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
