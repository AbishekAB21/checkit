import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:checkit/utils/fontstyles/fontstyles.dart';
import 'package:checkit/features/settings_screen/core/providers/theme_provider.dart';
import 'package:checkit/features/home_screen/core/providers/home_screen_provider.dart';

class SegmentedButtonWidget extends ConsumerWidget {
  final List<String> buttons;
  const SegmentedButtonWidget({super.key, required this.buttons});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ThemeProvider instance
    final color = ref.watch(themeProvider);

    // HomeScreenProvider instance
    final taskState = ref.watch(homeScreenProvider);

    // For setting priority
    final selectedPriority = taskState.priority;

    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: color.textfieldBackground2,
        borderRadius: BorderRadius.circular(10),
      ),
      child: SegmentedButton(
        showSelectedIcon: false,

        style: ButtonStyle(
          side: WidgetStatePropertyAll(BorderSide.none),
          backgroundColor: WidgetStateProperty.resolveWith<Color?>((
            Set<WidgetState> states,
          ) {
            if (states.contains(WidgetState.selected)) {
              return color.secondaryGradient2;
            }
            return color.textfieldBackground2;
          }),
          foregroundColor: WidgetStatePropertyAll(color.iconColor),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide.none,
            ),
          ),
          elevation: WidgetStatePropertyAll(3),
        ),
        segments:
            buttons
                .map(
                  (priority) => ButtonSegment(
                    value: priority,
                    label: Text(
                      priority,
                      style: Fontstyles.roboto15pxNoColor(context, ref),
                    ),
                  ),
                )
                .toList(),
        selected: {selectedPriority},
        onSelectionChanged: (newPriority) {
          ref.read(homeScreenProvider.notifier).setPriority(newPriority.first);
        },
      ),
    );
  }
}
