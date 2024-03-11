import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_y_pomodoro_app/core/task_state_enum.dart';
import 'package:todo_y_pomodoro_app/features/common/models/error_response.dart';
import 'package:todo_y_pomodoro_app/features/tasks/models/task_model.dart';

class TasksController {

  TasksController._privateConstructor();
  static final TasksController _instance = TasksController._privateConstructor();
  factory TasksController() => _instance;

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  final String tasksCollection = "tasks";

  Stream<QuerySnapshot<Map<String, dynamic>>> tasksStream(String userId) => 
    _db.collection(tasksCollection).
      where("deleted_at", isNull: true)
        .where("state", isEqualTo: TaskState.pending.value)
        .where("user_id", isEqualTo: userId)
          .orderBy("created_at", descending: false)
          .snapshots();
          
  Stream<QuerySnapshot<Map<String, dynamic>>> tasksArchivedStream(String userId, String groupId) => 
    _db.collection(tasksCollection).
      where("deleted_at", isNull: true)
        .where("user_id", isEqualTo: userId)
          .where("group_id", isEqualTo: groupId)
          .where("state", isEqualTo: TaskState.completed.value)
          .orderBy("updated_at", descending: false)
          .snapshots();

  //GET
  Future<dynamic> getTasks(String userId, String groupId) async {
    try {
      QuerySnapshot docsRef = await _db.collection(tasksCollection)
        .where("deleted_at", isNull: true)
        .where("user_id", isEqualTo: userId)
        .where("group_id", isEqualTo: groupId)
        .get();
      if (docsRef.docs.isEmpty) {
        return List<TaskModel>.empty();
      }
      return parseTasks(docsRef.docs);
    }  on SocketException{
      return ErrorResponse.network;
    } catch(_){
      return ErrorResponse.unknown;
    }
  }
  //CREATE
  Future<dynamic> createTask(TaskModel task) async {
    try{
      final ref = await _db.collection(tasksCollection).add(task.toJson());
      await _db.collection(tasksCollection).doc(ref.id).update({
        "id": ref.id
      });
      return true;
    } on SocketException{
      return ErrorResponse.network;
    } catch(_){
      return ErrorResponse.unknown;
    }
  }
  //UPDATE
  Future<dynamic> updateTask(TaskModel taskModel) async {
    try{
      DocumentReference docsRef = _db.collection(tasksCollection).doc(taskModel.id);
      await docsRef.update(taskModel.toJson());
      return true;
    }  on SocketException{
      return ErrorResponse.network;
    } catch(_){
      return ErrorResponse.unknown;
    }
  }
  //DELETE
  Future<dynamic> deleteTask(TaskModel taskModel) async {
    try{
      await _db.collection(tasksCollection).doc(taskModel.id).update({
        "deleted_at": DateTime.now()
      });
      return true;
    }  on SocketException{
      return ErrorResponse.network;
    } catch(_){
      return ErrorResponse.unknown;
    }
  }

  List<TaskModel> parseTasks(List<QueryDocumentSnapshot<Object?>> docs){
    List<TaskModel> tasksModels = [];
    for (QueryDocumentSnapshot snapshot in docs) {
      final data = snapshot.data() as Map<String, dynamic>?;
      if (data != null) {
        tasksModels.add(TaskModel.fromJson(data));
      }
    }
    return tasksModels;
  }
}