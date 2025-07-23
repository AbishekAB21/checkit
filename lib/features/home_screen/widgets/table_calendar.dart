import 'package:flutter/material.dart';

import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:checkit/utils/fontstyles/fontstyles.dart';
import 'package:checkit/features/settings_screen/core/providers/theme_provider.dart';
import 'package:checkit/features/home_screen/core/providers/home_screen_provider.dart';

class CalendarWidget extends ConsumerWidget {
  const CalendarWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDay = ref.watch(selectedDateProvider);
    final color = ref.watch(themeProvider);
    return TableCalendar(
      calendarStyle: CalendarStyle(
        todayDecoration: BoxDecoration(
          color: color.teritiaryColor,
          shape: BoxShape.circle,
        ),
        weekendTextStyle: Fontstyles.holidayTextstyle(context, ref),
        holidayTextStyle: Fontstyles.holidayTextstyle(context, ref),
      ),
      calendarFormat: CalendarFormat.week,
      headerVisible: false,
      focusedDay: selectedDay,
      selectedDayPredicate: (day) => isSameDay(day, selectedDay),
      firstDay: DateTime.utc(2010, 10, 01),
      lastDay: DateTime.utc(2030, 3, 14),
      onDaySelected: (selected, focusedDay) {
        ref.read(selectedDateProvider.notifier).state = selected;
      },
    );
  }
}
