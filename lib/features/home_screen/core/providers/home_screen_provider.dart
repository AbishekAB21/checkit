import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:checkit/features/home_screen/core/models/task_model.dart';
import 'package:checkit/features/home_screen/components/home_screen_component.dart';

/// Manages state for [HomeScreenComponent] by referencing [TaskState]

class HomeScreenNotifier extends StateNotifier<TaskState> {
  HomeScreenNotifier() : super(TaskState());

  // Sets priority value (low by default)
  void setPriority(String priority) {
    state = state.copyWith(priority: priority);
  }
}

final homeScreenProvider = StateNotifierProvider<HomeScreenNotifier, TaskState>(
  (ref) => HomeScreenNotifier(),
);
