import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:checkit/utils/constants/app_constants.dart';
import 'package:checkit/common/widgets/reusable_snackbar.dart';
import 'package:checkit/features/settings_screen/core/providers/theme_provider.dart';
import 'package:checkit/features/home_screen/core/providers/home_screen_provider.dart';

class DateTimePicker {
  // Date picker
  static Future<DateTime?> pickDate({
    required BuildContext context,
    required TextEditingController controller,
    required WidgetRef ref,
  }) async {
    final color = ref.watch(themeProvider);
    final today = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      firstDate: today,
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              surface: color.textfieldBackground,
              primary: color.secondaryGradient1,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      final formattedDate =
          "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
      controller.text = formattedDate;
      ref.read(homeScreenProvider.notifier).setDate(formattedDate);
    }

    return pickedDate;
  }

  // Time picker
  static Future<void> pickTime({
    required BuildContext context,
    required TextEditingController controller,
    required WidgetRef ref,
    required DateTime pickedDate,
  }) async {
    final color = ref.watch(themeProvider);
    final currentTime = TimeOfDay.now();
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: currentTime,
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              surface: color.textfieldBackground,
              primary: color.secondaryGradient1,
              tertiary: color.teritiaryColor,
            ),
          ),
          child: child!,
        );
      },
    );

    if (!context.mounted) return;

    if (pickedTime != null) {
      final timeNow = DateTime.now();
      final selectedDateTime = DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
        pickedTime.hour,
        pickedTime.minute,
      );

      final isToday =
          pickedDate.year == timeNow.year &&
          pickedDate.month == timeNow.month &&
          pickedDate.day == timeNow.day;

      if ((isToday && selectedDateTime.isAfter(timeNow)) || !isToday) {
        final formattedTime = pickedTime.format(context);
        controller.text = formattedTime;
        ref.read(homeScreenProvider.notifier).setTime(formattedTime);
      } else {
        ShowCustomSnackbar().showSnackbar(
          context,
          AppConstants.futureTime,
          color.errorColor,
          ref,
        );
      }
    }
  }

  String monthName(int month) {
    const months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec",
    ];
    return months[month - 1];
  }

  DateTime parseTaskDateTime(String date, String time) {
    final combined = "$date $time"; // e.g., "2025-07-30 9:30 AM"
    return DateFormat("yyyy-MM-dd h:mm a").parse(combined);
  }

  String formatCreatedOn(String createdOnString) {
    final dateTime = DateTime.parse(createdOnString);
    final formatter = DateFormat('d MMM \'at\' h:mm a');
    return formatter.format(dateTime);
  }
}
