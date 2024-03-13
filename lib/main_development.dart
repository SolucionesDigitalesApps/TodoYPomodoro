// ignore: depend_on_referenced_packages
import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n_delegate.dart';
import 'package:flutter_i18n/loaders/file_translation_loader.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:todo_y_pomodoro_app/app.dart';
import 'package:todo_y_pomodoro_app/features/common/controllers/local_controller.dart';

 class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  unawaited(MobileAds.instance.initialize());
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  final LocalController localManager = LocalController();
  await localManager.initPrefs();
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
      options.dsn = 'https://8d3e67ddb99467de4fec9f4465a90869@o1110619.ingest.us.sentry.io/4506898921095168';
      // Set tracesSampleRate to 1.0 to capture 100% of transactions for performance monitoring.
      // We recommend adjusting this value in production.
      options.tracesSampleRate = 1.0;
    },
    appRunner: () => runApp(MyApp(flutterI18nDelegate: flutterI18nDelegate)),
  );
  
}