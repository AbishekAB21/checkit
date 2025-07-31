import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:checkit/features/settings_screen/core/providers/theme_provider.dart';

class Logo extends ConsumerWidget {
  final double width;
  final double height;
  final double iconSize;
  const Logo({
    super.key,
    required this.height,
    required this.width,
    required this.iconSize,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = ref.watch(themeProvider);
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [color.secondaryGradient1, color.secondaryGradient2],
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Image.asset(
        "assets/images/app_logo.png",
        height: iconSize,
        width: iconSize,
      ),
    );
  }
}
