import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:checkit/utils/fontstyles/fontstyles.dart';
import 'package:checkit/common/methods/date_time_picker.dart';
import 'package:checkit/common/widgets/reusable_textfields.dart';
import 'package:checkit/common/widgets/segmented_button_widget.dart';

class InputSection extends ConsumerStatefulWidget {
  final WidgetRef ref;
  const InputSection({super.key, required this.ref});

  @override
  ConsumerState<InputSection> createState() => _InputSectionState();
}

class _InputSectionState extends ConsumerState<InputSection> {
  final List<String> priorities = ['Low', 'Medium', 'High'];

  late final TextEditingController taskNameController;
  late final TextEditingController taskDescController;
  late final TextEditingController taskDateController;
  late final TextEditingController taskTimeController;

  @override
  void initState() {
    super.initState();
    taskNameController = TextEditingController();
    taskDescController = TextEditingController();
    taskDateController = TextEditingController();
    taskTimeController = TextEditingController();
  }

  @override
  void dispose() {
    taskNameController.dispose();
    taskDescController.dispose();
    taskDateController.dispose();
    taskTimeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
