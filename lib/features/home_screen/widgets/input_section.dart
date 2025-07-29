import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:checkit/utils/fontstyles/fontstyles.dart';
import 'package:checkit/utils/constants/app_constants.dart';
import 'package:checkit/common/methods/date_time_picker.dart';
import 'package:checkit/common/widgets/reusable_textfields.dart';
import 'package:checkit/common/widgets/segmented_button_widget.dart';
import 'package:checkit/features/home_screen/core/models/task_db_model.dart';
import 'package:checkit/features/home_screen/core/providers/home_screen_provider.dart';

class InputSection extends ConsumerStatefulWidget {
  final WidgetRef ref;
  final TaskModel? existingTask;
  const InputSection({super.key, required this.ref, this.existingTask});

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

    // Safely update the provider after widget build is complete
    Future.microtask(() {
      if (widget.existingTask != null) {
        final task = widget.existingTask!;
        final notifier = widget.ref.read(homeScreenProvider.notifier);

        notifier.setTitle(task.title);
        notifier.setDesc(task.description);
        notifier.setDate(task.date);
        notifier.setTime(task.time);
        notifier.setPriority(task.priority);

        taskNameController.text = task.title;
        taskDescController.text = task.description;
        taskDateController.text = task.date;
        taskTimeController.text = task.time;
      }
    });
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
        Text(AppConstants.title, style: Fontstyles.roboto15px(context, ref)),
        ReusableTextfield(
          controller: taskNameController,
          ref: ref,
          hinttext: AppConstants.taskName,
          suffixIcon: null,
          readOnly: false,
          onChanged:
              (val) => ref.read(homeScreenProvider.notifier).setTitle(val),
        ),

        SizedBox(height: 16),

        Text(
          AppConstants.description,
          style: Fontstyles.roboto15px(context, ref),
        ),
        ReusableTextfield(
          controller: taskDescController,
          ref: ref,
          maxlines: 5,
          hinttext: AppConstants.taskDescription,
          suffixIcon: null,
          readOnly: false,
          onChanged:
              (val) => ref.read(homeScreenProvider.notifier).setDesc(val),
        ),

        SizedBox(height: 16),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppConstants.date,
                    style: Fontstyles.roboto15px(context, ref),
                  ),
                  ReusableTextfield(
                    controller: taskDateController,
                    ref: ref,
                    hinttext: AppConstants.date,
                    suffixIcon: Icon(Icons.calendar_month_rounded),
                    readOnly: true,
                    onTap:
                        () => DateTimePicker.pickDate(
                          context: context,
                          controller: taskDateController,
                          ref: ref,
                        ),
                    onChanged:
                        (val) =>
                            ref.read(homeScreenProvider.notifier).setDate(val),
                  ),
                ],
              ),
            ),
            SizedBox(width: 15),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppConstants.time,
                    style: Fontstyles.roboto15px(context, ref),
                  ),
                  ReusableTextfield(
                    controller: taskTimeController,
                    ref: ref,
                    hinttext: AppConstants.time,
                    suffixIcon: Icon(Icons.alarm),
                    readOnly: true,
                    onTap: () async {
                      // Ensure the user has selected a date first
                      if (taskDateController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Please pick a date first.")),
                        );
                        return;
                      }

                      // Parse the picked date from the text controller
                      final parts = taskDateController.text.split('-');
                      final pickedDate = DateTime(
                        int.parse(parts[0]),
                        int.parse(parts[1]),
                        int.parse(parts[2]),
                      );

                      await DateTimePicker.pickTime(
                        context: context,
                        controller: taskTimeController,
                        ref: ref,
                        pickedDate: pickedDate,
                      );
                    },

                    onChanged:
                        (val) =>
                            ref.read(homeScreenProvider.notifier).setTime(val),
                  ),
                ],
              ),
            ),
          ],
        ),

        SizedBox(height: 16),

        Text(AppConstants.priority, style: Fontstyles.roboto15px(context, ref)),

        // Segmented buttons section
        Center(child: SegmentedButtonWidget(buttons: priorities)),
      ],
    );
  }
}
