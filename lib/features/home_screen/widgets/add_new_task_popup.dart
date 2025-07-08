import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:checkit/utils/fontstyles/fontstyles.dart';
import 'package:checkit/features/home_screen/widgets/input_section.dart';
import 'package:checkit/features/settings_screen/core/providers/theme_provider.dart';

class AddNewTaskPopup {
  void showBottomSheet(BuildContext context, WidgetRef ref) {
    final color = ref.watch(themeProvider);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.7,
          maxChildSize: 0.9,
          minChildSize: 0.4,
          builder: (contex, scrollController) {
            return Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: color.textfieldBackground,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          style: ButtonStyle(
                            foregroundColor: WidgetStatePropertyAll(
                              color.secondaryGradient1,
                            ),
                          ),
                          onPressed: () => Navigator.pop(context),
                          child: Text("Cancel"),
                        ),
                        Text(
                          "New Task",
                          style: Fontstyles.roboto18px(context, ref),
                        ),
                        TextButton(
                          style: ButtonStyle(
                            foregroundColor: WidgetStatePropertyAll(
                              color.secondaryGradient1,
                            ),
                          ),
                          onPressed: () {},
                          child: Text("Done"),
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
        );
      },
    );
  }
}
