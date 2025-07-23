
import 'package:riverpod/riverpod.dart';

import 'package:checkit/features/home_screen/core/database/home_db.dart';
import 'package:checkit/features/home_screen/core/models/task_db_model.dart';

final taskStreamProvider = StreamProvider<List<TaskModel>>((ref){

  return HomeDb().getDataFromDatabase();
});