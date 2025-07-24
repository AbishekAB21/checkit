import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:checkit/utils/fontstyles/fontstyles.dart';
import 'package:checkit/utils/constants/app_constants.dart';
import 'package:checkit/common/widgets/loading_widget.dart';
import 'package:checkit/common/widgets/reusable_snackbar.dart';
import 'package:checkit/common/providers/loading_state_provider.dart';
import 'package:checkit/features/home_screen/core/database/home_db.dart';
import 'package:checkit/features/home_screen/widgets/input_section.dart';
import 'package:checkit/features/home_screen/core/models/task_db_model.dart';
import 'package:checkit/features/settings_screen/core/providers/theme_provider.dart';
import 'package:checkit/features/home_screen/core/providers/home_screen_provider.dart';
import 'package:uuid/uuid.dart';

class AddNewTaskPopup {
  void showBottomSheet(BuildContext context, WidgetRef ref) {
    final color = ref.watch(themeProvider);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: DraggableScrollableSheet(
            expand: false,
            initialChildSize: 0.7,
            maxChildSize: 0.9,
            minChildSize: 0.4,

            builder: (contex, scrollController) {
              final isLoading = ref.watch(authLoadingProvider);
              return Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: color.textfieldBackground,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child:
                    isLoading
                        ? LoadingWidget()
                        : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Buttons
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                    style: ButtonStyle(
                                      foregroundColor: WidgetStatePropertyAll(
                                        color.secondaryGradient1,
                                      ),
                                    ),
                                    onPressed: () => Navigator.pop(context),
                                    child: Text(AppConstants.cancel),
                                  ),
                                  Text(
                                    AppConstants.newTask,
                                    style: Fontstyles.roboto18px(context, ref),
                                  ),
                                  TextButton(
                                    style: ButtonStyle(
                                      foregroundColor: WidgetStatePropertyAll(
                                        color.secondaryGradient1,
                                      ),
                                    ),
                                    onPressed: () async {
                                      // Adding data to database

                                      ref
                                          .read(authLoadingProvider.notifier)
                                          .state = true;

                                      // One time use
                                      final taskState = ref.read(
                                        homeScreenProvider,
                                      );

                                      if (taskState.time.isEmpty ||
                                          taskState.desc.isEmpty ||
                                          taskState.date.isEmpty ||
                                          taskState.time.isEmpty) {
                                        ShowCustomSnackbar().showSnackbar(
                                          context,
                                          AppConstants.enterAllTheDetails,
                                          color.errorColor,
                                          ref,
                                        );
                                      }

                                      final task = TaskModel(
                                        taskId: Uuid().v4(),
                                        title: taskState.title,
                                        description: taskState.desc,
                                        date: taskState.date,
                                        time: taskState.time,
                                        priority: taskState.priority,
                                      );

                                      try {
                                        await HomeDb().addTasksToDatabase(task);
                                        ref
                                            .read(authLoadingProvider.notifier)
                                            .state = false;
                                        Navigator.pop(context);
                                        ShowCustomSnackbar().showSnackbar(
                                          context,
                                          'Task Added!',
                                          color.successColor,
                                          ref,
                                        );
                                      } catch (e) {
                                        Navigator.pop(context);
                                        ShowCustomSnackbar().showSnackbar(
                                          context,
                                          'Error: $e',
                                          color.errorColor,
                                          ref,
                                        );
                                      }
                                    },
                                    child: Text(AppConstants.done),
                                  ),
                                ],
                              ),

                              SizedBox(height: 30),

                              // Input section
                              Expanded(
                                child: SingleChildScrollView(
                                  physics: BouncingScrollPhysics(),
                                  controller: scrollController,
                                  child: InputSection(ref: ref),
                                ),
                              ),
                            ],
                          ),
                        ),
              );
            },
          ),
        );
      },
    );
  }
}
