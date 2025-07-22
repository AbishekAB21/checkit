import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:checkit/utils/fontstyles/fontstyles.dart';

class ReusableAlertDialog extends ConsumerWidget {
  final void Function()? onPressedLeft;
  final void Function()? onPressedRight;
  final String onPressedLeftTitle;
  final String onPressedRightTitle;
  final String mainAlertDialogTitle;
  const ReusableAlertDialog({
    super.key,
    required this.onPressedLeft,
    required this.onPressedRight,
    required this.onPressedLeftTitle,
    required this.onPressedRightTitle,
    required this.mainAlertDialogTitle,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Text(
        mainAlertDialogTitle,
        style: Fontstyles.roboto18px(context, ref),
      ),
      actions: [
        TextButton(
          onPressed: onPressedLeft,
          child: Text(
            onPressedLeftTitle,
            style: Fontstyles.roboto13px(context, ref),
          ),
        ),
        TextButton(
          onPressed: onPressedRight,
          child: Text(
            onPressedRightTitle,
            style: Fontstyles.roboto13px(context, ref),
          ),
        ),
      ],
    );
  }
}
