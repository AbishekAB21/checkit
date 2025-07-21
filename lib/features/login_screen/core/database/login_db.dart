import 'package:firebase_auth/firebase_auth.dart';

import 'package:checkit/features/otp_verification_screen/core/database/otp_db.dart';

/// This file only handles OTP sending logic
/// Refer [OtpDb] for OTP verification logic

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginDb {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendOTP({
    required String phoneNumber,
    required Function(String verificationId) onCodeSent,
    required Function(FirebaseAuthException e) onFailed,
    required String userName,
  }) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 60),

      verificationCompleted: (PhoneAuthCredential credential) async {
        try {
          final userCredential = await _auth.signInWithCredential(credential);
          final user = userCredential.user;

          if (user != null) {
            final userDoc = _firestore.collection('users').doc(user.uid);
            final docSnapshot = await userDoc.get();

            if (!docSnapshot.exists) {
              await userDoc.set({
                'uid': user.uid,
                'phone': user.phoneNumber,
                'name': userName,
                'createdAt': FieldValue.serverTimestamp(),
              });
            }
          }
        } catch (e) {
          // Optional: handle error
        }
      },

      verificationFailed: onFailed,

      codeSent: (String verificationId, int? resendToken) {
        onCodeSent(verificationId);
      },

      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }
}

