import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:checkit/utils/constants/app_constants.dart';
import 'package:checkit/features/home_screen/core/models/task_db_model.dart';

class CompletedTasksDb {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  // get completd tasks
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

  // delete specific completed task
  Future<void> deleteTaskPermanently(String taskId) async {
    final uid = _auth.currentUser?.uid;

    await _firestore
        .collection('users')
        .doc(uid)
        .collection('completedTasks')
        .doc(taskId)
        .delete();
  }

  // delete all completed tasks
  Future<void> cleanCompletedTasks() async {
    final uid = _auth.currentUser?.uid;

    final collectionRef = _firestore
        .collection('users')
        .doc(uid)
        .collection('completedTasks');
    final querySnapshot = await collectionRef.get();

    for (var task in querySnapshot.docs) {
      await task.reference.delete();
    }
  }
}
