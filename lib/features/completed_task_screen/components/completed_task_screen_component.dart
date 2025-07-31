import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:checkit/utils/fontstyles/fontstyles.dart';
import 'package:checkit/utils/constants/app_constants.dart';
import 'package:checkit/common/widgets/loading_widget.dart';
import 'package:checkit/common/widgets/reusable_snackbar.dart';
import 'package:checkit/common/providers/stream_provider.dart';
import 'package:checkit/common/widgets/reusable_alert_dialog.dart';
import 'package:checkit/common/providers/loading_state_provider.dart';
import 'package:checkit/features/home_screen/widgets/task_widget.dart';
import 'package:checkit/common/taransitions/custom_page_fade_transition.dart';
import 'package:checkit/features/settings_screen/core/providers/theme_provider.dart';
import 'package:checkit/features/completed_task_screen/core/database/completed_tasks_db.dart';
import 'package:checkit/features/task_detail_screen/containers/task_detail_screen_container.dart';

class CompletedTaskScreenComponent extends ConsumerWidget {
  const CompletedTaskScreenComponent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = ref.watch(themeProvider);
    final taskStream = ref.watch(completedTaskStreamProvider);

    return Scaffold(
      backgroundColor: color.background,
      appBar: AppBar(
        backgroundColor: color.background,
        title: Text(
          AppConstants.completedTasks,
          style: Fontstyles.roboto18px(context, ref),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: taskStream.when(
                data: (tasks) {
                  if (tasks.isEmpty) {
                    return Center(child: Text(AppConstants.nothingToSeeHere));
                  }

                  return ListView.separated(
                    itemBuilder: (context, index) {
                      final task = tasks.toList()[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            CustomFadeTransition(
                              route: TaskDetailScreenContainer(
                                taskId: task.taskId,
                                isNotdone: false,
                              ),
                            ),
                          );
                        },
                        onLongPress: () {
                          showDialog(
                            context: context,
                            builder:
                                (context) => ReusableAlertDialog(
                                  onPressedLeft: () => Navigator.pop(context),
                                  onPressedRight: () async {
                                    try {
                                      await CompletedTasksDb()
                                          .deleteTaskPermanently(task.taskId);
                                      if (context.mounted) {
                                        Navigator.pop(context);
                                        ShowCustomSnackbar().showSnackbar(
                                          context,
                                          AppConstants.taskDeleted,
                                          color.successColor,
                                          ref,
                                        );
                                      }
                                    } catch (e) {
                                      if (context.mounted) {
                                        ShowCustomSnackbar().showSnackbar(
                                          context,
                                          AppConstants.somethingWentWrong,
                                          color.errorColor,
                                          ref,
                                        );
                                      }
                                    }
                                  },
                                  onPressedLeftTitle: AppConstants.cancel,
                                  onPressedRightTitle: AppConstants.delete,
                                  mainAlertDialogTitle:
                                      AppConstants.permaDeleteTask,
                                ),
                          );
                        },
                        child: TaskWidget(priority: task.priority, task: task),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 10);
                    },
                    itemCount: tasks.length,
                  );
                },
                error: (error, stackTrace) {
                  return Center(
                    child: Column(
                      children: [
                        Icon(Icons.error, color: color.deleteColor),
                        Text(AppConstants.somethingWentWrong),
                      ],
                    ),
                  );
                },
                loading: () {
                  return Center(child: LoadingWidget());
                },
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: color.secondaryGradient1,
        onPressed: () {
          if (taskStream.hasValue && taskStream.value!.isEmpty) {
            if (context.mounted) {
              ShowCustomSnackbar().showSnackbar(
                context,
                AppConstants.nothingToClear,
                color.warningColor,
                ref,
              );
            }
            return;
          }

          showDialog(
            context: context,
            builder:
                (context) => ReusableAlertDialog(
                  onPressedLeft: () => Navigator.pop(context),
                  onPressedRight: () async {
                    ref.read(authLoadingProvider.notifier).state = true;
                    showDialog(
                      context: context,
                      builder: (context) => LoadingWidget(),
                    );
                    try {
                      await CompletedTasksDb().cleanCompletedTasks();
                      ref.read(authLoadingProvider.notifier).state = false;
                      if (context.mounted) {
                        Navigator.pop(context);
                        Navigator.pop(context);
                        ShowCustomSnackbar().showSnackbar(
                          context,
                          AppConstants.tasksCleared,
                          color.successColor,
                          ref,
                        );
                      }
                    } catch (e) {
                      if (context.mounted) {
                        ShowCustomSnackbar().showSnackbar(
                          context,
                          AppConstants.cannotClearTasks,
                          color.errorColor,
                          ref,
                        );
                      }
                    }
                  },
                  onPressedLeftTitle: AppConstants.cancel,
                  onPressedRightTitle: AppConstants.confirm,
                  mainAlertDialogTitle: AppConstants.thisWillClearCompleted,
                ),
          );
        },
        child: Icon(Icons.cleaning_services_rounded, color: color.iconColor),
      ),
    );
  }
}
