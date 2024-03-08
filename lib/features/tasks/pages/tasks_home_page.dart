import 'package:flutter/material.dart';
import 'package:todo_y_pomodoro_app/core/utils.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/alerts.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/custom_icon_button.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/scaffold_wrapper.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/v_spacing.dart';
import 'package:todo_y_pomodoro_app/features/tasks/widgets/create_task_sheet.dart';
import 'package:todo_y_pomodoro_app/features/tasks/widgets/edit_group_sheet.dart';
import 'package:todo_y_pomodoro_app/features/tasks/widgets/new_group_sheet.dart';
import 'package:todo_y_pomodoro_app/features/tasks/widgets/task_group_item.dart';
import 'package:todo_y_pomodoro_app/features/tasks/widgets/task_group_list.dart';
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
                  const TaskGroupList(),
                  const VSpacing(2),
                  SizedBox(
                    height: mqHeigth(context, 80),
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: [
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
                        Divider(
                          height: mqHeigth(context, 3),
                        ),
                        const TaskListItem(),
                        Divider(
                          height: mqHeigth(context, 3),
                        ),
                        const TaskListItem(),
                        const VSpacing(8)
                      ],
                    ),
                  ),
                ]
              ),
            )
          )
        ]
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: (){
          showCustomBottomSheet(context, const CreateTaskSheet());
        }, 
        label: const Text("Nueva tarea"), 
        icon: const Icon(Icons.add),
      ),
    );
  }
}