import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:checkit/common/widgets/logo.dart';
import 'package:checkit/features/splash/core/provider/splash_provider.dart';
import 'package:checkit/common/taransitions/custom_page_fade_transition.dart';
import 'package:checkit/features/home_screen/containers/home_screen_container.dart';
import 'package:checkit/features/settings_screen/core/providers/theme_provider.dart';
import 'package:checkit/features/welcome_screen/containers/welcome_screen_container.dart';

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
      final splashAuthCheck = ref.read(splashAuthProvider);

      splashAuthCheck.whenData((isLoggedIn) {
        Navigator.pushReplacement(
          context,
          CustomFadeTransition(
            route:
                isLoggedIn ? HomeScreenContainer() : WelcomeScreenContainer(),
          ),
        );
      });
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
          child: Logo(height: 70, width: 70, iconSize: 50),
        ),
      ),
    );
  }
}
