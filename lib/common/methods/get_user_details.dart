import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GetUserDetails {
  Future<String?> getuserName() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final doc =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .get();

      if(doc.exists){
        return doc.data()?['name'];
      }
    }

    return null;
  }
}
