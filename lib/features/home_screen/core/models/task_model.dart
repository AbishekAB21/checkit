class TaskState {
  final String title;
  final String desc;
  final String date;
  final String time;
  final String priority;

  TaskState({
    this.title = "",
    this.desc = "",
    this.date = "",
    this.time = "",
    this.priority = "Low",
  });

  TaskState copyWith({
    String? title,
    String? desc,
    String? date,
    String? time,
    String? priority,
  }) {
    return TaskState(
      title: title ?? this.title,
      desc: desc ?? this.desc,
      date: date ?? this.date,
      time: title ?? this.time,
      priority: priority ?? this.priority,
    );
  }
}
