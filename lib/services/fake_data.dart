import 'package:to_do_app/model/task.dart';

class FakeData {
  static List<Task> getTasks() {
    return [
      Task(description: 'Task 1'),
      Task(description: 'Task 2'),
      Task(
          description:
              'This is a longer task that requires you to wrap the text to a new line and to make sure that the visuals handle that correctly.'),
      Task(description: 'Task 4'),
    ];
  }
}
