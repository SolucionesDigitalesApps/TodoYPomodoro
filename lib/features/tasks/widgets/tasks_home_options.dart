import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:todo_y_pomodoro_app/core/navigation.dart';
import 'package:todo_y_pomodoro_app/core/utils.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/alerts.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/custom_icon_button.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/h_spacing.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/language_bottom_sheet.dart';
import 'package:todo_y_pomodoro_app/features/tasks/pages/archived_tasks_page.dart';

class TasksHomeOptions extends StatefulWidget {
  final Function() onSignOut;
  final Function() onChangeLanguage;
  const TasksHomeOptions({
    super.key,
    required this.onSignOut,
    required this.onChangeLanguage,
  });

  @override
  State<TasksHomeOptions> createState() => _TasksHomeOptionsState();
}

class _TasksHomeOptionsState extends State<TasksHomeOptions> {
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
          Row(
            children: [
              Image.network(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSvkVO8gT6xF1U5-humPo8JKqlpBJEv-rdajA&s', // Replace with your image URL
                width: 50.0,
                height: 50.0,
                fit: BoxFit.cover,
              ),
              const HSpacing(2),
              Text(
                FlutterI18n.translate(context, "general.tasks"),
                style: Theme.of(context).textTheme.displayMedium, 
              ),
            ],
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
                  showCustomBottomSheet(context, const LanguageBottomSheet()).then((value) {
                    widget.onChangeLanguage();
                  });
                }, 
                icon: const Icon(Icons.language)
              ),
              const HSpacing(2),
              CustomIconButton(
                borderRadius: 30,
                size: 10, 
                borderColor: const Color(0xff919191),
                onPressed: widget.onSignOut,
                icon: const Icon(Icons.logout)
              ),
            ],
          ),
        ],
      ),
    );
  }
}