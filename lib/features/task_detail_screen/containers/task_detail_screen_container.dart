import 'package:flutter/material.dart';

import 'package:checkit/features/home_screen/core/models/task_db_model.dart';
import 'package:checkit/features/task_detail_screen/components/task_detail_screen_component.dart';

class TaskDetailScreenContainer extends StatelessWidget {
  final TaskModel task;
  final bool? done;
  const TaskDetailScreenContainer({super.key, required this.task, this.done = true});

  @override
  Widget build(BuildContext context) {
    return TaskDetailScreenComponent(task: task,done: done,);
  }
}
