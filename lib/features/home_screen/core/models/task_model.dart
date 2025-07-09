class TaskState {
  final String priority;

  TaskState({this.priority = "Low"});

  TaskState copyWith({String? priority}) {
    return TaskState(
      priority: priority ?? this.priority,
    );
  }
}
