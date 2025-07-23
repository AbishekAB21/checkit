import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:checkit/utils/fontstyles/fontstyles.dart';
import 'package:checkit/features/home_screen/widgets/task_widget.dart';
import 'package:checkit/features/settings_screen/core/providers/theme_provider.dart';

class CompletedTaskScreenComponent extends ConsumerWidget {
  const CompletedTaskScreenComponent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = ref.watch(themeProvider);
    return Scaffold(
      backgroundColor: color.background,
      appBar: AppBar(
        backgroundColor: color.background,
        title: Text(
          "Completed Tasks",
          style: Fontstyles.roboto18px(context, ref),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return null;
                  
                  //TaskWidget(priority: "High");
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: 10);
                },
                itemCount: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
