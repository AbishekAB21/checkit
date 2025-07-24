import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:checkit/utils/constants/app_constants.dart';
import 'package:checkit/features/home_screen/core/models/task_db_model.dart';

class CompletedTasksDb {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  Stream<List<TaskModel>> getCompletedTasksFromDatabase() {
    final uid = _auth.currentUser?.uid;

    if (uid == null) throw Exception(AppConstants.userNotLoggedIn);

    return _firestore
        .collection('users')
        .doc(uid)
        .collection('completedTasks')
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            return TaskModel.fromMap(doc.data());
          }).toList();
        });
  }
}
