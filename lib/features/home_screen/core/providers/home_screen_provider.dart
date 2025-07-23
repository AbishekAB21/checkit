import 'package:checkit/common/methods/get_user_details.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:checkit/features/home_screen/core/models/task_state_model.dart';
import 'package:checkit/features/home_screen/components/home_screen_component.dart';

/// Manages state globally for [HomeScreenComponent] by referencing [TaskState]

class HomeScreenNotifier extends StateNotifier<TaskState> {
  HomeScreenNotifier() : super(TaskState());

  // Sets title value
  void setTitle(String title) {
    state = state.copyWith(title: title);
  }

  // Sets description value
  void setDesc(String desc) {
    state = state.copyWith(desc: desc);
  }

  // Set date value
  void setDate(String date) {
    state = state.copyWith(date: date);
  }

  // Set time value
  void setTime(String time) {
    state = state.copyWith(time: time);
  }

  // Sets priority value (low by default)
  void setPriority(String priority) {
    state = state.copyWith(priority: priority);
  }
}

final homeScreenProvider = StateNotifierProvider<HomeScreenNotifier, TaskState>(
  (ref) => HomeScreenNotifier(),
);

final userNameProvider = FutureProvider<String?>((ref) async{
  return await GetUserDetails().getuserName();
});