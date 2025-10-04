import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todo_y_pomodoro_app/features/common/models/error_response.dart';
import 'package:todo_y_pomodoro_app/features/tasks/controllers/tasks_controller.dart';
import 'package:todo_y_pomodoro_app/features/tasks/models/task_model.dart';

class TasksProvider extends ChangeNotifier {

  final tasksController = TasksController();

  //GET
  StreamSubscription<dynamic>? tasksSubscription;
  bool tasksLoading = true;
  bool tasksError = false;
  List<TaskModel> tasks = [];

  List<TaskModel> tasksPerGroup(String groupId) => 
    tasks.where((task) => task.groupId == groupId).toList();
  
  void swapTasks<TaskModel>(int index1, int index2) {
    final orders = tasks.map((e) => e.order).toList();
    if (index1 < 0 || index2 < 0 || index1 >= tasks.length || index2 >= tasks.length) {
      return;
    }
    
    if (index1 == index2) {
      return;
    }
    final tempMoving = tasks[index1];
    tasks.removeAt(index1);
    tasks.insert(index2, tempMoving);
    for(int i = 0; i < tasks.length; i++) {
      tasks[i] = tasks[i].copyWith(
        updatedAt: tasks[i].updatedAt, 
        deletedAt: tasks[i].deletedAt,
        order: orders[i]
      );
    }
    notifyListeners();
    tasksController.swapTasks(tasks);
  }

  Future<void> getTasksSubscription(String userId) async {
    if(tasksSubscription != null) return;
    tasksLoading = true;
    tasksError = false;
    notifyListeners();
    tasksSubscription = tasksController.tasksStream(userId).listen((snapshots) {
      tasks = tasksController.parseTasks(snapshots.docs);
      print(tasks);
      tasksLoading = false;
      tasksError = false;
      notifyListeners();
    }, onError: (error){
      tasksLoading = false;
      tasksError = true;
      notifyListeners();
    });
  }

  //GET
  StreamSubscription<dynamic>? tasksArchivedSubscription;
  bool tasksArchivedLoading = true;
  bool tasksArchivedError = false;
  List<TaskModel> tasksArchived = [];

  List<TaskModel> tasksArchivedPerGroup(String groupId) => tasksArchived.where((task) => task.groupId == groupId).toList();

  Future<void> getTasksArchivedSubscription(String userId, String groupId) async {
    if(tasksArchivedSubscription != null) return;
    tasksArchivedLoading = true;
    tasksArchivedError = false;
    notifyListeners();
    tasksArchivedSubscription = tasksController.tasksArchivedStream(userId, groupId).listen((snapshots) {
      tasksArchived = tasksController.parseTasks(snapshots.docs);
      tasksArchivedLoading = false;
      tasksArchivedError = false;
      notifyListeners();
    }, onError: (error){
      tasksArchivedLoading = false;
      tasksArchivedError = true;
      notifyListeners();
    });
  }

  //CREATE
  bool createTaskLoading = false;
  bool createTaskError = false;
  TaskModel createdTask = TaskModel.empty;

  Future<dynamic> createTask(TaskModel taskModelTaskModel) async {
    createTaskLoading = true;
    createTaskError = false;
    notifyListeners();
    final resp = await tasksController.createTask(taskModelTaskModel);
    if(resp is ErrorResponse){
      createTaskLoading = false;
      createTaskError = true;
      notifyListeners();
      return resp;
    }
    createTaskLoading = false;
    createTaskError = false;
    notifyListeners();
    return true;
  }

  //UPDATE
  bool updateTaskLoading = false;
  bool updateTaskError = false;

  Future<dynamic> updateTask(TaskModel taskModelTaskModel) async {
    updateTaskLoading = true;
    updateTaskError = false;
    notifyListeners();
    final resp = await tasksController.updateTask(taskModelTaskModel);
    if(resp is ErrorResponse){
      updateTaskLoading = false;
      updateTaskError = true;
      notifyListeners();
      return resp;
    }
    updateTaskLoading = false;
    updateTaskError = false;
    notifyListeners();
    return true;
  }

  //DELETE
  bool deleteTaskLoading = false;
  bool deleteTaskError = false;

  Future<dynamic> deleteTask(TaskModel taskModelTaskModel) async {
    deleteTaskLoading = true;
    deleteTaskError = false;
    notifyListeners();
    final resp = await tasksController.deleteTask(taskModelTaskModel);
    if(resp is ErrorResponse){
      deleteTaskLoading = false;
      deleteTaskError = true;
      notifyListeners();
      return resp;
    }
    deleteTaskLoading = false;
    deleteTaskError = false;
    notifyListeners();
    return true;
  }

  disposeProvider(){
    //CREATE FLOW
    tasksSubscription?.cancel();
    tasksSubscription = null;
    tasksLoading = true;
    tasksError = false;
    tasks.clear();

    tasksArchivedSubscription?.cancel();
    tasksArchivedSubscription = null;
    tasksArchivedLoading = true;
    tasksArchivedError = false;
    tasksArchived.clear();

    createTaskLoading = false;
    createTaskError = false;
    createdTask = TaskModel.empty;

    deleteTaskLoading = false;
    deleteTaskError = false;

    updateTaskLoading = false;
    updateTaskError = false;

  }


}