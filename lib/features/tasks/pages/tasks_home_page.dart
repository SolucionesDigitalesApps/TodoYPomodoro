import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/alerts.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/page_loader.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/scaffold_wrapper.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/v_spacing.dart';
import 'package:todo_y_pomodoro_app/features/tasks/models/task_group_model.dart';
import 'package:todo_y_pomodoro_app/features/tasks/providers/task_groups_provider.dart';
import 'package:todo_y_pomodoro_app/features/tasks/providers/tasks_activity_provider.dart';
import 'package:todo_y_pomodoro_app/features/tasks/providers/tasks_provider.dart';
import 'package:todo_y_pomodoro_app/features/tasks/widgets/create_task_group_sheet.dart';
import 'package:todo_y_pomodoro_app/features/tasks/widgets/create_task_sheet.dart';
import 'package:todo_y_pomodoro_app/features/tasks/widgets/task_group_list.dart';
import 'package:todo_y_pomodoro_app/features/tasks/widgets/tasks_home_options.dart';
import 'package:todo_y_pomodoro_app/features/tasks/widgets/tasks_list.dart';

class TasksHomePage extends StatefulWidget {
  const TasksHomePage({super.key});

  @override
  State<TasksHomePage> createState() => _TasksHomePageState();
}

class _TasksHomePageState extends State<TasksHomePage> {
  StreamSubscription<TaskGroupModel>? createdTaskGroupSubs;

  @override
  void initState() {
    super.initState();
    final taskGroupsProvider = Provider.of<TaskGroupsProvider>(context, listen: false);
    taskGroupsProvider.selectTaskGroupStream.listen((event) {
      if(!mounted) return;
      final tasksActivityProvider = Provider.of<TasksActivityProvider>(context, listen: false);
      tasksActivityProvider.selectedTaskGroupId = event.id;
    });
  }

  @override
  void dispose() {
    createdTaskGroupSubs?.cancel();
    super.dispose();
  }

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
          ),
          Selector<TasksProvider, bool>(
            selector: (context, userProvider) => userProvider.updateTaskLoading,
            builder: (context, updateTaskLoading, _) {
              return PageLoader(
                loading: updateTaskLoading, 
                message: "Actualizando tareas..."
              );
            },
          ),
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
          showCustomBottomSheet(context, const CreateTaskSheet());
        }, 
        label: const Text("Nueva tarea"), 
        icon: const Icon(Icons.add),
      ),
    );
  }
}