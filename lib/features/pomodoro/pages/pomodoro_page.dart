import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:todo_y_pomodoro_app/core/utils.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/app_header.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/custom_icon_button.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/h_spacing.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/scaffold_wrapper.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/v_spacing.dart';
import 'package:todo_y_pomodoro_app/features/tasks/widgets/task_list_item.dart';

class PomodoroPage extends StatefulWidget {
  const PomodoroPage({super.key});

  @override
  State<PomodoroPage> createState() => _PomodoroPageState();
}

class _PomodoroPageState extends State<PomodoroPage> {
  CountDownController controller = CountDownController();
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
                const TaskListItem(
                  fromPomodoroPage: true,
                ),
                const VSpacing(3),
                CircularCountDownTimer(
                  controller: controller,
                  duration: 100,
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
                ),
                const VSpacing(3),
                const Text("Stay focus for 25 minutes", style: TextStyle(
                  fontSize: 18
                )),
                const VSpacing(2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomIconButton(
                      borderRadius: 30,
                      size: 15, 
                      onPressed: (){}, 
                      fillColor: const Color(0xffF2F2F2),
                      icon: const Icon(Icons.refresh_rounded, color: Color(0xffAFAFAF))
                    ),
                    const HSpacing(3),
                    CustomIconButton(
                      borderRadius: 50,
                      size: 24, 
                      fillColor: Theme.of(context).primaryColor,
                      onPressed: (){}, 
                      icon: const Icon(Icons.pause, color: Colors.white, size: 30)
                    ),
                    const HSpacing(3),
                    CustomIconButton(
                      borderRadius: 30,
                      size: 15, 
                      fillColor: const Color(0xffF2F2F2),
                      onPressed: (){}, 
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