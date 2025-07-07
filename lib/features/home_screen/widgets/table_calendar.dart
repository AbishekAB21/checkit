import 'package:flutter/material.dart';

import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:checkit/utils/fontstyles/fontstyles.dart';
import 'package:checkit/features/settings_screen/core/providers/theme_provider.dart';

class CalendarWidget extends ConsumerWidget {
  const CalendarWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = ref.watch(themeProvider);
    return TableCalendar(
      calendarStyle: CalendarStyle(
        todayDecoration: BoxDecoration(
          color: color.teritiaryColor,
          borderRadius: BorderRadius.circular(20),
        ),
        weekendTextStyle: Fontstyles.holidayTextstyle(context, ref),
        holidayTextStyle: Fontstyles.holidayTextstyle(context, ref),
      ),
      calendarFormat: CalendarFormat.week,
      headerVisible: false,
      focusedDay: DateTime.now(),
      firstDay: DateTime.utc(2010, 10, 01),
      lastDay: DateTime.utc(2030, 3, 14),
    );
  }
}
