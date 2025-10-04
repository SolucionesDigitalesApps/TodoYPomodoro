import 'package:flutter/material.dart';
import 'package:todo_y_pomodoro_app/core/utils.dart';
import 'package:todo_y_pomodoro_app/features/tasks/models/task_group_model.dart';

class TaskGroupItem extends StatelessWidget {
  final TaskGroupModel taskGroupModelTarget;
  final String taskGroupModelSelected;
  final Function() onPressed;
  final Function() onLongPress;
  const TaskGroupItem({
    super.key,
    required this.taskGroupModelTarget,
    required this.taskGroupModelSelected,
    required this.onPressed,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final bool selected = taskGroupModelSelected == taskGroupModelTarget.id;
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
        onLongPress: onLongPress,
        padding: EdgeInsets.symmetric(
          horizontal: mqWidth(context, 3)
        ),
        fillColor: selected ? Theme.of(context).primaryColor : null,
        child: Center(
          child: Text(
            taskGroupModelTarget.label,
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