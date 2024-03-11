import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_y_pomodoro_app/core/date_utils.dart';
import 'package:todo_y_pomodoro_app/core/task_state_enum.dart';
import 'package:todo_y_pomodoro_app/core/utils.dart';
import 'package:todo_y_pomodoro_app/features/common/models/error_response.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/alerts.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/app_header.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/custom_icon_button.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/h_spacing.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/scaffold_wrapper.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/v_spacing.dart';
import 'package:todo_y_pomodoro_app/features/tasks/models/task_model.dart';
import 'package:todo_y_pomodoro_app/features/tasks/providers/tasks_provider.dart';
import 'package:todo_y_pomodoro_app/features/tasks/widgets/task_list_item.dart';

class PomodoroPage extends StatefulWidget {
  final TaskModel taskModel;
  const PomodoroPage({
    super.key,
    required this.taskModel,
  });

  @override
  State<PomodoroPage> createState() => _PomodoroPageState();
}

class _PomodoroPageState extends State<PomodoroPage> {
  CountDownController pomodoroController = CountDownController();
  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                const VSpacing(5),
                const AppHeader(title: "Pomodoro Timer"),
                const VSpacing(2),
                TaskListItem(
                  taskModel: widget.taskModel,
                  fromPomodoroPage: true,
                ),
                const VSpacing(3),
                CircularCountDownTimer(
                  controller: pomodoroController,
                  duration: widget.taskModel.pomodoro,
                  width: mqWidth(context, 70),
                  height: mqWidth(context, 70),
                  fillColor: Colors.white,
                  strokeWidth: 20,
                  isReverse: true,
                  ringColor: Theme.of(context).primaryColor,
                  textStyle: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                  ),
                  onComplete: () async {
                    await showSuccessAlert(context, "Estimado usuario", "La tarea ha finalizado");
                    // ignore: use_build_context_synchronously
                    if(!context.mounted) return;
                    final tasksProvider = Provider.of<TasksProvider>(context, listen: false);
                    final resp = await tasksProvider.updateTask(widget.taskModel.copyWith(
                      updatedAt: DateTime.now(), 
                      deletedAt: null,
                      state: TaskState.completed.value
                    ));
                    if(resp == null) return;
                    if(resp is ErrorResponse){
                      // ignore: use_build_context_synchronously
                      if(!context.mounted) return;
                      showErrorAlert(context, "Estimado usuario", [resp.message]);
                      return;
                    }
                    // ignore: use_build_context_synchronously
                    if(!context.mounted) return;
                    Navigator.pop(context);
                  },
                ),
                const VSpacing(3),
                Text("Stay focus for ${formatSeconds(widget.taskModel.pomodoro)}", style: Theme.of(context).textTheme.bodyMedium),
                const VSpacing(2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomIconButton(
                      borderRadius: 30,
                      size: 15, 
                      onPressed: (){
                        pomodoroController.restart();
                        setState(() {});
                      }, 
                      fillColor: const Color(0xffF2F2F2),
                      icon: const Icon(Icons.refresh_rounded, color: Color(0xffAFAFAF))
                    ),
                    const HSpacing(3),
                    CustomIconButton(
                      borderRadius: 50,
                      size: 24, 
                      fillColor: Theme.of(context).primaryColor,
                      onPressed: (){
                        if(pomodoroController.isPaused){
                          pomodoroController.resume();
                        }else{
                          pomodoroController.pause();
                        }
                        setState(() {});
                      }, 
                      icon: Icon(pomodoroController.isPaused ? Icons.play_arrow_rounded : Icons.pause, color: Colors.white, size: 30)
                    ),
                    const HSpacing(3),
                    CustomIconButton(
                      borderRadius: 30,
                      size: 15, 
                      fillColor: const Color(0xffF2F2F2),
                      onPressed: (){
                        pomodoroController.reset();
                      }, 
                      icon: const Icon(Icons.stop_rounded, color: Color(0xffAFAFAF))
                    ),
                  ],
                )
              ]
            )
          )
        ]
      )
    );
  }
}