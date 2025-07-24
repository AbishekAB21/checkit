import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:checkit/utils/fontstyles/fontstyles.dart';
import 'package:checkit/common/widgets/loading_widget.dart';
import 'package:checkit/common/providers/stream_provider.dart';
import 'package:checkit/features/home_screen/widgets/task_widget.dart';
import 'package:checkit/features/home_screen/widgets/table_calendar.dart';
import 'package:checkit/features/home_screen/widgets/welcome_section.dart';
import 'package:checkit/common/taransitions/custom_page_fade_transition.dart';
import 'package:checkit/features/home_screen/widgets/add_new_task_popup.dart';
import 'package:checkit/features/settings_screen/core/providers/theme_provider.dart';
import 'package:checkit/features/home_screen/core/providers/home_screen_provider.dart';
import 'package:checkit/features/task_detail_screen/containers/task_detail_screen_container.dart';

class HomeScreenComponent extends ConsumerWidget {
  const HomeScreenComponent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = ref.watch(themeProvider);
    final selectedDate = ref.watch(selectedDateProvider);
    final taskStream = ref.watch(taskStreamProvider);

    return Scaffold(
      backgroundColor: color.background,

      appBar: AppBar(backgroundColor: color.background, toolbarHeight: 30),

      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WelcomeTextSection(),

            // Single line Calendar
            SizedBox(height: 20),
            CalendarWidget(),

            SizedBox(height: 30),

            Expanded(
              child: taskStream.when(
                data: (tasks) {
                  final filteredTasks = tasks.where((task) {
                    final taskDate = DateTime.parse(task.date);
                    return isSameDay(taskDate, selectedDate);
                  });

                  if (filteredTasks.isEmpty) {
                    return Center(
                      child: Column(
                        children: [
                          LottieBuilder.asset(
                            height: 300,
                            'assets/animations/empty_animation.json',
                          ),
                          Text('No tasks for this date',style: Fontstyles.roboto15Hintpx(context, ref),),
                        ],
                      ),
                    );
                  }

                  return ListView.separated(
                    itemBuilder: (context, index) {
                      final task = filteredTasks.toList()[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            CustomFadeTransition(
                              route: TaskDetailScreenContainer(task: task,),
                            ),
                          );
                        },
                        child: TaskWidget(priority: task.priority, task: task),
                      );
                    },
                    itemCount: filteredTasks.length,
                    separatorBuilder: (context, index) => SizedBox(height: 20),
                  );
                },
                error: (error, stackTrace) {
                  return Center(child: Column(
                    children: [
                      Icon(Icons.error, color: color.deleteColor,),
                      Text('Something went wrong'),
                    ],
                  ));
                },
                loading: () {
                  return Center(
                    child: LoadingWidget()
                  );
                },
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: color.secondaryGradient1,
        elevation: 3,

        child: Icon(Icons.add_rounded, color: color.background),
        onPressed: () => AddNewTaskPopup().showBottomSheet(context, ref),
      ),
    );
  }
}
