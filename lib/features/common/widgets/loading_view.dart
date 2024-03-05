import 'package:flutter/material.dart';
import 'package:todo_y_pomodoro_app/core/utils.dart';

class LoadingView extends StatelessWidget {
  final double heigth;
  const LoadingView({
    Key? key,
    required this.heigth
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: mqHeigth(context, heigth),
      child: Center(
        child: CircularProgressIndicator(
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}