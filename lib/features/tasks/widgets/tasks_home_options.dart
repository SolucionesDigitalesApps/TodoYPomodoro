import 'package:flutter/material.dart';
import 'package:todo_y_pomodoro_app/core/navigation.dart';
import 'package:todo_y_pomodoro_app/core/utils.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/alerts.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/custom_icon_button.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/h_spacing.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/language_bottom_sheet.dart';
import 'package:todo_y_pomodoro_app/features/tasks/pages/archived_tasks_page.dart';

class TasksHomeOptions extends StatelessWidget {
  final Function() onSignOut;
  const TasksHomeOptions({
    super.key,
    required this.onSignOut
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: mqWidth(context, 5)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Tareas',
            style: Theme.of(context).textTheme.displayMedium,
          ),
          Row(
            children: [
              CustomIconButton(
                borderRadius: 30,
                size: 10, 
                borderColor: const Color(0xff919191),
                onPressed: (){
                  Navigator.push(context, cupertinoNavigationRoute(context, const ArchivedTasksPage()));
                }, 
                icon: const Icon(Icons.archive_outlined)
              ),
              const HSpacing(2),
              CustomIconButton(
                borderRadius: 30,
                size: 10, 
                borderColor: const Color(0xff919191),
                onPressed: (){
                  showCustomBottomSheet(context, const LanguageBottomSheet());
                }, 
                icon: const Icon(Icons.language)
              ),
              const HSpacing(2),
              CustomIconButton(
                borderRadius: 30,
                size: 10, 
                borderColor: const Color(0xff919191),
                onPressed: onSignOut,
                icon: const Icon(Icons.logout)
              ),
            ],
          ),
        ],
      ),
    );
  }
}