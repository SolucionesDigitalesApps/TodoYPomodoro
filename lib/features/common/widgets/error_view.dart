import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:todo_y_pomodoro_app/core/utils.dart';

class ErrorView extends StatelessWidget {
  final double heigth;
  const ErrorView({
    Key? key,
    required this.heigth
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: mqHeigth(context, heigth),
      child: Center(
        child: Text(FlutterI18n.translate(context, "general.error"))
      ),
    );
  }
}