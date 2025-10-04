// ignore: depend_on_referenced_packages
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n_delegate.dart';
import 'package:flutter_i18n/loaders/file_translation_loader.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:todo_y_pomodoro_app/app.dart';

 class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  // final LocalController localManager = LocalController();
  // await localManager.initPrefs();
  final FlutterI18nDelegate flutterI18nDelegate = FlutterI18nDelegate(
    translationLoader: FileTranslationLoader(
      useCountryCode: false,
      fallbackFile: 'es',
      basePath: 'assets/i18n',
      forcedLocale: const Locale('es')
    ),
  );
  HttpOverrides.global = MyHttpOverrides();
  await SentryFlutter.init(
    (options) {
      options.dsn = 'https://7e15294fb0888de0721dcc5774abc562@o1110619.ingest.us.sentry.io/4506905814368256';
      // Set tracesSampleRate to 1.0 to capture 100% of transactions for performance monitoring.
      // We recommend adjusting this value in production.
      options.tracesSampleRate = 1.0;
    },
    appRunner: () => runApp(MyApp(flutterI18nDelegate: flutterI18nDelegate)),
  );
  
}