import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:checkit/utils/fontstyles/fontstyles.dart';
import 'package:checkit/features/settings_screen/core/providers/theme_provider.dart';

class ReusableTextfield extends StatelessWidget {
  final WidgetRef ref;
  final int? maxlines;
  final String hinttext;
  const ReusableTextfield({
    super.key,
    required this.ref,
    this.maxlines = 1,
    required this.hinttext,
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
        maxLines: maxlines,
        cursorColor: color.iconColor,
        cursorHeight: 15,
        style: Fontstyles.roboto15px(context, ref),
        decoration: InputDecoration(
          isDense: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10),
          ),
          filled: true,
          fillColor: color.textfieldBackground2,
          hintText: hinttext,
          hintStyle: Fontstyles.roboto15Hintpx(context, ref),
        ),
      ),
    );
  }
}
