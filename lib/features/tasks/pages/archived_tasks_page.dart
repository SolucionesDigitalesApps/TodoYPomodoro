import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_y_pomodoro_app/core/utils.dart';
import 'package:todo_y_pomodoro_app/features/auth/providers/user_provider.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/app_header.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/error_view.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/loading_view.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/scaffold_wrapper.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/v_spacing.dart';
import 'package:todo_y_pomodoro_app/features/tasks/providers/tasks_activity_provider.dart';
import 'package:todo_y_pomodoro_app/features/tasks/providers/tasks_provider.dart';
import 'package:todo_y_pomodoro_app/features/tasks/widgets/task_group_list.dart';
import 'package:todo_y_pomodoro_app/features/tasks/widgets/task_list_item.dart';

class ArchivedTasksPage extends StatefulWidget {
  const ArchivedTasksPage({super.key});

  @override
  State<ArchivedTasksPage> createState() => _ArchivedTasksPageState();
}

class _ArchivedTasksPageState extends State<ArchivedTasksPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userId = Provider.of<UserProvider>(context, listen: false).currentUser.id;
      final tasksActivityProvider = Provider.of<TasksActivityProvider>(context, listen: false);
      if(tasksActivityProvider.selectedTaskGroupId.isNotEmpty){
        Provider.of<TasksProvider>(context, listen: false).getTasksArchivedSubscription(userId, tasksActivityProvider.selectedTaskGroupId);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const VSpacing(5),
            const AppHeader(title: "Tareas completadas"),
            const VSpacing(5),
            const TaskGroupList(),
            const VSpacing(3),
            Builder(
              builder: (context) {
                final tasksProvider = Provider.of<TasksProvider>(context, listen: false);
                return  tasksProvider.tasksArchivedLoading ? const LoadingView(heigth: 60) :
                tasksProvider.tasksArchivedError ? const ErrorView(heigth: 60) : 
                tasksProvider.tasksArchived.isEmpty ? const ErrorView(heigth: 60) : 
                SizedBox(
                  height: mqHeigth(context, 60),
                  child: ReorderableListView.builder(
                    onReorder: (oldIndex, newIndex) {
                      
                    },
                    itemCount: tasksProvider.tasksArchived.length,
                    itemBuilder: (context, index) {
                      final taskModel = tasksProvider.tasksArchived[index];
                      return TaskListItem(
                        key: Key("task_list_item_${taskModel.id}"),
                        taskModel: taskModel
                      );
                    },
                    padding: EdgeInsets.zero,
                  ),
                );
              },
            )
            
            /* const TaskListItem(
              key: Key("2"),
              pomodoro: true,
            ),
            const TaskListItem(
              key: Key("3"),
            ), */
          ],
        ),
      ),
    );
  }
}