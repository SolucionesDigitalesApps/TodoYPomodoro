import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_y_pomodoro_app/core/navigation.dart';
import 'package:todo_y_pomodoro_app/core/utils.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/alerts.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/custom_icon_button.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/v_spacing.dart';
import 'package:todo_y_pomodoro_app/features/pomodoro/pages/pomodoro_page.dart';
import 'package:todo_y_pomodoro_app/features/tasks/models/task_model.dart';
import 'package:todo_y_pomodoro_app/features/tasks/providers/tasks_activity_provider.dart';
import 'package:todo_y_pomodoro_app/features/tasks/widgets/update_task_sheet.dart';

class TaskListItem extends StatelessWidget {
  final TaskModel taskModel;
  final bool fromPomodoroPage;
  const TaskListItem({
    super.key,
    required this.taskModel,
    this.fromPomodoroPage = false
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: mqHeigth(context, 1.5),
        horizontal: mqWidth(context, 5)
      ),
      child: InkWell(
        onTap: (){
          final tasksActivityProvider = Provider.of<TasksActivityProvider>(context, listen: false);
          showCustomBottomSheet(context, UpdateTaskSheet(
            taskModel: taskModel,
            taskGroupId: tasksActivityProvider.selectedTaskGroupId,
          ));
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: mqWidth(context, 80),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(taskModel.title, style: Theme.of(context).textTheme.bodyLarge, maxLines: 2, overflow: TextOverflow.ellipsis,),
                  const VSpacing(1),
                  if(taskModel.hasDescription) Text(taskModel.description, style: Theme.of(context).textTheme.bodySmall, maxLines: 1, overflow: TextOverflow.ellipsis,),
                ],
              ),
            ),
            CustomIconButton(
              borderRadius: 30,
              size: 10, 
              borderColor: const Color(0xff919191),
              onPressed: (){
                if(taskModel.hasPomodoro && !fromPomodoroPage){
                  Navigator.push(context, cupertinoNavigationRoute(context, PomodoroPage(
                    taskModel: taskModel,
                  )));
                }
              }, 
              icon: taskModel.hasPomodoro ? const Icon(Icons.play_arrow_rounded) : const Icon(Icons.check)
            )
          ],
        ),
      ),
    );
  }
}