
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_y_pomodoro_app/core/localization/app_localizations.dart';
import 'package:todo_y_pomodoro_app/core/themes.dart';
import 'package:todo_y_pomodoro_app/core/utils.dart';
import 'package:todo_y_pomodoro_app/features/auth/providers/user_provider.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:todo_y_pomodoro_app/features/common/controllers/common_controller.dart';
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
  const MyApp({
    super.key,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver{
  final notificationController = NotificationController();
  AppLifecycleState lastAppState = AppLifecycleState.resumed;
  final navigatorKey = GlobalKey<NavigatorState>();
  final commonController = CommonController();
  Locale currentLocale = const Locale('en');
  
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    notificationController.initNotifications(myBackgroundMessageHandler).then((value) {
      notificationController.getToken().then((value) {
        debugPrint("FCM TOKEN");
        debugPrint(value);
      });
    });
    notificationController.mensajes.listen((event) {
      if(event.data["type"] == "ota_update"){
        getAppUpdate();
      }
    });
    AppLocalizations.setLocaleStream.listen((event) {
      currentLocale = event;
      setState(() {});
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed && lastAppState == AppLifecycleState.inactive ) {
      getAppUpdate();
    }
    lastAppState = state;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
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
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'TareasYPomodoro',
        supportedLocales: AppLocalizations.supportedLocales,
        locale: currentLocale,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          AppLocalizations.delegate,
        ],
        theme: Themes.lightMode,
        home: const RouterPage()
      ),
    );
  }

  Future<void> getAppUpdate() async {
    final appUpdate = await commonController.checkForUpdates();
    if(appUpdate != null && mounted){
      final context = navigatorKey.currentState?.context;
      if(context == null) return;
      if(!context.mounted) return;
      showAppUpdateOrNot(context, appUpdate);
    }
  }
}