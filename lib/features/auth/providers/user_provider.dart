import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_y_pomodoro_app/features/auth/controllers/auth_controller.dart';
import 'package:todo_y_pomodoro_app/features/auth/controllers/user_controller.dart';
import 'package:todo_y_pomodoro_app/features/auth/models/user_model.dart';
import 'package:todo_y_pomodoro_app/features/common/models/error_response.dart';

class UserProvider extends ChangeNotifier {
  final authController = AuthController();
  final userController = UserController();

  UserModel currentUser = UserModel.empty.copyWith(
    id: ""
  );
  bool currentUserLoading = false;
  bool currentUserError = false;

  Future<dynamic> getCurrentUser() async {
    currentUserLoading = true;
    currentUserError = false;
    notifyListeners();
    final data = await authController.loadUserSession();
    if (data is ErrorResponse) {
      currentUserLoading = false;
      currentUserError = true;
      notifyListeners();
      return data;
    }
    currentUser = data as UserModel;
    currentUserLoading = false;
    currentUserError = false;
    notifyListeners();
    return currentUser;
  }

  bool updateUserLoading = false;
  bool updateUserError = false;

  Future<dynamic> updateUser(UserModel userModel) async {
    updateUserLoading = true;
    updateUserError = false;
    notifyListeners();
    final data = await authController.updateUser(userModel);
    if (data is ErrorResponse) {
      updateUserLoading = false;
      updateUserError = true;
      notifyListeners();
      return data;
    }
    updateUserLoading = false;
    updateUserError = false;
    notifyListeners();
    return true;
  }

  void setNewUser(UserModel newUser) {
    currentUser = newUser;
    notifyListeners();
  }

  void clearNewUser(){
    currentUser = UserModel.empty;
  }

  StreamSubscription<dynamic>? userSubs;
  bool userSubsError = false;
  bool userSubsLoading = false;

  final _userController = StreamController<UserModel>.broadcast();
  Function(UserModel) get userSink => _userController.sink.add;
  Stream<UserModel> get userStream => _userController.stream;

  Future<void> getUserSubscription() async {
    if(userSubs != null) return;
    userSubsError = false;
    userSubs = userController.userStream(currentUser.id).listen((DocumentSnapshot<Map<String, dynamic>> snapshot) {
      final data = snapshot.data();
      if(data == null){
        userSubsError = true;
        userSubsLoading = false;
        notifyListeners();
        return;
      }
      final newUser = UserModel.fromJson(data);
      userSubsLoading = false;
      userSubsError = false;
      currentUser = newUser;
      userSink(newUser);
      notifyListeners();
    }, onError: (error){
      userSubsLoading = false;
      userSubsError = true;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    userSubs?.cancel();
    super.dispose();
  }
}
