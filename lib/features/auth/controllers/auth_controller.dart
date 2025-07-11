import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_y_pomodoro_app/core/constants.dart';
import 'package:todo_y_pomodoro_app/features/auth/models/user_model.dart';
import 'package:todo_y_pomodoro_app/features/common/models/error_response.dart';

class AuthController {

  AuthController._privateConstructor();
  static final AuthController _instance = AuthController._privateConstructor();
  factory AuthController() => _instance;

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  final String usersCollection = "users";

  Future<dynamic> signOut() async {
    try {
      await _auth.signOut();
      return true;
    } on FirebaseAuthException catch (e) {
      return ErrorResponse(
        statusCode: 400, 
        message: e.code
      );
    } on SocketException{
      return ErrorResponse.network;
    } catch(_){
      return ErrorResponse.unknown;
    }
  }
  Future<dynamic> sendRecoverPasswordEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      if(e.code == "invalid-email"){
        return ErrorResponse(
          statusCode: 400, 
          message: "El email ingresado es inválido"
        );
      }else if (e.code == "missing-android-pkg-name"){
        return ErrorResponse(
          statusCode: 401, 
          message: "Error desconocido"
        );
      }else if (e.code == "missing-continue-uri"){
        return ErrorResponse(
          statusCode: 402, 
          message: "Error desconocido"
        );
      }else if (e.code == "missing-ios-bundle-id"){
        return ErrorResponse(
          statusCode: 403, 
          message: "Error desconocido"
        );
      }else if (e.code == "invalid-continue-uri"){
        return ErrorResponse(
          statusCode: 404, 
          message: "Error desconocido"
        );
      }else if (e.code == "unauthorized-continue-uri"){
        return ErrorResponse(
          statusCode: 405, 
          message: "Error desconocido"
        );
      }else if (e.code == "user-not-found"){
        return ErrorResponse(
          statusCode: 406, 
          message: "El usuario no se encuentra registrado"
        );
      }else{
        return ErrorResponse.unknown;
      }
    } on SocketException{
      return ErrorResponse.network;
    } catch(_){
      return ErrorResponse.unknown;
    }
  }
  Future<dynamic> signInUserEmailPassword(String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password
      );
      if(credential.user != null){
        return credential.user!;
      }else{
        return ErrorResponse.unknown;
      }
    } on FirebaseAuthException catch (e) {
      if(e.code == "invalid-email"){
        return ErrorResponse(
          statusCode: 400, 
          message: language == "es" ? "El email ingresado es inválido" : "The email entered is invalid"
        );
      }else if (e.code == "user-disabled"){
        return ErrorResponse(
          statusCode: 401, 
          message: language == "es" ? "El usuario se encuentra suspendido" : "The user is suspended"
        );
      }else if (e.code == "user-not-found"){
        return ErrorResponse(
          statusCode: 402, 
          message: language == "es" ? "El usuario no se encuentra registrado" : "The user is not registered"
        );
      }else if (e.code == "wrong-password"){
        return ErrorResponse(
          statusCode: 403, 
          message: language == "es" ? "La contraseña es incorrecta o no está registrado con email" : "The password is incorrect or the user is not registered with the email"
        );
      }else if (e.code == "invalid-credential"){
        return ErrorResponse(
          statusCode: 404, 
          message: language == "es" ? "No se encuentra registrado, lo llevaremos al registro" : "It is not registered, we will take it to the registry"
        );
      }else{
        return ErrorResponse.unknown;
      }
    } on SocketException{
      return ErrorResponse.network;
    } catch(_){
      return ErrorResponse.unknown;
    }
  }

  Future<dynamic> signUpUserEmailPassword(String email, String password) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password
      );
      if(credential.user != null){
        return credential.user!;
      }else{
        return ErrorResponse.unknown;
      }
    } on FirebaseAuthException catch (e) {
      if(e.code == "invalid-email"){
        return ErrorResponse(
          statusCode: 400, 
          message: language == "es" ? "El email ingresado es inválido" : "The email entered is invalid"
        );
      }else if (e.code == "email-already-in-use"){
        return ErrorResponse(
          statusCode: 401, 
          message: language == "es" ?  "El email se encuentra registrado" : "The email is already registered"
        );
      }else if (e.code == "operation-not-allowed"){
        return ErrorResponse(
          statusCode: 402, 
          message: language == "es" ? "No se encuentra habilitado el registro de usuarios" : "The registration of users is not enabled"
        );
      }else if (e.code == "weak-password"){
        return ErrorResponse(
          statusCode: 403, 
          message: language == "es" ? "La contraseña no es segura. Use números y letras" : "The password is not secure. Use numbers and letters"
        );
      }else{
        return ErrorResponse.unknown;
      }
    } on SocketException{
      return ErrorResponse.network;
    } catch(_){
      return ErrorResponse.unknown;
    }
  }

  Future<dynamic> loadUserSession() async {
    final user = _auth.currentUser;
    if(user == null){
      return ErrorResponse.notFound;
    }
    final data = await fetchUserById(user.uid);
    return data;
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> currentUserStream(String userId) => _db.collection(usersCollection).doc(userId).snapshots();
  
  Future<dynamic> fetchUserById(String id) async {
    try {
      DocumentSnapshot docsRef = await _db.collection(usersCollection).doc(id).get();
      final data = docsRef.data() as Map<String, dynamic>?;
      if (data != null) {
        return UserModel.fromJson(data);
      }
      return ErrorResponse.notFound;
    }  on SocketException{
      return ErrorResponse.network;
    } catch(_){
      return ErrorResponse.unknown;
    }
  }

  Future<dynamic> createUserById(UserModel userModel) async {
    try {
      await _db.collection(usersCollection).doc(userModel.id).set(userModel.toJson());
      return true;
    }  on SocketException{
      return ErrorResponse.network;
    } catch(_){
      return ErrorResponse.unknown;
    }
  }

  Future<dynamic> updateUser(UserModel userModel) async {
    try {
      DocumentReference refUser = _db.collection(usersCollection).doc(userModel.id);
      await refUser.update(userModel.toJson());
      return true;
    }  on SocketException{
      return ErrorResponse.network;
    } catch(_){
      return ErrorResponse.unknown;
    }
  }
}