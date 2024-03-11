import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todo_y_pomodoro_app/features/common/models/error_response.dart';
import 'package:todo_y_pomodoro_app/features/tasks/controllers/task_groups_controller.dart';
import 'package:todo_y_pomodoro_app/features/tasks/models/task_group_model.dart';

class TaskGroupsProvider extends ChangeNotifier {

  final taskGroupsController = TaskGroupsController();

  //GET
  StreamSubscription<dynamic>? taskGroupsSubscription;
  bool taskGroupsLoading = true;
  bool taskGroupsError = false;
  List<TaskGroupModel> taskGroups = [];

  Future<void> getTaskGroupsSubscription(String userId) async {
    if(taskGroupsSubscription != null) return;
    taskGroupsLoading = true;
    taskGroupsError = false;
    taskGroupsSubscription = taskGroupsController.taskGroupsStream(userId).listen((snapshots) {
      taskGroups = taskGroupsController.parseTaskGroups(snapshots.docs);
      taskGroupsLoading = false;
      taskGroupsError = false;
      notifyListeners();
    }, onError: (error){
      taskGroupsLoading = false;
      taskGroupsError = true;
      notifyListeners();
    });
  }

  Future<dynamic> getTasksGroups(String userId) async {
    taskGroupsLoading = true;
    taskGroupsError = false;
    notifyListeners();
    final resp = await taskGroupsController.getTaskGroups(userId);
    if(resp is ErrorResponse){
      taskGroupsLoading = false;
      taskGroupsError = true;
      notifyListeners();
      return resp;
    }
    taskGroupsLoading = false;
    taskGroupsError = false;
    taskGroups = resp;
    notifyListeners();
    return true;
  }

  //CREATE
  bool createTaskGroupLoading = false;
  bool createTaskGroupError = false;
  TaskGroupModel createdTaskGroup = TaskGroupModel.empty;

  Future<dynamic> createTaskGroup(TaskGroupModel taskGroupModel) async {
    createTaskGroupLoading = true;
    createTaskGroupError = false;
    notifyListeners();
    final resp = await taskGroupsController.createTaskGroup(taskGroupModel);
    if(resp is ErrorResponse){
      createTaskGroupLoading = false;
      createTaskGroupError = true;
      notifyListeners();
      return resp;
    }
    createTaskGroupLoading = false;
    createTaskGroupError = false;
    notifyListeners();
    return true;
  }

  //UPDATE
  bool updateTaskGroupLoading = false;
  bool updateTaskGroupError = false;

  Future<dynamic> updateTaskGroup(TaskGroupModel taskGroupModel) async {
    updateTaskGroupLoading = true;
    updateTaskGroupError = false;
    notifyListeners();
    final resp = await taskGroupsController.updateTaskGroup(taskGroupModel);
    if(resp is ErrorResponse){
      updateTaskGroupLoading = false;
      updateTaskGroupError = true;
      notifyListeners();
      return resp;
    }
    updateTaskGroupLoading = false;
    updateTaskGroupError = false;
    notifyListeners();
    return true;
  }

  //DELETE
  bool deleteTaskGroupLoading = false;
  bool deleteTaskGroupError = false;

  Future<dynamic> deleteTaskGroup(TaskGroupModel taskGroupModel) async {
    deleteTaskGroupLoading = true;
    deleteTaskGroupError = false;
    notifyListeners();
    final resp = await taskGroupsController.deleteTaskGroup(taskGroupModel);
    if(resp is ErrorResponse){
      deleteTaskGroupLoading = false;
      deleteTaskGroupError = true;
      notifyListeners();
      return resp;
    }
    deleteTaskGroupLoading = false;
    deleteTaskGroupError = false;
    notifyListeners();
    return true;
  }

  disposeProvider(){
    //CREATE FLOW
    taskGroupsSubscription?.cancel();
    taskGroupsSubscription = null;
    taskGroupsLoading = true;
    taskGroupsError = false;
    taskGroups.clear();
    //TODO: Cancel all other streams
  }
}