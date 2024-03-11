import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_y_pomodoro_app/core/navigation.dart';
import 'package:todo_y_pomodoro_app/core/utils.dart';
import 'package:todo_y_pomodoro_app/features/auth/controllers/auth_controller.dart';
import 'package:todo_y_pomodoro_app/features/auth/pages/sign_in_page.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/alerts.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/custom_icon_button.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/h_spacing.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/language_bottom_sheet.dart';
import 'package:todo_y_pomodoro_app/features/tasks/pages/archived_tasks_page.dart';
import 'package:todo_y_pomodoro_app/features/tasks/providers/task_groups_provider.dart';
import 'package:todo_y_pomodoro_app/features/tasks/providers/tasks_activity_provider.dart';
import 'package:todo_y_pomodoro_app/features/tasks/providers/tasks_provider.dart';

class TasksHomeOptions extends StatelessWidget {
  const TasksHomeOptions({super.key});

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
                onPressed: () async {
                  final authController = AuthController();
                  await authController.signOut();
                  // ignore: use_build_context_synchronously
                  if(!context.mounted) return;
                  final taskGroupsProvider = Provider.of<TaskGroupsProvider>(context, listen: false);
                  final tasksActivityProvider = Provider.of<TasksActivityProvider>(context, listen: false);
                  final tasksProvider = Provider.of<TasksProvider>(context, listen: false);
                  taskGroupsProvider.disposeProvider();
                  tasksActivityProvider.disposeProvider();
                  tasksProvider.disposeProvider();
                  Navigator.pushAndRemoveUntil(context, materialNavigationRoute(context, const SignInPage()), (route) => false);
                }, 
                icon: const Icon(Icons.logout)
              ),
            ],
          ),
        ],
      ),
    );
  }
}