import 'package:to_do_app/services/firestore_backend.dart';

import '../model/task.dart';
import 'fake_data.dart';
import 'local_storage.dart';
import 'storage.dart';

class MyController {
  static Storage storage = FirestoreBackend();
  //static Storage storage = LocalStorage();

  // static List<Task> getTasks() {
  //   return FakeData.getTasks();
  // }

  static Future<List<Task>> getTasks() {
    return storage.getTasks();
  }

  static Future<void> deleteTask(Task task) {
    return storage.removeTask(task);
  }

  static Future<Task> addTask(String description, DateTime? dateTime) {
    return storage.insertTask(description, dateTime);
  }
}
