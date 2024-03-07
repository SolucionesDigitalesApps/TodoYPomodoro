import 'package:flutter/material.dart';
import 'package:todo_y_pomodoro_app/core/utils.dart';

class TaskGroupItem extends StatelessWidget {
  final Function() onPressed;
  final bool selected;
  final String label;
  const TaskGroupItem({
    super.key,
    required this.onPressed,
    required this.selected,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        right: mqWidth(context, 3)
      ),
      height: mqHeigth(context, 5),
      child: RawMaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: selected ? BorderSide.none : BorderSide(
            color: Theme.of(context).primaryColor
          )
        ),
        onPressed: onPressed,
        padding: EdgeInsets.symmetric(
          horizontal: mqWidth(context, 3)
        ),
        fillColor: selected ? Theme.of(context).primaryColor : null,
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: selected ? Colors.white : Theme.of(context).primaryColor,
              fontSize: 16
            )
          ),
        ),
      ),
    );
  }
}