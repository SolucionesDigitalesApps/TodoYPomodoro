import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/alerts.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/scaffold_wrapper.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/v_spacing.dart';
import 'package:todo_y_pomodoro_app/features/tasks/providers/task_groups_provider.dart';
import 'package:todo_y_pomodoro_app/features/tasks/providers/tasks_activity_provider.dart';
import 'package:todo_y_pomodoro_app/features/tasks/widgets/create_task_group_sheet.dart';
import 'package:todo_y_pomodoro_app/features/tasks/widgets/create_task_sheet.dart';
import 'package:todo_y_pomodoro_app/features/tasks/widgets/task_group_list.dart';
import 'package:todo_y_pomodoro_app/features/tasks/widgets/tasks_home_options.dart';
import 'package:todo_y_pomodoro_app/features/tasks/widgets/tasks_list.dart';

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
            child: Column(
              children: const [
                VSpacing(5),
                TasksHomeOptions(),
                VSpacing(3),
                TaskGroupList(),
                VSpacing(2),
                Divider(),
                TasksList()
              ]
            )
          )
        ]
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: (){
          final taskGroupsProvider = Provider.of<TaskGroupsProvider>(context, listen: false);
          if(taskGroupsProvider.taskGroups.isEmpty){
            showCustomBottomSheet(context, const CreateTaskGroupSheet());
            return;
          }
          final tasksActivityProvider = Provider.of<TasksActivityProvider>(context, listen: false);
          showCustomBottomSheet(context, CreateTaskSheet(
            taskGroupId: tasksActivityProvider.selectedTaskGroupId,
          ));
        }, 
        label: const Text("Nueva tarea"), 
        icon: const Icon(Icons.add),
      ),
    );
  }
}