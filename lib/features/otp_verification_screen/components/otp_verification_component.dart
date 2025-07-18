import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'package:checkit/utils/fontstyles/fontstyles.dart';
import 'package:checkit/utils/constants/app_constants.dart';
import 'package:checkit/common/widgets/reusable_button.dart';
import 'package:checkit/common/taransitions/custom_page_fade_transition.dart';
import 'package:checkit/features/home_screen/containers/home_screen_container.dart';
import 'package:checkit/features/settings_screen/core/providers/theme_provider.dart';

class OtpVerificationComponent extends ConsumerWidget {
  const OtpVerificationComponent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = ref.watch(themeProvider);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: color.background,

        appBar: AppBar(
          backgroundColor: color.background,
          toolbarHeight: 30,
          title: Text(
            AppConstants.enterVerificationCode,
            style: Fontstyles.roboto15px(context, ref),
          ),
        ),

        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 10),
              Text(
                AppConstants.weHaveSentOTP,
                style: Fontstyles.roboto13px(context, ref),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40.0),
              PinCodeTextField(
                appContext: context,
                length: 6,
                cursorColor: color.iconColor,
                animationType: AnimationType.scale,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(10),
                  selectedColor: color.secondaryGradient1,
                  inactiveColor: color.textfieldBackground2,
                ),
              ),

              Spacer(),

              ReusableButton(
                buttonText: AppConstants.confirm,
                onpressed: () {
                  Navigator.of(context).pushReplacement(
                    CustomFadeTransition(route: HomeScreenContainer()),
                  );
                },
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
