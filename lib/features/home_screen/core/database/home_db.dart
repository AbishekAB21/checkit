import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:checkit/utils/constants/app_constants.dart';
import 'package:checkit/features/home_screen/core/models/task_db_model.dart';
import 'package:checkit/features/home_screen/components/home_screen_component.dart';

/// Handles database methods for [HomeScreenComponent]

class HomeDb {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  Future<void> addTasksToDatabase(TaskModel task) async {
    final uid = _auth.currentUser?.uid;

    if (uid == null) throw Exception(AppConstants.userNotLoggedIn);

    await _firestore
        .collection('users')
        .doc(uid)
        .collection('tasks')
        .doc(task.taskId)
        .set(task.toMap());
  }

  Future<void> updateExistingTask(TaskModel task) async {
    final uid = _auth.currentUser?.uid;

    if (uid == null) throw Exception(AppConstants.userNotLoggedIn);

    await _firestore
        .collection('users')
        .doc(uid)
        .collection('tasks')
        .doc(task.taskId)
        .update(task.toMap());
  }

  Stream<List<TaskModel>> getDataFromDatabase() {
    final uid = _auth.currentUser?.uid;

    if (uid == null) throw Exception(AppConstants.userNotLoggedIn);

    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('tasks')
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            return TaskModel.fromMap(doc.data());
          }).toList();
        });
  }

  Stream<TaskModel> getTaskByIdStream(String taskId) {
    final uid = _auth.currentUser?.uid;

    if (uid == null) throw Exception(AppConstants.userNotLoggedIn);

    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('tasks')
        .doc(taskId)
        .snapshots()
        .map((docSnapshot) {
          if (docSnapshot.exists && docSnapshot.data() != null) {
            final data = docSnapshot.data();
            return TaskModel.fromMap(data!);
          } else {
            throw Exception(AppConstants.taskNotFound);
          }
        });
  }

    Stream<TaskModel> getCompletedTaskByIdStream(String taskId) {
    final uid = _auth.currentUser?.uid;

    if (uid == null) throw Exception(AppConstants.userNotLoggedIn);

    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('completedTasks')
        .doc(taskId)
        .snapshots()
        .map((docSnapshot) {
          if (docSnapshot.exists && docSnapshot.data() != null) {
            final data = docSnapshot.data();
            return TaskModel.fromMap(data!);
          } else {
            throw Exception(AppConstants.taskNotFound);
          }
        });
  }
}
