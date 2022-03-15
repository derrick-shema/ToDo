import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewTaskViewModel extends ChangeNotifier {
  DateTime? _selectedDate;
  String _description = '';

  DateTime? getDate() {
    return _selectedDate;
  }

  void setDate(DateTime? value) {
    _selectedDate = value;
    notifyListeners();
  }

  String getDescription() {
    return _description;
  }

  void setDescription(String value) {
    _description = value;
    notifyListeners();
  }

}
