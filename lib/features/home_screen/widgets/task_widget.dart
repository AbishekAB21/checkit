import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:checkit/utils/fontstyles/fontstyles.dart';
import 'package:checkit/features/settings_screen/core/providers/theme_provider.dart';

class TaskWidget extends ConsumerWidget {
  final String? priority;
  const TaskWidget({super.key, this.priority = "Low"});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = ref.watch(themeProvider);
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [color.textfieldBackground, color.textfieldBackground],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Attend the meeting regarding project set up.",
            style: Fontstyles.roboto18px(context, ref),
            maxLines: 2,
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.calendar_month_rounded),
                  Text(
                    " ${DateTime.now().day} July",
                    style: Fontstyles.roboto15px(context, ref),
                  ),
                ],
              ),
              Icon(
                Icons.priority_high_rounded,
                color: getPriorityColor(priority!, ref),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color getPriorityColor(String priority, WidgetRef ref) {
    final color = ref.watch(themeProvider);

    final String priorityColor = priority.toLowerCase();

    return priorityColor == "high"
        ? color.deleteColor
        : priorityColor == "medium"
        ? color.warningColor
        : color.iconColor;
  }
}
