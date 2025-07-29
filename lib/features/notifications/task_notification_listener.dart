import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:checkit/common/methods/date_time_picker.dart';
import 'package:checkit/common/providers/stream_provider.dart';
import 'package:checkit/common/methods/notification_service.dart';
import 'package:checkit/features/notifications/provider/schedule_provider.dart';

class TaskNotificationListener extends ConsumerWidget {
  const TaskNotificationListener({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(taskStreamProvider, (previous, next) {
      next.whenData((taskList) async {
        final scheduleID = ref.read(scheduledTaskIdsProvider.notifier);

        for (final task in taskList) {
          final String taskId = task.taskId; // UUID string
          // Combine and parse date and time
          final DateTime scheduledDateTime = DateTimePicker().parseTaskDateTime(
            task.date,
            task.time,
          );

          // Only schedule future tasks and avoid duplicates
          if (scheduledDateTime.isAfter(DateTime.now()) &&
              !scheduleID.state.contains(taskId)) {
            try{
              await NotificationService.scheduleNotification(
              taskId: taskId,
              title: task.title,
              desc: task.description,
              scheduledDate: scheduledDateTime,
            );
            }catch(e){
             //
            }

            // Track Schedule ID to avoid duplicate scheduling
            scheduleID.state = {...scheduleID.state, taskId};
          }
        }
      });
    });
    return const SizedBox.shrink();
  }
}
