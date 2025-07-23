import 'package:checkit/features/home_screen/core/models/task_db_model.dart';
import 'package:flutter/material.dart';

import 'package:checkit/features/task_detail_screen/components/task_detail_screen_component.dart';

class TaskDetailScreenContainer extends StatelessWidget {
  final TaskModel task;
  const TaskDetailScreenContainer({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return TaskDetailScreenComponent(task: task,);
  }
}
