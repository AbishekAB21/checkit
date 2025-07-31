import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:checkit/utils/constants/app_constants.dart';

final profilePicUrlProvider = FutureProvider<String>((ref) async {
  final uid = FirebaseAuth.instance.currentUser?.uid;

  if (uid == null) throw Exception(AppConstants.userNotLoggedIn);

  final doc =
      await FirebaseFirestore.instance.collection('users').doc(uid).get();
  final url = doc.data()?['profilePic'];

  if (url == null || url is! String || url.isEmpty) {
    throw Exception(AppConstants.noPictureFound);
  }

  return url;
});

final profilePicLoadingProvider = StateProvider<bool>((ref) => false);

final profilePicControllerProvider = Provider(
  (ref) => ProfilePicController((ref)),
);

class ProfilePicController {
  final Ref ref;

  ProfilePicController(this.ref);

  final ImagePicker _picker = ImagePicker();

  // Image Upload
  Future<void> pickAndUploadImage() async {
    try {
      ref.read(profilePicLoadingProvider.notifier).state = true;

      final XFile? pickedImage = await _picker.pickImage(
        source: ImageSource.gallery,
      );
      if (pickedImage == null) {
        //User canceled
        ref.read(profilePicLoadingProvider.notifier).state = false;
        return;
      }

      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid == null) {
        return;
      }
      // Saving to Firebase Storage and getting download URL
      final file = File(pickedImage.path);
      final storageRef = FirebaseStorage.instance.ref().child(
        'profilePics/$uid.jpg',
      );
      await storageRef.putFile(file);
      final downloadUrl = await storageRef.getDownloadURL();

      // Saving to Firestore
      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'profilePic': downloadUrl,
      });
      ref.invalidate(profilePicUrlProvider);
    } catch (e) {
      // Print here
    } finally {
      ref.read(profilePicLoadingProvider.notifier).state = false;
    }
  }
}
