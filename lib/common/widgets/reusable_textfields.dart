import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:checkit/utils/fontstyles/fontstyles.dart';
import 'package:checkit/features/settings_screen/core/providers/theme_provider.dart';

class ReusableTextfield extends StatelessWidget {
  final WidgetRef ref;
  final int? maxlines;
  final String hinttext;
  final Widget? suffixIcon;
  final Color? filledColor;
  final bool? showBorder;
  final void Function()? onTap;
  final bool readOnly;
  final TextEditingController controller;
  const ReusableTextfield({
    super.key,
    required this.ref,
    this.maxlines = 1,
    this.suffixIcon,
    required this.hinttext,
    this.filledColor,
    this.showBorder = false,
    this.onTap,
    required this.readOnly,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final color = ref.watch(themeProvider);
    return Container(
      margin: EdgeInsets.only(top: 5),
      decoration: BoxDecoration(
        //borderRadius: BorderRadius.circular(35),
      ),
      child: TextFormField(
        controller: controller,
        maxLines: maxlines,
        readOnly: readOnly,
        cursorColor: color.iconColor,
        cursorHeight: 15,
        style: Fontstyles.roboto15px(context, ref),
        decoration: InputDecoration(
          suffixIcon:
              suffixIcon != null
                  ? IconButton(
                    enableFeedback: true,
                    onPressed: onTap,
                    icon: suffixIcon!,
                  )
                  : null,
          isDense: true,
          border: OutlineInputBorder(
            borderSide:
                !showBorder!
                    ? BorderSide.none
                    : BorderSide(color: color.textfieldBackground),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: color.iconColor),
          ),
          filled: true,
          fillColor: filledColor ?? color.textfieldBackground2,
          hintText: hinttext,
          hintStyle: Fontstyles.roboto15Hintpx(context, ref),
        ),
      ),
    );
  }
}
