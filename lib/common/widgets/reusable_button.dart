import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:checkit/utils/fontstyles/fontstyles.dart';
import 'package:checkit/features/settings_screen/core/providers/theme_provider.dart';

class ReusableButton extends ConsumerWidget {
  final String buttonText;
  final void Function()? onpressed;
  const ReusableButton({super.key, required this.buttonText, this.onpressed});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = ref.watch(themeProvider);
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(color.secondaryGradient2),
        foregroundColor: WidgetStatePropertyAll(color.iconColor),
        elevation: WidgetStatePropertyAll(3),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
        minimumSize: WidgetStatePropertyAll(
          Size(MediaQuery.of(context).size.width, 50),
        ),
      ),
      onPressed: onpressed,
      child: Text(
        buttonText,
        style: Fontstyles.roboto16pxSemiBold(context, ref),
      ),
    );
  }
}
