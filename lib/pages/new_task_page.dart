import 'package:flutter/material.dart';
import 'package:to_do_app/pages/viewmodels/new_task_view_model.dart';
import 'package:to_do_app/utils/date_converter.dart';
import 'package:provider/provider.dart';


class NewTaskPage extends StatelessWidget {
  NewTaskPage({Key? key}) : super(key: key);

  final converter = DateConverter();


  // @override
  // void dispose() {
  //   _controller.dispose();
  //   super.dispose();
  // }



  @override
  Widget build(BuildContext context) {
    DateTime today = DateTime.now();
    return Scaffold(
      appBar: AppBar(title: const Text('Add New Task')),
      body: ListView(
        children: [
          TextField(
            decoration: const InputDecoration(labelText: 'New task'),
            //controller: _controller
            onChanged: (String updatedValue) => context.read<NewTaskViewModel>().setDescription(updatedValue),
            minLines: 3,
            maxLines: null,
          ),
          ElevatedButton(
            onPressed: () =>
                showDatePicker(
                  context: context,
                  initialDate: today.add(const Duration(days: 3)),
                  firstDate: today,
                  lastDate: today.add(const Duration(days: 1000)),
                ).then((DateTime? value) => context.read<NewTaskViewModel>().setDate(value)),
            child: Text(
                converter.dateToString(dateTime: context.watch<NewTaskViewModel>().getDate()) ??
                    'Select Due Date'),
          ),

          ElevatedButton(
              onPressed: () =>
                  Navigator.of(context).pop([context.read<NewTaskViewModel>().getDescription(), context.read<NewTaskViewModel>().getDate() ]),
              child: const Text('Save'))
        ],
      ),
    );
  }
}
