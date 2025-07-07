import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:checkit/features/home_screen/widgets/table_calendar.dart';
import 'package:checkit/features/home_screen/widgets/welcome_section.dart';
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
            WelcomeTextSection(name: "Arnold"),

            // Single line Calendar
            SizedBox(height: 20),
            CalendarWidget(),

            /* The selected day's tasks (filtered by time, 
            priorities red:high, yellow:medium white:low) */

            // click each priority to show its details

            Container()

          ],
        ),
      ),
    );
  }
}
