import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:checkit/features/settings_screen/core/providers/theme_provider.dart';

class Fontstyles {
  static TextStyle roboto25px(BuildContext context, WidgetRef ref) {
    final color = ref.watch(themeProvider);
    return GoogleFonts.roboto(
      fontSize: 25,
      fontWeight: FontWeight.w900,
      color: color.iconColor,
    );
  }

  static TextStyle roboto22px(BuildContext context, WidgetRef ref) {
    final color = ref.watch(themeProvider);
    return GoogleFonts.roboto(
      fontSize: 22,
      fontWeight: FontWeight.w900,
      color: color.iconColor,
    );
  }

  static TextStyle roboto15px(BuildContext context, WidgetRef ref) {
    final color = ref.watch(themeProvider);
    return GoogleFonts.roboto(
      fontSize: 15,
      fontWeight: FontWeight.w500,
      color: color.iconColor,
    );
  }

  static TextStyle roboto15pxNoColor(BuildContext context, WidgetRef ref) {
    return GoogleFonts.roboto(fontSize: 15, fontWeight: FontWeight.w500);
  }

  static TextStyle roboto18px(BuildContext context, WidgetRef ref) {
    final color = ref.watch(themeProvider);
    return GoogleFonts.roboto(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: color.iconColor,
    );
  }

  static TextStyle roboto16pxLight(BuildContext context, WidgetRef ref) {
    final color = ref.watch(themeProvider);
    return GoogleFonts.roboto(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: color.iconColor,
    );
  }

  static TextStyle roboto16pxSemiBold(BuildContext context, WidgetRef ref) {
    final color = ref.watch(themeProvider);
    return GoogleFonts.roboto(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: color.iconColor,
    );
  }

  static TextStyle roboto10px(BuildContext context, WidgetRef ref) {
    final color = ref.watch(themeProvider);
    return GoogleFonts.roboto(
      fontSize: 10,
      fontWeight: FontWeight.w700,
      color: color.iconColor,
    );
  }

  static TextStyle roboto13px(BuildContext context, WidgetRef ref) {
    final color = ref.watch(themeProvider);
    return GoogleFonts.roboto(
      fontSize: 13,
      fontWeight: FontWeight.w700,
      color: color.iconColor,
    );
  }

  static TextStyle roboto15Hintpx(BuildContext context, WidgetRef ref) {
    final color = ref.watch(themeProvider);
    return GoogleFonts.roboto(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: color.hintTextColor,
    );
  }

  static TextStyle roboto15Fadedpx(BuildContext context, WidgetRef ref) {
    final color = ref.watch(themeProvider);
    return GoogleFonts.roboto(
      fontSize: 15,
      fontWeight: FontWeight.w400,
      color: color.teritiaryColor,
    );
  }

  // Calendar Fontstyles

  // Holiday or Weekend
  static TextStyle holidayTextstyle(BuildContext context, WidgetRef ref) {
    final color = ref.watch(themeProvider);
    return TextStyle(color: color.errorColor);
  }
}
