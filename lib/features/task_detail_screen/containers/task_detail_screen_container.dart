import 'package:flutter/material.dart';

import 'package:checkit/features/task_detail_screen/components/task_detail_screen_component.dart';

class TaskDetailScreenContainer extends StatelessWidget {
  final String taskId;
  final bool? done;
  const TaskDetailScreenContainer({super.key, required this.taskId, this.done = true});

  @override
  Widget build(BuildContext context) {
    return TaskDetailScreenComponent(taskId: taskId,done: done,);
  }
}
