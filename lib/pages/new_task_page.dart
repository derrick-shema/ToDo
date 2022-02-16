import 'package:flutter/material.dart';

class NewTaskPage extends StatefulWidget {
  const NewTaskPage({Key? key}) : super(key: key);

  @override
  State<NewTaskPage> createState() => _NewTaskPageState();
}

class _NewTaskPageState extends State<NewTaskPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add New Task')),
      body: ListView(
        children: [
           TextField(
            decoration: const InputDecoration(labelText: 'New task'),
            controller: _controller,
            minLines: 3,
            maxLines: null,
          ),
          ElevatedButton(
              onPressed: () => Navigator.of(context).pop(_controller.text),
              child: const Text('Save'))
        ],
      ),
    );
  }
}
