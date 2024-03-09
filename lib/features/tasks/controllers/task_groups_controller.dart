import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_y_pomodoro_app/features/common/models/error_response.dart';
import 'package:todo_y_pomodoro_app/features/tasks/models/task_group.dart';

class TaskGroupsController {

  TaskGroupsController._privateConstructor();
  static final TaskGroupsController _instance = TaskGroupsController._privateConstructor();
  factory TaskGroupsController() => _instance;

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  final String taskGroupsCollection = "task_groups";

  //GET
  Future<dynamic> getTaskGroups(String userId) async {
    try {
      QuerySnapshot docsRef = await _db.collection(taskGroupsCollection)
        .where("deleted_at", isNull: true)
        .where("user_id", isEqualTo: userId)
        .get();
      if (docsRef.docs.isEmpty) {
        return List<TaskGroupModel>.empty();
      }
      return parseTaskGroups(docsRef.docs);
    }  on SocketException{
      return ErrorResponse.network;
    } catch(_){
      return ErrorResponse.unknown;
    }
  }
  //CREATE
  Future<dynamic> createTaskGroup(TaskGroupModel taskGroup) async {
    try{
      final ref = await _db.collection(taskGroupsCollection).add(taskGroup.toJson());
      await _db.collection(taskGroupsCollection).doc(ref.id).update({
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
  Future<dynamic> updateTaskGroup(TaskGroupModel taskGroupModel) async {
    try{
      DocumentReference docsRef = _db.collection(taskGroupsCollection).doc(taskGroupModel.id);
      await docsRef.update(taskGroupModel.toJson());
      return true;
    }  on SocketException{
      return ErrorResponse.network;
    } catch(_){
      return ErrorResponse.unknown;
    }
  }
  //DELETE
  Future<dynamic> deleteTaskGroup(TaskGroupModel taskGroupModel) async {
    try{
      await _db.collection(taskGroupsCollection).doc(taskGroupModel.id).delete();
      return true;
    }  on SocketException{
      return ErrorResponse.network;
    } catch(_){
      return ErrorResponse.unknown;
    }
  }

  List<TaskGroupModel> parseTaskGroups(List<QueryDocumentSnapshot<Object?>> docs){
    List<TaskGroupModel> taskGroupsModels = [];
    for (QueryDocumentSnapshot snapshot in docs) {
      final data = snapshot.data() as Map<String, dynamic>?;
      if (data != null) {
        taskGroupsModels.add(TaskGroupModel.fromJson(data));
      }
    }
    return taskGroupsModels;
  }
}