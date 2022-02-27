import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/task.dart';
import 'storage.dart';

class LocalStorage implements Storage {
  static final _singleton = LocalStorage._internal();

  factory LocalStorage() {
    return _singleton;
  }

  LocalStorage._internal();

  Database? _cachedDatabase;
  static const _tasksTable = 'tasks';

  Future<Database> get database async {
    if (_cachedDatabase != null) return _cachedDatabase!;

    final name = join(await getDatabasesPath(), 'todo.db');
    // await deleteDatabase(name);

    _cachedDatabase = await openDatabase(
      name,
      onCreate: _onCreate,
      version: 1,
    );

    return _cachedDatabase!;
  }

  static Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
CREATE TABLE $_tasksTable (
  task_id INTEGER PRIMARY KEY AUTOINCREMENT,
  description TEXT NOT NULL
);
''');
    return db.execute('''
INSERT INTO $_tasksTable (description)
  VALUES ("task 1");
''');
  }

  Future<List<Task>> getTasks() async {
    final db = await database;
    final result = await db.query(_tasksTable);

    return result
        .map<Task>((e) => Task(
      description: e['description'] as String,
      id: e['task_id'] as String,
    ))
        .toList();

  }

  Future<Task> insertTask(String description, DateTime? dateTime) async {
    final db = await database;
    final id = await db.insert(_tasksTable, {'description': description});
    return Task(description:description);
  }

  Future<int> removeTask(Task task) async {
    final db = await database;
    db.delete(_tasksTable,where: 'id:?', whereArgs: [task.id]);
    return -1;
  }
}
