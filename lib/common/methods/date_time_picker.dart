import 'package:checkit/utils/constants/app_constants.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:checkit/common/widgets/reusable_snackbar.dart';
import 'package:checkit/features/settings_screen/core/providers/theme_provider.dart';
import 'package:checkit/features/home_screen/core/providers/home_screen_provider.dart';

class DateTimePicker {
  // Date picker
  static Future<void> pickDate({
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
          "${pickedDate.year} - ${pickedDate.month.toString().padLeft(2, '0')} - ${pickedDate.day.toString().padLeft(2, '0')}";
      controller.text = formattedDate;
      ref.read(homeScreenProvider.notifier).setDate(formattedDate);
    }
  }

  // Time picker
  static Future<void> pickTime({
    required BuildContext context,
    required TextEditingController controller,
    required WidgetRef ref,
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
        timeNow.year,
        timeNow.month,
        timeNow.day,
        pickedTime.hour,
        pickedTime.minute,
      );

      if (selectedDateTime.isAfter(timeNow)) {
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
}
