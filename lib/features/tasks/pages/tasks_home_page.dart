import 'package:flutter/material.dart';
import 'package:todo_y_pomodoro_app/core/utils.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/custom_icon_button.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/scaffold_wrapper.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/v_spacing.dart';
import 'package:todo_y_pomodoro_app/features/tasks/widgets/task_group_item.dart';
import 'package:todo_y_pomodoro_app/features/tasks/widgets/task_list_item.dart';

class TasksHomePage extends StatelessWidget {
  const TasksHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      onWillPop: () => Future.value(false),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: mqWidth(context, 5)),
              child: Column(
                children: [
                  const VSpacing(5),
                  Row(
                    children: [
                      Text(
                        'Tareas',
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ],
                  ),
                  const VSpacing(3),
                  SizedBox(
                    height: mqHeigth(context, 5),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        TaskGroupItem(
                          onPressed: (){}, 
                          selected: true, 
                          label: "Quehaceres"
                        ),
                        TaskGroupItem(
                          onPressed: (){}, 
                          selected: false, 
                          label: "Auto"
                        ),
                        TaskGroupItem(
                          onPressed: (){}, 
                          selected: false, 
                          label: "Casa"
                        )
                      ],
                    ),
                  ),
                  const VSpacing(2),
                  const Divider(),
                  const TaskListItem(),
                  Divider(
                    height: mqHeigth(context, 3),
                  ),
                  const TaskListItem(),
                  Divider(
                    height: mqHeigth(context, 3),
                  ),
                  const TaskListItem(),
                  Divider(
                    height: mqHeigth(context, 3),
                  ),
                  const TaskListItem(),
                ]
              ),
            )
          )
        ]
      )
    );
  }
}