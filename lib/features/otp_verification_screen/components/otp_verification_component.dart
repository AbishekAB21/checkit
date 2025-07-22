import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'package:checkit/utils/fontstyles/fontstyles.dart';
import 'package:checkit/common/widgets/loading_widget.dart';
import 'package:checkit/utils/constants/app_constants.dart';
import 'package:checkit/common/widgets/reusable_button.dart';
import 'package:checkit/common/widgets/reusable_snackbar.dart';
import 'package:checkit/common/providers/loading_state_provider.dart';
import 'package:checkit/common/taransitions/custom_page_fade_transition.dart';
import 'package:checkit/features/login_screen/core/provider/login_provider.dart';
import 'package:checkit/features/home_screen/containers/home_screen_container.dart';
import 'package:checkit/features/settings_screen/core/providers/theme_provider.dart';
import 'package:checkit/features/otp_verification_screen/core/providers/otp_provider.dart';

class OtpVerificationComponent extends ConsumerWidget {
  final String userName;
  const OtpVerificationComponent({super.key, required this.userName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = ref.watch(themeProvider);
    final loading = ref.watch(authLoadingProvider);
    final otpDB = ref.read(otpProvider);
    final verificationId = ref.read(verificationIDProvider);
    String otpCode = '';

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

        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 15.0,
              ),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      keyboardType: TextInputType.number,
                      animationType: AnimationType.scale,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(10),
                        selectedColor: color.secondaryGradient1,
                        inactiveColor: color.textfieldBackground2,
                      ),
                      onChanged: (value) {
                        otpCode = value;
                      },
                    ),

                    LottieBuilder.asset(
                      height: 400,
                      repeat: true,
                      reverse: true,
                      "assets/animations/otp_animation.json",
                    ),

                    SizedBox(height: 40),

                    ReusableButton(
                      buttonText: AppConstants.confirm,
                      onpressed:
                          ref.watch(authLoadingProvider)
                              ? null
                              : () async {
                                final loading = ref.read(
                                  authLoadingProvider.notifier,
                                );
                                loading.state = true;

                                if (verificationId != null &&
                                    otpCode.length == 6) {
                                  try {
                                    final user = await otpDB.verifyOTP(
                                      verificationID: verificationId,
                                      smsCode: otpCode,
                                      userName: userName,
                                    );

                                    if (user != null) {
                                      Navigator.of(context).pushReplacement(
                                        CustomFadeTransition(
                                          route: HomeScreenContainer(),
                                        ),
                                      );
                                    } else {
                                      ShowCustomSnackbar().showSnackbar(
                                        context,
                                        "Invalid OTP",
                                        color.errorColor,
                                        ref,
                                      );
                                    }
                                  } catch (e) {
                                    ShowCustomSnackbar().showSnackbar(
                                      context,
                                      "Error: ${e.toString()}",
                                      color.errorColor,
                                      ref,
                                    );
                                  } finally {
                                    loading.state = false;
                                  }
                                }
                              },
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
            if(loading)
            Center(
              child: LoadingWidget(),
            )
          ],
        ),
      ),
    );
  }
}
