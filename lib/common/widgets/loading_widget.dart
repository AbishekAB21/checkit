import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:checkit/features/settings_screen/core/providers/theme_provider.dart';

class LoadingWidget extends ConsumerWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final color = ref.watch(themeProvider);
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.textfieldBackground.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: CircularProgressIndicator(
          color: color.secondaryGradient1,
          trackGap: 2.0,
        ),
      ),
    );
  }
}