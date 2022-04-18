class Task implements Comparable{
  bool isCompleted;
  final String description;
  final String id;
  final DateTime dueDate;
  final DateTime createDate;

  Task({this.description = '', this.id = '', DateTime? dueDate, DateTime? createDate}) : isCompleted = false, dueDate = dueDate ?? DateTime.now(), createDate = createDate ?? DateTime.now();

  @override
  int compareTo(other) {
      return this.createDate.compareTo(other.createDate);
  }

  int compareToByDueDate(other) {
    return this.dueDate.compareTo(other.dueDate);
  }


}
