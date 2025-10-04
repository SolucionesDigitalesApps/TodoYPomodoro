import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Material App Bar'),
        ),
        body: const Center(
          child: Text('Hello World'),
        ),
      ),
    );
  }
}