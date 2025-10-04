import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:provider/provider.dart';
import 'package:todo_y_pomodoro_app/core/navigation.dart';
import 'package:todo_y_pomodoro_app/core/task_state_enum.dart';
import 'package:todo_y_pomodoro_app/core/utils.dart';
import 'package:todo_y_pomodoro_app/features/common/models/error_response.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/alerts.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/custom_icon_button.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/v_spacing.dart';
import 'package:todo_y_pomodoro_app/features/pomodoro/pages/pomodoro_page.dart';
import 'package:todo_y_pomodoro_app/features/tasks/models/task_model.dart';
import 'package:todo_y_pomodoro_app/features/tasks/providers/tasks_provider.dart';
import 'package:todo_y_pomodoro_app/features/tasks/widgets/update_task_page.dart';

class TaskListItem extends StatelessWidget {
  final TaskModel taskModel;
  final bool fromPomodoroPage;
  final Function() onCompleteTask;
  const TaskListItem({
    super.key,
    required this.taskModel,
    this.fromPomodoroPage = false,
    required this.onCompleteTask
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
          if(taskModel.state != TaskState.pending.value) return;
          Navigator.push(context, cupertinoNavigationRoute(context, UpdateTaskPage(taskModel: taskModel)));
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
            if(taskModel.state == TaskState.pending.value)
            CustomIconButton(
              borderRadius: 30,
              size: 10, 
              borderColor: const Color(0xff919191),
              onPressed: () async {
                if(taskModel.hasPomodoro && !fromPomodoroPage){
                  Navigator.push(context, cupertinoNavigationRoute(context, PomodoroPage(
                    taskModel: taskModel,
                    rewarded: false,
                  )));
                  return;
                }
                final tasksProvider = Provider.of<TasksProvider>(context, listen: false);
                final resp = await tasksProvider.updateTask(taskModel.copyWith(
                  updatedAt: DateTime.now(), 
                  deletedAt: null,
                  state: TaskState.completed.value
                ));
                if(resp == null) return;
                if(resp is ErrorResponse){
                  // ignore: use_build_context_synchronously
                  if(!context.mounted) return;
                  showErrorAlert(context, FlutterI18n.translate(context, "general.dear"), [resp.message]);
                  return;
                }
                if(fromPomodoroPage){
                  onCompleteTask();
                }
              }, 
              icon: taskModel.hasPomodoro && !fromPomodoroPage ? const Icon(Icons.play_arrow_rounded) : const Icon(Icons.check)
            )
          ],
        ),
      ),
    );
  }
}