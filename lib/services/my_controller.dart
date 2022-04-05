import 'dart:typed_data';

import '../model/task.dart';
import '../services/auth.dart';
import 'firebase_storage.dart';
import 'firestore_backend.dart';
import 'storage.dart';

class MyController {
  static final Storage _storage = FirestoreBackend();
  static final _firebaseStorage = FirebaseStorage();

  static Future<List<Task>> getTasks() {
    return _storage.getTasks();
  }

  static Future<void> deleteTask(Task task) {
    return _storage.removeTask(task);
  }

  static Future<Task> addTask(String description, DateTime? dueDate) {
    return _storage.insertTask(description, dueDate);
  }

  static Future<String?> createAccount(
      {required String email, required String password}) {
    return Auth.createAccountWithEmailAndPassword(
        email: email, password: password);
  }

  static Future<String?> signIn(
      {required String email, required String password}) {
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

  static Future<Uint8List?> getProfilePicture() {
    return _firebaseStorage.getProfilePicture();
  }

  static void setProfilePicture(Uint8List data) {
    return _firebaseStorage.setProfilePicture(data);
  }
}
