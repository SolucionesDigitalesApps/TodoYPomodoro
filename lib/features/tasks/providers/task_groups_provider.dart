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
  bool taskGroupsInitialized = false;
  List<TaskGroupModel> taskGroups = [];

  Future<void> getTaskGroupsSubscription(String userId) async {
    if(taskGroupsSubscription != null) return;
    taskGroupsLoading = true;
    taskGroupsError = false;
    taskGroupsSubscription = taskGroupsController.taskGroupsStream(userId).listen((snapshots) {
      taskGroups = taskGroupsController.parseTaskGroups(snapshots.docs);
      taskGroupsLoading = false;
      taskGroupsError = false;
      if(taskGroups.isNotEmpty && !taskGroupsInitialized){
        selectTaskGroupSink(taskGroups.first);
      }
      taskGroupsInitialized = true;
      notifyListeners();
    }, onError: (error){
      taskGroupsLoading = false;
      taskGroupsError = true;
      notifyListeners();
    });
  }

  //CREATE
  bool createTaskGroupLoading = false;
  bool createTaskGroupError = false;
  TaskGroupModel createdTaskGroup = TaskGroupModel.empty;

  final _selectTaskGroupController = StreamController<TaskGroupModel>.broadcast();
  Function(TaskGroupModel) get selectTaskGroupSink => _selectTaskGroupController.sink.add;
  Stream<TaskGroupModel> get selectTaskGroupStream => _selectTaskGroupController.stream;

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
    final data = resp as String;
    selectTaskGroupSink(taskGroupModel.copyWith(
      id: data,
      updatedAt: taskGroupModel.updatedAt, 
      deletedAt: taskGroupModel.deletedAt
    ));
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
    final restTaskGroups = taskGroups.where((element) => element.id != taskGroupModel.id).toList();
    if(restTaskGroups.isNotEmpty){
      selectTaskGroupSink(restTaskGroups.last);
    }else{
      selectTaskGroupSink(TaskGroupModel.empty);
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
  }
}