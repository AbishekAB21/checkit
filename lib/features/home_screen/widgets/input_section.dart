import 'package:checkit/common/methods/date_time_picker.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:checkit/utils/fontstyles/fontstyles.dart';
import 'package:checkit/common/widgets/reusable_textfields.dart';
import 'package:checkit/common/widgets/segmented_button_widget.dart';

class InputSection extends ConsumerWidget {
  final WidgetRef ref;
  InputSection({super.key, required this.ref});

  final List<String> priorities = ['Low', 'Medium', 'High'];

  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController taskDescController = TextEditingController();
  final TextEditingController taskDateController = TextEditingController();
  final TextEditingController taskTimeController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Title", style: Fontstyles.roboto15px(context, ref)),
        ReusableTextfield(
          controller: taskNameController,
          ref: ref,
          hinttext: "Task name",
          suffixIcon: null,
          readOnly: false,
        ),

        SizedBox(height: 16),

        Text("Description", style: Fontstyles.roboto15px(context, ref)),
        ReusableTextfield(
          controller: taskDescController,
          ref: ref,
          maxlines: 5,
          hinttext: "Task description",
          suffixIcon: null,
          readOnly: false,
        ),

        SizedBox(height: 16),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Date", style: Fontstyles.roboto15px(context, ref)),
                  ReusableTextfield(
                    controller: taskDateController,
                    ref: ref,
                    hinttext: "Date",
                    suffixIcon: Icon(Icons.calendar_month_rounded),
                    readOnly: true,
                    onTap:
                        () => DateTimePicker.pickDate(
                          context: context,
                          controller: taskDateController,
                          ref: ref,
                        ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 15),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Time", style: Fontstyles.roboto15px(context, ref)),
                  ReusableTextfield(
                    controller: taskTimeController,
                    ref: ref,
                    hinttext: "Time",
                    suffixIcon: Icon(Icons.alarm),
                    readOnly: true,
                    onTap:
                        () => DateTimePicker.pickTime(
                          context: context,
                          controller: taskTimeController,
                          ref: ref,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),

        SizedBox(height: 16),

        Text("Priority", style: Fontstyles.roboto15px(context, ref)),

        // Segmented buttons section
        Center(child: SegmentedButtonWidget(buttons: priorities)),
      ],
    );
  }
}
