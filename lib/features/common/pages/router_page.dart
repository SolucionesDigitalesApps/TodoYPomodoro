import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:provider/provider.dart';
import 'package:todo_y_pomodoro_app/features/auth/controllers/auth_controller.dart';
import 'package:todo_y_pomodoro_app/features/auth/models/user_model.dart';
import 'package:todo_y_pomodoro_app/features/auth/pages/sign_in_page.dart';
import 'package:todo_y_pomodoro_app/features/auth/providers/user_provider.dart';
import 'package:todo_y_pomodoro_app/features/common/controllers/local_controller.dart';
import 'package:todo_y_pomodoro_app/features/common/controllers/notification_controller.dart';
import 'package:todo_y_pomodoro_app/features/common/models/error_response.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/alerts.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/scaffold_wrapper.dart';
import 'package:todo_y_pomodoro_app/features/tasks/pages/tasks_home_page.dart';
import 'package:todo_y_pomodoro_app/features/tasks/providers/tasks_activity_provider.dart';
import 'dart:ui';

class RouterPage extends StatefulWidget {
  const RouterPage({super.key});

  @override
  State<RouterPage> createState() => _RouterPageState();
}

class _RouterPageState extends State<RouterPage> {
  final notificationController = NotificationController();
  final authController = AuthController();
  final localController = LocalController();
  late String initialLanguage;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadSession();
    });
  }

  Future<void> loadSession() async {
    final currentLanguage = localController.localLanguage;
    if(currentLanguage.isEmpty){
      String systemLanguage = window.locale.languageCode;
      if (systemLanguage == 'en') {
        changeLanguage(context, systemLanguage);
      } else if (systemLanguage == 'es') {
        changeLanguage(context, systemLanguage);
      } else {
        changeLanguage(context, 'es');
      }
    }else{
      changeLanguage(context, currentLanguage);
    }
    final resp = await Provider.of<UserProvider>(context, listen: false).getCurrentUser();
    if(resp is ErrorResponse){
      if(mounted){
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const SignInPage()), (route) => false);
      }
      return;
    }
    final fcmToken = await notificationController.getToken();
    final data = resp as UserModel;
    late UserModel newUser;
    if(data.fcmToken != fcmToken){
      newUser = data.copyWith(
        fcmToken: fcmToken
      );
      authController.updateUser(newUser);
    }else{
      newUser = data;
    }
    if(mounted){
      Provider.of<UserProvider>(context, listen: false).setNewUser(newUser);
      Provider.of<TasksActivityProvider>(context, listen: false).selectedTaskGroupId = newUser.lastGroupId;
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const TasksHomePage()), (route) => false);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return const ScaffoldWrapper(
      backgroundColor: Colors.white,
      body: Center(
        child: CircularProgressIndicator()
      ),
    );
  }

  Future<bool> changeLanguage(BuildContext context, String language) async {
    final newLocale = Locale(language);
    localController.localLanguage = newLocale.languageCode;
    final currentLang = newLocale;
    try{
      if(!mounted) return false;
      await FlutterI18n.refresh(context, currentLang);
    }catch(_){
      if(!mounted) return false;
      showErrorAlert(context, FlutterI18n.translate(context, "general.dear"), [FlutterI18n.translate(context, "general.error")]);
    }
    if(mounted){
      setState(() {});
    }
    return true;
  }
}