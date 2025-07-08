import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:checkit/utils/fontstyles/fontstyles.dart';
import 'package:checkit/common/widgets/reusable_textfields.dart';

class InputSection extends StatelessWidget {
  final WidgetRef ref;
  const InputSection({super.key, required this.ref});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Title", style: Fontstyles.roboto15px(context, ref)),
        ReusableTextfield(ref: ref, hinttext: "Task name"),

        SizedBox(height: 16),

        Text("Description", style: Fontstyles.roboto15px(context, ref)),
        ReusableTextfield(ref: ref, maxlines: 5, hinttext: "Task description"),

        SizedBox(height: 16),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Date", style: Fontstyles.roboto15px(context, ref)),
                  ReusableTextfield(ref: ref, hinttext: "Task description"),
                ],
              ),
            ),
            SizedBox(width: 15),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Time", style: Fontstyles.roboto15px(context, ref)),
                  ReusableTextfield(ref: ref, hinttext: "Task description"),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
