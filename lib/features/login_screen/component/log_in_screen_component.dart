import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:checkit/common/widgets/logo.dart';
import 'package:checkit/utils/fontstyles/fontstyles.dart';
import 'package:checkit/utils/constants/app_constants.dart';
import 'package:checkit/common/widgets/reusable_button.dart';
import 'package:checkit/common/widgets/reusable_snackbar.dart';
import 'package:checkit/common/widgets/reusable_textfields.dart';
import 'package:checkit/common/taransitions/custom_page_fade_transition.dart';
import 'package:checkit/features/login_screen/core/provider/login_provider.dart';
import 'package:checkit/features/login_screen/widgets/phone_number_section.dart';
import 'package:checkit/features/settings_screen/core/providers/theme_provider.dart';
import 'package:checkit/features/otp_verification_screen/containers/otp_verfication_container.dart';

class LogInScreenComponent extends ConsumerWidget {
  LogInScreenComponent({super.key});

  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  String? fullPhoneNumber;

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

        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 100),
                Text(
                  AppConstants.welcome,
                  style: Fontstyles.roboto35px(context, ref),
                ),
                SizedBox(height: 20),
                Text(
                  AppConstants.enterYourName,
                  style: Fontstyles.roboto16pxLight(context, ref),
                ),
                ReusableTextfield(
                  ref: ref,
                  hinttext: AppConstants.name,
                  readOnly: false,
                  controller: nameController,
                  filledColor: color.background,
                  showBorder: true,
                ),
                SizedBox(height: 20),
                Text(
                  AppConstants.enterYourPhoneNunmber,
                  style: Fontstyles.roboto16pxLight(context, ref),
                ),
                SizedBox(height: 10),
                PhoneNumberSection(
                  onPhoneNumberChanged: (value) {
                    fullPhoneNumber = value;
                  },
                ),
                SizedBox(height: 30),
                ReusableButton(
                  buttonText: AppConstants.logIn,
                  onpressed: () {
                    if (fullPhoneNumber != null &&
                        nameController.text.trim().isNotEmpty) {
                      final loginDB = ref.read(logInProvider);

                      loginDB.sendOTP(
                        phoneNumber: fullPhoneNumber!,
                        userName: nameController.text.trim(),
                        onCodeSent: (verificationId) {
                          ref.read(verificationIDProvider.notifier).state =
                              verificationId;
                          Navigator.of(context).pushReplacement(
                            CustomFadeTransition(
                              route: OtpVerficationContainer(
                                userName: nameController.text.trim(),
                              ),
                            ),
                          );
                        },
                        onFailed: (e) {
                          ShowCustomSnackbar().showSnackbar(
                            context,
                            "Error: ${e.message}",
                            color.errorColor,
                            ref,
                          );
                        },
                      );
                    } else {
                      ShowCustomSnackbar().showSnackbar(
                        context,
                        AppConstants.enterAllTheDetails,
                        color.errorColor,
                        ref,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
