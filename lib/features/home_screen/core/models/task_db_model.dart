class TaskModel {
  final String taskId;
  final String title;
  final String description;
  final String date;
  final String time;
  final String priority;

  TaskModel({
    required this.taskId,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.priority,
  });

  Map<String, dynamic> toMap() {
    return {
      'taskId' : taskId,
      'title': title,
      'description': description,
      'date': date,
      'time': time,
      'priority': priority,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      taskId: map['taskId'],
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      date: map['date'] ?? '',
      time: map['time'] ?? '',
      priority: map['priority'] ?? 'Low',
    );
  }
}
