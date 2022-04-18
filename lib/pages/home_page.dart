//Estimated time: 3 hours
//Actual time: 5 hours

import 'dart:typed_data';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/pages/new_task_page.dart';
import 'package:to_do_app/services/firebase_storage.dart';
import 'package:to_do_app/services/my_controller.dart';
import 'package:to_do_app/utils/date_converter.dart';
import 'package:to_do_app/view_models/profile_picture_notifier.dart';
import 'package:to_do_app/widgets/image_select_dialog.dart';

import '../model/task.dart';
import 'opening_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Future<List<Task>> _tasksFuture = MyController.getTasks();
  List<Task>? _tasks;

  //final Future<Uint8List?> imageData = FirebaseStorage().getProfilePicture();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Task>>(
      future: _tasksFuture,
      builder: (context, snapshot) {
        _tasks = snapshot.hasData ? snapshot.data! : [];

        return ChangeNotifierProvider<ProfilePictureNotifier>(
          //return FutureBuilder<Uint8List>
          create: (context) => ProfilePictureNotifier(),
          builder: (context, child) {
            return Scaffold(
              drawer: Drawer(
                child: SafeArea(
                  child: Column(
                    children: [
                      ListTile(
                        title: (context.watch<ProfilePictureNotifier>().exists)
                            ? Text('Update profile picture')
                            : Text('Add profile picture'),
                        onTap: () async {
                          final value = await showModalBottomSheet(
                              builder: (_) => ImageSelectDialog(), context: context);
                          if (value is Uint8List) {
                            context
                                .read<ProfilePictureNotifier>()
                                .updateProfilePicture(value);
                          } // TODO change user profile picture
                        },
                      ),
                      ListTile(
                        title: Text('Sign out'),
                        onTap: () {
                          // TODO sign user out of Firebase Auth
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (_) => OpeningPage()),
                              (_) => false);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              body: //ListView.separated(//
                  //   itemBuilder: (_, index) {
                  //     return _toWidget(_tasks![index]);
                  //   },
                  //   separatorBuilder: (_, __) => Divider(),
                  //   itemCount: _tasks!.length,
                  // ),
                  ReorderableListView(
                children: Iterable<int>.generate(_tasks!.length)
                    .map((index) => _toWidget(_tasks![index]))
                    .map<List<Widget>>((e) => [e, Divider(key: UniqueKey())])
                    .expand<Widget>((e) => e)
                    .toList(),
                onReorder: (oldIndex, newIndex) {
                  print('old: $oldIndex\tnew: $newIndex');

                  setState(() {
                    /* TODO reorder _tasks */
                    if (newIndex > oldIndex) {
                      newIndex -= 1;
                    }
                    final task = _tasks!.removeAt(oldIndex);
                    _tasks!.insert(newIndex, task);
                  });
                },
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
                    ),
                  if (context.watch<ProfilePictureNotifier>().exists)
                    CircleAvatar(
                      backgroundImage: MemoryImage(context.read<ProfilePictureNotifier>().data!),
                    ),
                ],
              ),
              floatingActionButton: FloatingActionButton(
                child: const Icon(Icons.add),
                onPressed: () {
                  FirebaseMessaging.instance.getToken().then(print);
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => NewTaskPage()))
                      .then((result) async {
                    if (result != null && result.isNotEmpty) {
                      //todo create a new task based on the result
                      // final taskFromResult = Task(
                      //     description: result, id: '' as int);
                      // //to use setState to add the new task to the list of tasks
                      // setState(() {
                      //   _tasks?.add(taskFromResult);
                      // });
                      final task =
                          await MyController.addTask(result[0], result[1]);
                      setState(() => _tasks?.add(task));
                    }
                  });
                },
              ),
            );
          },
        );
      },
    );
  }

  Widget _toWidget(Task t) {
    final converter = DateConverter();
    //return Container();
    return CheckboxListTile(
      checkColor: HexColor("3c1518"),
      key: ValueKey(t),
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

  Future<Uint8List?> _getImage({required ImageSource imageSource}) async {
    final _picker = ImagePicker();
    final image = await _picker.pickImage(
      source: imageSource,
      preferredCameraDevice: CameraDevice.front,
    );

    return image?.readAsBytes();
  }
}
