import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_y_pomodoro_app/core/utils.dart';
import 'package:todo_y_pomodoro_app/features/auth/providers/user_provider.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/alerts.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/custom_icon_button.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/empty_view.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/error_view.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/loading_view.dart';
import 'package:todo_y_pomodoro_app/features/tasks/providers/task_groups_provider.dart';
import 'package:todo_y_pomodoro_app/features/tasks/widgets/edit_group_sheet.dart';
import 'package:todo_y_pomodoro_app/features/tasks/widgets/new_group_sheet.dart';
import 'package:todo_y_pomodoro_app/features/tasks/widgets/task_group_item.dart';

class TaskGroupList extends StatefulWidget {
  const TaskGroupList({super.key});

  @override
  State<TaskGroupList> createState() => _TaskGroupListState();
}

class _TaskGroupListState extends State<TaskGroupList> {
  late TaskGroupsProvider taskGroupsProvider;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      taskGroupsProvider.getTasksGroups(userProvider.currentUser.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    taskGroupsProvider = Provider.of<TaskGroupsProvider>(context);
    return taskGroupsProvider.taskGroupsLoading ? const LoadingView(heigth: 5) :
      taskGroupsProvider.taskGroupsError ? const ErrorView(heigth: 5) :
      taskGroupsProvider.taskGroups.isEmpty ? const EmptyView(heigth: 5) :
    SizedBox(
      height: mqHeigth(context, 5),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: taskGroupsProvider.taskGroups.length + 1,
        itemBuilder: (context, index) {
          if(index < taskGroupsProvider.taskGroups.length) {
            final item = taskGroupsProvider.taskGroups[index];
            return TaskGroupItem(
              taskGroupModel: item,
              key: Key("Task_group_item_${item.id}"),
              onPressed: (){}, 
              onLongPress: (){
                showCustomBottomSheet(context, const EditGroupSheet());
              },
              selected: true, 
            );
          }else{
            return CustomIconButton(
              size: 10, 
              borderColor: Theme.of(context).primaryColor,
              onPressed: (){
                showCustomBottomSheet(context, const NewGroupSheet());
              }, 
              icon: const Icon(Icons.add)
            );
          }
        },
      ),
    );
  }
}