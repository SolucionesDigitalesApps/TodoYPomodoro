import 'package:flutter/material.dart';
import 'package:todo_y_pomodoro_app/core/utils.dart';

class SheetContentView extends StatelessWidget {
  final Widget child;
  final bool extendSheet;
  final Color? backgroundColor;
  final double paddingTopPer;
  const SheetContentView({
    super.key,
    required this.child,
    this.backgroundColor,
    this.extendSheet = false,
    this.paddingTopPer = 5
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        width: mqWidth(context, 100),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10)
          ),
          color: backgroundColor ?? Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        ),
        padding: EdgeInsets.only(
          left: mqWidth(context, 5),
          right: mqWidth(context, 5),
          top: mqWidth(context, paddingTopPer),
          bottom: extendSheet ? mqHeigth(context, 40) : mqWidth(context, 5),
        ),
        child: child
      )
    );
  }
}