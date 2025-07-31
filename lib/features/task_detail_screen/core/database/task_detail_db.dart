import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:checkit/utils/constants/app_constants.dart';

class TaskDetailDb {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Delete task from tasks collection and move it to completed tasks collection

  Future<void> moveToCompletedTasks(String taskId) async {
    final uid = _auth.currentUser?.uid;

    final taskDocRef = _firestore
        .collection('users')
        .doc(uid)
        .collection('tasks')
        .doc(taskId);

    final taskSnapshot = await taskDocRef.get();

    if (!taskSnapshot.exists) {
      throw Exception(AppConstants.taskNotFound);
    }

    final taskData = taskSnapshot.data();

    // Move to completed tasks
    await _firestore
        .collection('users')
        .doc(uid)
        .collection('completedTasks')
        .doc(taskId)
        .set(taskData!);
    
    // Delete from tasks
    taskDocRef.delete();
  }
}
