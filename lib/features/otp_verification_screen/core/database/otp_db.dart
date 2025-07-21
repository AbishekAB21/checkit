import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:checkit/features/login_screen/core/database/login_db.dart';

/// This file only handles OTP verification logic
/// Refer [LoginDb] for OTP sending logic

class OtpDb {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> verifyOTP({
    required String verificationID,
    required String smsCode,
    required String userName,
  }) async {
    final credentials = PhoneAuthProvider.credential(
      verificationId: verificationID,
      smsCode: smsCode,
    );

    final userCredential = await _auth.signInWithCredential(credentials);
    final user = userCredential.user;

    // Saving User's name to firebase on initial login
    if (user != null) {
      try {
        final userDoc = FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid);

        final docSnapshot = await userDoc.get();

        if (!docSnapshot.exists) {
          await userDoc.set({
            'uid': user.uid,
            'phone': user.phoneNumber,
            'name': userName,
            'createdAt': FieldValue.serverTimestamp(),
          });
        }
      } catch (e) {
       //
      }
    }

    return user;
  }
}
