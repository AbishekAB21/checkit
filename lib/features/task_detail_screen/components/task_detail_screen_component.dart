import 'package:flutter/material.dart';

import 'package:checkit/features/settings_screen/core/providers/theme_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TaskDetailScreenComponent extends ConsumerWidget {
  const TaskDetailScreenComponent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = ref.watch(themeProvider);

    return Scaffold(
      backgroundColor: color.background,

      appBar: AppBar(toolbarHeight: 30, backgroundColor: color.background),
      body: Column(children: [
          
        ],
      ),
    );
  }
}
