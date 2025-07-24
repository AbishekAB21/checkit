
import 'package:riverpod/riverpod.dart';

import 'package:checkit/features/home_screen/core/database/home_db.dart';
import 'package:checkit/features/home_screen/core/models/task_db_model.dart';
import 'package:checkit/features/completed_task_screen/core/database/completed_tasks_db.dart';

final taskStreamProvider = StreamProvider<List<TaskModel>>((ref){

  return HomeDb().getDataFromDatabase();
});

final completedTaskStreamProvider = StreamProvider<List<TaskModel>>((ref){

  return CompletedTasksDb().getCompletedTasksFromDatabase();
});