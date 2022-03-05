import 'package:to_do_app/services/firestore_backend.dart';
import '../model/task.dart';
//import 'fake_data.dart';
//import 'local_storage.dart';
import '../services/auth.dart';
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

  static Future<String?> createAccount({required String email, required String password}) {
    return Auth.createAccountWithEmailAndPassword(
        email: email, password: password);
  }

  static Future<String?> signIn({required String email, required String password}) {
    return Auth.signInWithEmailAndPassword(email: email, password: password);
  }

  static void signOut() {
    return Auth.signOut();
  }

  static String? getUserId() {
    return Auth.getUserId();
  }

  static bool isSignedIn() {
    return Auth.isSignedIn();
  }
}
