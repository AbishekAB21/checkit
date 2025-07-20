import 'package:firebase_auth/firebase_auth.dart';

import 'package:checkit/features/otp_verification_screen/core/database/otp_db.dart';

/// This file only handles OTP sending logic
/// Refer [OtpDb] for OTP verification logic

class LoginDb {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Method to send OTP

  Future<void> sendOTP({
    required String phoneNumber,
    required Function(String verificationID) onCodeSent,
    required Function(FirebaseAuthException err) onError,
  }) async {
    await _auth.verifyPhoneNumber(
      verificationCompleted: (PhoneAuthCredential credentials) {},
      verificationFailed: onError,
      codeSent: (String verificationID, int? resendToken) {
        onCodeSent(verificationID);
      },
      codeAutoRetrievalTimeout: (String verificationID) {},
    );
  }
}
