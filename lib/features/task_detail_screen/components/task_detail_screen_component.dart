import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:checkit/utils/fontstyles/fontstyles.dart';
import 'package:checkit/common/widgets/reusable_button.dart';
import 'package:checkit/features/settings_screen/core/providers/theme_provider.dart';

class TaskDetailScreenComponent extends ConsumerWidget {
  const TaskDetailScreenComponent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = ref.watch(themeProvider);

    return Scaffold(
      backgroundColor: color.background,

      appBar: AppBar(
        toolbarHeight: 30,
        backgroundColor: color.background,
        title: Text("Task details", style: Fontstyles.roboto18px(context, ref)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Task title
            Text(
              "Attend a meeting regarding product setup.",
              style: Fontstyles.roboto35px(context, ref),
            ),
            SizedBox(height: 10),

            // Priority indicator
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: color.deleteColor,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Text(
                "High",
                style: Fontstyles.roboto16pxSemiBold(context, ref),
              ),
            ),

            SizedBox(height: 20),

            // Due date
            Text(
              "Due: ${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}",
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
                      "Attend the scheduled team meeting focused on the upcoming product launch. "
                      "Discuss key milestones, assigned responsibilities, and current progress. "
                      "Bring up any challenges or dependencies that need resolution. "
                      "Document meeting notes and share the action items post-discussion.",
                      style: Fontstyles.roboto18px(context, ref),
                    ),
                    SizedBox(height: 30),
                    Text(
                      "Created on: ${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}",
                      style: Fontstyles.roboto15px(context, ref),
                    ),
                    SizedBox(height: 5),
                  ],
                ),
              ),
            ),

            // Button
            ReusableButton(
              buttonText: "Mark as done",
              onpressed: () {
                // delete task from calendar - move to finished tasks section
              },
            ),
          ],
        ),
      ),
    );
  }
}
