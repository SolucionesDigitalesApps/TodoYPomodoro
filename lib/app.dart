
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_y_pomodoro_app/core/themes.dart';
import 'package:todo_y_pomodoro_app/features/auth/providers/user_provider.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:todo_y_pomodoro_app/features/common/pages/router_page.dart';
import 'package:todo_y_pomodoro_app/features/tasks/providers/task_groups_provider.dart';
import 'package:todo_y_pomodoro_app/features/tasks/providers/tasks_activity_provider.dart';
import 'package:todo_y_pomodoro_app/features/tasks/providers/tasks_provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
        localizationsDelegates: const [
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