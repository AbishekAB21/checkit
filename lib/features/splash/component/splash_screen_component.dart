import 'package:checkit/common/taransitions/custom_page_fade_transition.dart';
import 'package:checkit/features/home_screen/containers/home_screen_container.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:checkit/features/home_screen/components/home_screen_component.dart';
import 'package:checkit/features/settings_screen/core/providers/theme_provider.dart';

class SplashScreenComponent extends ConsumerStatefulWidget {
  const SplashScreenComponent({super.key});

  @override
  ConsumerState<SplashScreenComponent> createState() =>
      _SplashScreenComponentState();
}

class _SplashScreenComponentState extends ConsumerState<SplashScreenComponent> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(
        context,
      ).pushReplacement(CustomFadeTransition(route: HomeScreenContainer()));
    });
  }

  @override
  Widget build(BuildContext context) {
    final color = ref.watch(themeProvider);

    return Scaffold(
      backgroundColor: color.background,
      body: Center(
        child: Material(
          borderRadius: BorderRadius.circular(10),
          elevation: 5,
          child: Container(
            width: 70,
            height: 70,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [color.secondaryGradient1, color.secondaryGradient2],
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(Icons.calendar_month, color: color.iconColor, size: 40),
          ),
        ),
      ),
    );
  }
}
