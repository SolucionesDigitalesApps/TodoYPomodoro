import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todo_y_pomodoro_app/features/common/models/error_response.dart';
import 'package:todo_y_pomodoro_app/features/tasks/controllers/task_groups_controller.dart';
import 'package:todo_y_pomodoro_app/features/tasks/models/task_group.dart';

class TaskGroupsProvider extends ChangeNotifier {

  final taskGroupsController = TaskGroupsController();

  //GET
  bool taskGroupsLoading = false;
  bool taskGroupsError = false;
  List<TaskGroupModel> taskGroups = [];

  void addTaskGroup(TaskGroupModel taskGroup) {
    taskGroups.add(taskGroup);
    notifyListeners();
  }

  Future<void> getTasksGroups(String userId) async {
    taskGroupsLoading = true;
    taskGroupsError = false;
    notifyListeners();
    final resp = await taskGroupsController.getTaskGroups(userId);
    if(resp is ErrorResponse){
      taskGroupsLoading = false;
      taskGroupsError = true;
      notifyListeners();
      return;
    }
    taskGroupsLoading = false;
    taskGroupsError = false;
    taskGroups = resp;
    notifyListeners();
  }

  //CREATE
  bool createTaskGroupLoading = false;
  bool createTaskGroupError = false;
  TaskGroupModel createdTaskGroup = TaskGroupModel.empty;

  Future<dynamic> createTaskGroup(TaskGroupModel taskGroup) async {
    createTaskGroupLoading = true;
    createTaskGroupError = false;
    notifyListeners();
    final resp = await taskGroupsController.createTaskGroup(taskGroup);
    if(resp is ErrorResponse){
      createTaskGroupLoading = false;
      createTaskGroupError = true;
      notifyListeners();
      return;
    }
    createTaskGroupLoading = false;
    createTaskGroupError = false;
    notifyListeners();
    return createdTaskGroup;
  }

  //UPDATE
  bool updateTaskGroupLoading = false;
  bool updateTaskGroupError = false;

  Future<void> updateTaskGroup(TaskGroupModel taskGroup) async {
    updateTaskGroupLoading = true;
    updateTaskGroupError = false;
    notifyListeners();
    final resp = await taskGroupsController.updateTaskGroup(taskGroup);
    if(resp is ErrorResponse){
      updateTaskGroupLoading = false;
      updateTaskGroupError = true;
      notifyListeners();
      return;
    }
    updateTaskGroupLoading = false;
    updateTaskGroupError = false;
    notifyListeners();
  }

  //DELETE
  bool deleteTaskGroupLoading = false;
  bool deleteTaskGroupError = false;

  Future<void> deleteTaskGroup(TaskGroupModel taskGroup) async {
    deleteTaskGroupLoading = true;
    deleteTaskGroupError = false;
    notifyListeners();
    final resp = await taskGroupsController.deleteTaskGroup(taskGroup);
    if(resp is ErrorResponse){
      deleteTaskGroupLoading = false;
      deleteTaskGroupError = true;
      notifyListeners();
      return;
    }
    deleteTaskGroupLoading = false;
    deleteTaskGroupError = false;
    notifyListeners();
  }
}