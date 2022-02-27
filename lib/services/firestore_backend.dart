import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do_app/utils/date_converter.dart';
import 'package:to_do_app/pages/new_task_page.dart';

import '../model/task.dart';
import 'storage.dart';

class FirestoreBackend implements Storage {
  static const _tasks = 'tasks';
  static const _description = 'description';
  static const _dueDate = 'dueDate';
  final converter = DateConverter();

  @override
  Future<List<Task>> getTasks() async {
    final result = await FirebaseFirestore.instance.collection(_tasks).get();
    
    return result.docs
        .map((e) => Task(description: e[_description],id: e.id, dueDate: converter.toDateTime(e[_dueDate])))
        //.map((e) => Task(description: e[_description],id: e.id))
        .toList();
  }

  @override
  Future<Task> insertTask(String description, DateTime? dateTime) async {
    final result = await FirebaseFirestore.instance.collection(_tasks).add({_description: description, _dueDate: dateTime});
    return Task(description: description, id: result.id, dueDate: dateTime);
  }

  @override
  Future<void> removeTask(Task task) async {
    final result = FirebaseFirestore.instance.collection(_tasks).doc(task.id);
    return await result.delete();

    //return Future.sync(() => null);
  }
}
