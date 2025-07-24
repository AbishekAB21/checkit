import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:checkit/utils/fontstyles/fontstyles.dart';
import 'package:checkit/utils/constants/app_constants.dart';
import 'package:checkit/common/widgets/reusable_button.dart';
import 'package:checkit/common/methods/date_time_picker.dart';
import 'package:checkit/common/widgets/reusable_snackbar.dart';
import 'package:checkit/features/home_screen/core/models/task_db_model.dart';
import 'package:checkit/features/settings_screen/core/providers/theme_provider.dart';
import 'package:checkit/features/task_detail_screen/core/database/task_detail_db.dart';

class TaskDetailScreenComponent extends ConsumerWidget {
  final TaskModel task;
  final bool? done;
  const TaskDetailScreenComponent({super.key, required this.task, this.done = true});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = ref.watch(themeProvider);
    final taskDate = DateTime.parse(task.date);
    final dateText =
        "${taskDate.day} ${DateTimePicker().monthName(taskDate.month)}";

    return Scaffold(
      backgroundColor: color.background,

      appBar: AppBar(
        toolbarHeight: 45,
        backgroundColor: color.background,
        title: Text(
          AppConstants.taskDetails,
          style: Fontstyles.roboto18px(context, ref),
        ),
        actions: [
          // Edit Task
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert_rounded, color: color.iconColor),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Task title
            Text(task.title, style: Fontstyles.roboto35px(context, ref)),
            SizedBox(height: 10),

            // Priority indicator
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: color.deleteColor,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Text(
                task.priority,
                style: Fontstyles.roboto16pxSemiBold(context, ref),
              ),
            ),

            SizedBox(height: 20),

            // Due date
            Text(
              "${AppConstants.due}: $dateText",
              style: Fontstyles.roboto15px(context, ref),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 1.8,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              color.textfieldBackground2.withValues(alpha: 0.43),
              color.textfieldBackground,
            ],
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Scrollable content in Expanded
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.description,
                      style: Fontstyles.roboto18px(context, ref),
                    ),
                    SizedBox(height: 30),
                    Text(
                      "${AppConstants.createdOn}: $dateText at ${task.time}",
                      style: Fontstyles.roboto15px(context, ref),
                    ),
                    SizedBox(height: 5),
                  ],
                ),
              ),
            ),

            // Button
            Visibility(
              visible: done ?? true,
              child: ReusableButton(
                buttonText: AppConstants.markAsDone,
                onpressed: () {
                  // delete task from calendar - move to finished tasks section
                  try {
                    TaskDetailDb().moveToCompletedTasks(task.taskId);
                    Navigator.pop(context);
                  } catch (e) {
                    ShowCustomSnackbar().showSnackbar(
                      context,
                      "Error: $e",
                      color.errorColor,
                      ref,
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
