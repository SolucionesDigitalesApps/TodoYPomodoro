
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n_delegate.dart';
import 'package:provider/provider.dart';
import 'package:todo_y_pomodoro_app/core/themes.dart';
import 'package:todo_y_pomodoro_app/features/auth/providers/user_provider.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:todo_y_pomodoro_app/features/common/controllers/notification_controller.dart';
import 'package:todo_y_pomodoro_app/features/common/pages/router_page.dart';
import 'package:todo_y_pomodoro_app/features/tasks/providers/task_groups_provider.dart';
import 'package:todo_y_pomodoro_app/features/tasks/providers/tasks_activity_provider.dart';
import 'package:todo_y_pomodoro_app/features/tasks/providers/tasks_provider.dart';

@pragma('vm:entry-point')
Future<void> myBackgroundMessageHandler(RemoteMessage message) async {
  return Future<void>.value();
}

class MyApp extends StatefulWidget {
  final FlutterI18nDelegate flutterI18nDelegate;
  const MyApp({
    super.key,
    required this.flutterI18nDelegate
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final notificationController = NotificationController();
  @override
  void initState() {
    super.initState();
    //TODO: Verificar icono de notificacion
    notificationController.initNotifications(myBackgroundMessageHandler).then((value) {
      notificationController.getToken().then((value) {
        debugPrint("FCM TOKEN");
        debugPrint(value);
      });
    });
    
  }
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(
          create: (context) => UserProvider()
        ),
        ChangeNotifierProvider<TaskGroupsProvider>(
          create: (context) => TaskGroupsProvider()
        ),
        ChangeNotifierProvider<TasksProvider>(
          create: (context) => TasksProvider()
        ),
        ChangeNotifierProvider<TasksActivityProvider>(
          create: (context) => TasksActivityProvider()
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Tasks&Pomodoro',
        localizationsDelegates: [
          widget.flutterI18nDelegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('es', 'ES'),
        ],
        theme: Themes.lightMode,
        home: const RouterPage()
      ),
    );
  }
}