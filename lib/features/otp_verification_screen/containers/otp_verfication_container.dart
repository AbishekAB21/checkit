import 'package:flutter/material.dart';

import 'package:checkit/features/otp_verification_screen/components/otp_verification_component.dart';

class OtpVerficationContainer extends StatelessWidget {
  final String userName;
  const OtpVerficationContainer({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return OtpVerificationComponent(userName: userName,);
  }
}