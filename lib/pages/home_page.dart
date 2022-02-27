//For Week 6 Homework
//Estimated time of completion: 4 hours
//Actual time of completion: 10 hours

import 'package:flutter/material.dart';
import 'package:to_do_app/pages/new_task_page.dart';
import 'package:to_do_app/services/my_controller.dart';
import 'package:to_do_app/utils/date_converter.dart';

import '../model/task.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Future<List<Task>> _tasksFuture = MyController.getTasks();
  List<Task>? _tasks;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder <List<Task>>(
      future: _tasksFuture,
      builder: (context, snapshot) {
        _tasks = snapshot.hasData ? snapshot.data! : [];

        return Scaffold(
          body: ListView.separated(
            itemBuilder: (_, index) {
              return _toWidget(_tasks![index]);
            },
            separatorBuilder: (_, __) => Divider(),
            itemCount: _tasks!.length,
        ),
          appBar: AppBar(
            title: const Text('Todo'),
            actions: [
              if (_tasks!.any((task) => task.isCompleted))
                IconButton(
                  onPressed: () {
                    _tasks
                        ?.where((task) => task.isCompleted)
                        .forEach(MyController.deleteTask);
                    setState(() {
                      _tasks?.removeWhere((Task t) => t.isCompleted);
                    });
                  },
                  icon: const Icon(Icons.delete),
                )
            ],
          ),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => NewTaskPage()))
                  .then(
                      (result) async {
                    if (result != null &&
                        result.isNotEmpty) {
                      //todo create a new task based on the result
                      // final taskFromResult = Task(
                      //     description: result, id: '' as int);
                      // //to use setState to add the new task to the list of tasks
                      // setState(() {
                      //   _tasks?.add(taskFromResult);
                      // });
                      final task = await MyController.addTask(result[0], result[1]);
                      setState(() => _tasks?.add(task));

                    }
                  });
            },
          ),

        );
      },
    );
  }
  Widget _toWidget(Task t) {
    final converter = DateConverter();
    //return Container();
    return CheckboxListTile(
      value: t.isCompleted,
      onChanged: (newValue) {
        setState(() {
          t.isCompleted = newValue ?? false;
        });
      },
      title: Text(t.description),
        subtitle: Text(
          converter.dateToString(dateTime: t.dueDate) ?? '',
          style: TextStyle(color: _isExpired(t.dueDate) ? Colors.red : null),
        ),

    );
  }
  bool _isExpired(DateTime? dateTime) {
    if (dateTime == null) return true;
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return dateTime.compareTo(yesterday) <= 0;
  }
}




