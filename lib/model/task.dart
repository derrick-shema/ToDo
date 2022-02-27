class Task {
  bool isCompleted;
  final String description;
  final String id;
  final DateTime dueDate;

  Task({this.description = '', this.id = '', DateTime? dueDate}) : isCompleted = false, dueDate = dueDate ?? DateTime.now();
}
