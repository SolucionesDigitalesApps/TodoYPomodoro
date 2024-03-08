import 'package:flutter/material.dart';
import 'package:todo_y_pomodoro_app/core/navigation.dart';
import 'package:todo_y_pomodoro_app/core/utils.dart';
import 'package:todo_y_pomodoro_app/features/auth/pages/sign_in_page.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/alerts.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/custom_icon_button.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/h_spacing.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/scaffold_wrapper.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/v_spacing.dart';
import 'package:todo_y_pomodoro_app/features/tasks/pages/archived_tasks_page.dart';
import 'package:todo_y_pomodoro_app/features/tasks/widgets/create_task_sheet.dart';
import 'package:todo_y_pomodoro_app/features/tasks/widgets/task_group_list.dart';
import 'package:todo_y_pomodoro_app/features/tasks/widgets/task_list_item.dart';

class TasksHomePage extends StatelessWidget {
  const TasksHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      onWillPop: () => Future.value(false),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                const VSpacing(5),
                Container(
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
                              Navigator.push(context, cupertinoNavigationRoute(context, const ArchivedTasksPage()));
                            }, 
                            icon: const Icon(Icons.language)
                          ),
                          const HSpacing(2),
                          CustomIconButton(
                            borderRadius: 30,
                            size: 10, 
                            borderColor: const Color(0xff919191),
                            onPressed: (){
                              Navigator.pushAndRemoveUntil(context, materialNavigationRoute(context, const SignInPage()), (route) => false);
                            }, 
                            icon: const Icon(Icons.logout)
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const VSpacing(3),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: mqWidth(context, 5)
                  ),
                  child: const TaskGroupList()
                ),
                const VSpacing(2),
                const Divider(),
                SizedBox(
                  height: mqHeigth(context, 80),
                  child: ReorderableListView(
                    onReorder: (oldIndex, newIndex) {
                      
                    },
                    padding: EdgeInsets.zero,
                    children: const[
                      TaskListItem(
                        key: Key("1"),
                      ),
                      TaskListItem(
                        key: Key("2"),
                        pomodoro: true,
                      ),
                      TaskListItem(
                        key: Key("3"),
                      ),
                      TaskListItem(
                        key: Key("4"),
                      ),
                      TaskListItem(
                        key: Key("5"),
                      ),
                      TaskListItem(
                        key: Key("6"),
                      ),
                      TaskListItem(
                        key: Key("7"),
                      ),
                      TaskListItem(
                        key: Key("8"),
                      ),
                      TaskListItem(
                        key: Key("9"),
                      ),
                      //TODO: Añadir espacio al final
                    ],
                  ),
                ),
              ]
            )
          )
        ]
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: (){
          showCustomBottomSheet(context, const CreateTaskSheet());
        }, 
        label: const Text("Nueva tarea"), 
        icon: const Icon(Icons.add),
      ),
    );
  }
}