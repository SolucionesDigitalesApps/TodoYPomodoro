import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:provider/provider.dart';
import 'package:todo_y_pomodoro_app/core/navigation.dart';
import 'package:todo_y_pomodoro_app/core/utils.dart';
import 'package:todo_y_pomodoro_app/features/auth/controllers/auth_controller.dart';
import 'package:todo_y_pomodoro_app/features/auth/pages/sign_in_page.dart';
import 'package:todo_y_pomodoro_app/features/auth/providers/user_provider.dart';
import 'package:todo_y_pomodoro_app/features/common/controllers/common_controller.dart';
import 'package:todo_y_pomodoro_app/features/common/controllers/notification_controller.dart';
import 'package:todo_y_pomodoro_app/features/common/models/error_response.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/alerts.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/page_loader.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/scaffold_wrapper.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/v_spacing.dart';
import 'package:todo_y_pomodoro_app/features/tasks/models/task_group_model.dart';
import 'package:todo_y_pomodoro_app/features/tasks/providers/task_groups_provider.dart';
import 'package:todo_y_pomodoro_app/features/tasks/providers/tasks_activity_provider.dart';
import 'package:todo_y_pomodoro_app/features/tasks/providers/tasks_provider.dart';
import 'package:todo_y_pomodoro_app/features/tasks/widgets/create_task_group_sheet.dart';
import 'package:todo_y_pomodoro_app/features/tasks/widgets/create_task_sheet.dart';
import 'package:todo_y_pomodoro_app/features/tasks/widgets/task_group_list.dart';
import 'package:todo_y_pomodoro_app/features/tasks/widgets/tasks_home_options.dart';
import 'package:todo_y_pomodoro_app/features/tasks/widgets/tasks_list.dart';

class TasksHomePage extends StatefulWidget {
  const TasksHomePage({super.key});

  @override
  State<TasksHomePage> createState() => _TasksHomePageState();
}

class _TasksHomePageState extends State<TasksHomePage> {
  final commonController = CommonController();
  final notificationController = NotificationController();
  StreamSubscription<TaskGroupModel>? createdTaskGroupSubs;
  StreamSubscription<dynamic>? userSubs;
  StreamSubscription? notifSubs;

  @override
  void initState() {
    super.initState();
    final taskGroupsProvider = Provider.of<TaskGroupsProvider>(context, listen: false);
    taskGroupsProvider.selectTaskGroupStream.listen((event) {
      if(!mounted) return;
      final tasksActivityProvider = Provider.of<TasksActivityProvider>(context, listen: false);
      tasksActivityProvider.selectedTaskGroupId = event.id;
    });
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.getUserSubscription();
    userSubs = userProvider.userStream.listen((event) {
      if(!event.enabled){
        signOutUser(disabled: true);
      }
    });
    notifSubs = notificationController.mensajes.listen((event) {
      showInfoAlert(context, event.notification?.title ?? "", event.notification?.body ?? "");
    });
    getAppUpdate();
  }

  @override
  void dispose() {
    createdTaskGroupSubs?.cancel();
    notifSubs?.cancel();
    super.dispose();
  }

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
                TasksHomeOptions(
                  onSignOut: ()=> signOutUser(disabled: false),
                  onChangeLanguage: () {
                    setState(() {});
                  },
                ),
                const VSpacing(3),
                const TaskGroupList(),
                const VSpacing(2),
                const Divider(),
                const TasksList()
              ]
            )
          ),
          Selector<TasksProvider, bool>(
            selector: (context, userProvider) => userProvider.updateTaskLoading,
            builder: (context, updateTaskLoading, _) {
              return PageLoader(
                loading: updateTaskLoading, 
                message: FlutterI18n.translate(context, "pages.task_home.updating_tasks")
              );
            },
          ),
        ]
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: (){
          final taskGroupsProvider = Provider.of<TaskGroupsProvider>(context, listen: false);
          if(taskGroupsProvider.taskGroups.isEmpty){
            showCustomBottomSheet(context, const CreateTaskGroupSheet());
            return;
          }
          showCustomBottomSheet(context, const CreateTaskSheet());
        }, 
        label: Text(FlutterI18n.translate(context, "pages.task_home.new_task")), 
        icon: const Icon(Icons.add),
      ),
    );
  }

  void signOutUser({bool disabled = false}) async {
    final authController = AuthController();
    final resp = await authController.signOut();
    if(resp == null) return;
    if(resp is ErrorResponse){
      if(!mounted) return;
      showErrorAlert(context, FlutterI18n.translate(context, "general.dear"), [resp.message]);
      return;
    }
    // ignore: use_build_context_synchronously
    if(!context.mounted) return;
    final taskGroupsProvider = Provider.of<TaskGroupsProvider>(context, listen: false);
    final tasksActivityProvider = Provider.of<TasksActivityProvider>(context, listen: false);
    final tasksProvider = Provider.of<TasksProvider>(context, listen: false);
    taskGroupsProvider.disposeProvider();
    tasksActivityProvider.disposeProvider();
    tasksProvider.disposeProvider();
    Navigator.pushAndRemoveUntil(context, materialNavigationRoute(context, const SignInPage()), (route) => false);
    if(disabled){
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showErrorAlert(
          context,
          FlutterI18n.translate(context, "general.dear"),
          [FlutterI18n.translate(context, "general.disabled")]
        );
      });
    }
  }

  Future<void> getAppUpdate() async {
    final appUpdate = await commonController.checkForUpdates();
    if(appUpdate != null && mounted){
      showAppUpdateOrNot(context, appUpdate);
    }
  }
}