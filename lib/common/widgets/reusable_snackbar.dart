import 'package:checkit/utils/fontstyles/fontstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShowCustomSnackbar {
  showSnackbar(
    BuildContext context,
    String message,
    Color backgroundColor,
    WidgetRef ref,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: Fontstyles.roboto15px(context, ref)),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
    );
  }
}
