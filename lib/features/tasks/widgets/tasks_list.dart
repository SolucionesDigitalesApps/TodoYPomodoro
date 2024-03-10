import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_y_pomodoro_app/core/utils.dart';
import 'package:todo_y_pomodoro_app/features/auth/providers/user_provider.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/error_view.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/loading_view.dart';
import 'package:todo_y_pomodoro_app/features/tasks/providers/tasks_activity_provider.dart';
import 'package:todo_y_pomodoro_app/features/tasks/providers/tasks_provider.dart';
import 'package:todo_y_pomodoro_app/features/tasks/widgets/task_list_item.dart';

class TasksList extends StatefulWidget {
  const TasksList({super.key});

  @override
  State<TasksList> createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userId = Provider.of<UserProvider>(context, listen: false).currentUser.id;
      final tasksActivityProvider = Provider.of<TasksActivityProvider>(context, listen: false);
      Provider.of<TasksProvider>(context, listen: false).getTasksSubscription(userId, tasksActivityProvider.selectedTaskGroupId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final tasksProvider = Provider.of<TasksProvider>(context);
    return tasksProvider.tasksLoading ? const LoadingView(heigth: 80) :
      tasksProvider.tasksError ? const ErrorView(heigth: 80) : 
    SizedBox(
      height: mqHeigth(context, 80),
      child: ReorderableListView.builder(
        onReorder: (oldIndex, newIndex) {
          
        },
        itemCount: tasksProvider.tasks.length,
        itemBuilder: (context, index) {
          final taskModel = tasksProvider.tasks[index];
          return TaskListItem(
            key: Key("task_list_item_${taskModel.id}"),
            taskModel: taskModel
          );
        },
        padding: EdgeInsets.zero,
        //TODO: Añadir espacio al final
      ),
    );
  }
}