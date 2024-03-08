import 'package:flutter/material.dart';
import 'package:todo_y_pomodoro_app/core/navigation.dart';
import 'package:todo_y_pomodoro_app/core/utils.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/alerts.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/custom_icon_button.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/v_spacing.dart';
import 'package:todo_y_pomodoro_app/features/pomodoro/pages/pomodoro_page.dart';
import 'package:todo_y_pomodoro_app/features/tasks/widgets/edit_task_sheet.dart';

class TaskListItem extends StatelessWidget {
  final bool pomodoro;
  final bool fromPomodoroPage;
  const TaskListItem({
    super.key,
    this.pomodoro = false,
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
          showCustomBottomSheet(context, const EditTaskSheet());
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: mqWidth(context, 80),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Este es un titulo bastante largo que ocupa todo edasdsadsadsal anchod e la pantalla", style: Theme.of(context).textTheme.bodyLarge, maxLines: 2, overflow: TextOverflow.ellipsis,),
                  const VSpacing(1),
                  Text("Este es un sutitulo", style: Theme.of(context).textTheme.bodySmall, maxLines: 1, overflow: TextOverflow.ellipsis,),
                ],
              ),
            ),
            CustomIconButton(
              borderRadius: 30,
              size: 10, 
              borderColor: const Color(0xff919191),
              onPressed: (){
                if(pomodoro && !fromPomodoroPage){
                  Navigator.push(context, cupertinoNavigationRoute(context, const PomodoroPage()));
                }
              }, 
              icon: pomodoro ? const Icon(Icons.play_arrow_rounded) : const Icon(Icons.check)
            )
          ],
        ),
      ),
    );
  }
}