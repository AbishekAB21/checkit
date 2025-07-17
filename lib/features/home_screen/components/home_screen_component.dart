import 'package:checkit/common/taransitions/custom_page_fade_transition.dart';
import 'package:checkit/features/task_detail_screen/containers/task_detail_screen_container.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:checkit/features/home_screen/widgets/task_widget.dart';
import 'package:checkit/features/home_screen/widgets/table_calendar.dart';
import 'package:checkit/features/home_screen/widgets/welcome_section.dart';
import 'package:checkit/features/home_screen/widgets/add_new_task_popup.dart';
import 'package:checkit/features/settings_screen/core/providers/theme_provider.dart';

class HomeScreenComponent extends ConsumerWidget {
  const HomeScreenComponent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = ref.watch(themeProvider);
    return Scaffold(
      backgroundColor: color.background,

      appBar: AppBar(backgroundColor: color.background, toolbarHeight: 30),

      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WelcomeTextSection(name: "Nivi"),

            // Single line Calendar
            SizedBox(height: 20),
            CalendarWidget(),

            /* The selected day's tasks (filtered by time, 
            priorities red:high, yellow:medium white:low) */

            // click each priority to show its details
            SizedBox(height: 30),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        CustomFadeTransition(
                          route: TaskDetailScreenContainer(),
                        ),
                      );
                    },
                    child: TaskWidget(priority: "High"),
                  );
                },
                itemCount: 3,
                separatorBuilder: (context, index) => SizedBox(height: 20),
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
