import 'package:flutter/material.dart';

/// This file manages the Custom Fade Page Transition Animations

class CustomFadeTransition extends PageRouteBuilder {
  final Widget route;
  CustomFadeTransition({required this.route})
    : super(
        pageBuilder: (context, animation, secondaryAnimation) {
          return route;
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final tween = Tween<double>(
            begin: 0,
            end: 1,
          ).animate(CurvedAnimation(parent: animation, curve: Curves.easeIn));
          return FadeTransition(opacity: tween, child: child);
        },
      );
}
