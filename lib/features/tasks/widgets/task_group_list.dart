import 'package:flutter/material.dart';
import 'package:todo_y_pomodoro_app/core/utils.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/alerts.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/custom_icon_button.dart';
import 'package:todo_y_pomodoro_app/features/tasks/widgets/edit_group_sheet.dart';
import 'package:todo_y_pomodoro_app/features/tasks/widgets/new_group_sheet.dart';
import 'package:todo_y_pomodoro_app/features/tasks/widgets/task_group_item.dart';

class TaskGroupList extends StatelessWidget {
  const TaskGroupList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: mqHeigth(context, 5),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          TaskGroupItem(
            onPressed: (){}, 
            onLongPress: (){
              showCustomBottomSheet(context, const EditGroupSheet());
            },
            selected: true, 
            label: "Quehaceres"
          ),
          TaskGroupItem(
            onPressed: (){},
            onLongPress: (){
              
            }, 
            selected: false, 
            label: "Auto"
          ),
          TaskGroupItem(
            onPressed: (){}, 
            onLongPress: (){
              
            },
            selected: false, 
            label: "Casa"
          ),
          CustomIconButton(
            size: 10, 
            borderColor: Theme.of(context).primaryColor,
            onPressed: (){
              showCustomBottomSheet(context, const NewGroupSheet());
            }, 
            icon: const Icon(Icons.add)
          )
        ],
      ),
    );
  }
}