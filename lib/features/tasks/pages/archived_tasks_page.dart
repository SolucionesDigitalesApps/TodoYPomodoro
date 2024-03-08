import 'package:flutter/material.dart';
import 'package:todo_y_pomodoro_app/core/utils.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/app_header.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/scaffold_wrapper.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/v_spacing.dart';
import 'package:todo_y_pomodoro_app/features/tasks/widgets/task_group_list.dart';
import 'package:todo_y_pomodoro_app/features/tasks/widgets/task_list_item.dart';

class ArchivedTasksPage extends StatelessWidget {
  const ArchivedTasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const VSpacing(5),
            const AppHeader(title: "Tareas completadas"),
            const VSpacing(5),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: mqWidth(context, 5)
              ),
              child: const TaskGroupList()
            ),
            const VSpacing(3),
            const TaskListItem(
              key: Key("2"),
              pomodoro: true,
            ),
            const TaskListItem(
              key: Key("3"),
            ),
          ],
        ),
      ),
    );
  }
}