import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:checkit/utils/fontstyles/fontstyles.dart';
import 'package:checkit/utils/constants/app_constants.dart';
import 'package:checkit/common/widgets/loading_widget.dart';
import 'package:checkit/common/providers/stream_provider.dart';
import 'package:checkit/features/home_screen/widgets/task_widget.dart';
import 'package:checkit/common/taransitions/custom_page_fade_transition.dart';
import 'package:checkit/features/settings_screen/core/providers/theme_provider.dart';
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
                              route: TaskDetailScreenContainer(task: task, done: false,),
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
    );
  }
}
