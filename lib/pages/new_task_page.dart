import 'package:flutter/material.dart';
import 'package:to_do_app/utils/date_converter.dart';

class NewTaskPage extends StatefulWidget {
  NewTaskPage({Key? key}) : super(key: key);

  @override
  State<NewTaskPage> createState() => _NewTaskPageState();
}

class _NewTaskPageState extends State<NewTaskPage> {
  final TextEditingController _controller = TextEditingController();
  final converter = DateConverter();
  DateTime today = DateTime.now();
  DateTime? _selectedDate;
  DateTime? get date {
    return _selectedDate;
  }

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
            onPressed: () => showDatePicker(
              context: context,
              initialDate: today.add(const Duration(days: 3)),
              firstDate: today,
              lastDate: today.add(const Duration(days: 1000)),
            ).then((DateTime? value) => setState(() => _selectedDate = value)),
            child: Text(
                converter.dateToString(dateTime: _selectedDate) ?? 'Select Due Date'),
          ),

          ElevatedButton(
              onPressed: () => Navigator.of(context).pop([_controller.text, _selectedDate]),
              child: const Text('Save'))
        ],
      ),
    );
  }
}
