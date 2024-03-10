import 'package:flutter/material.dart';

class TasksActivityProvider extends ChangeNotifier {
  
  String _selectedTaskGroupId = "";
  
  String get selectedTaskGroupId => _selectedTaskGroupId;
  
  set selectedTaskGroupId(String value) {
    _selectedTaskGroupId = value;
    notifyListeners();
  }


}