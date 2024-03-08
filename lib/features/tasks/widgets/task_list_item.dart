import 'package:flutter/material.dart';
import 'package:todo_y_pomodoro_app/core/utils.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/alerts.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/custom_icon_button.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/v_spacing.dart';
import 'package:todo_y_pomodoro_app/features/tasks/widgets/edit_task_sheet.dart';

class TaskListItem extends StatelessWidget {
  const TaskListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
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
              children: const [
                Text("Este es un titulo bastante largo que ocupa todo edasdsadsadsal anchod e la pantalla", style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w500
                ), maxLines: 2, overflow: TextOverflow.ellipsis,),
                VSpacing(1),
                Text("Este es un sutitulo", style: TextStyle(
                  fontSize: 16
                ), maxLines: 1, overflow: TextOverflow.ellipsis,),
              ],
            ),
          ),
          CustomIconButton(
            borderRadius: 30,
            size: 10, 
            borderColor: const Color(0xff919191),
            onPressed: (){}, 
            icon: const Icon(Icons.check)
          )
        ],
      ),
    );
  }
}