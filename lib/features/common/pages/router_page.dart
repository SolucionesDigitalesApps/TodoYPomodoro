import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_y_pomodoro_app/features/auth/controllers/auth_controller.dart';
import 'package:todo_y_pomodoro_app/features/auth/models/user_model.dart';
import 'package:todo_y_pomodoro_app/features/auth/providers/user_provider.dart';
import 'package:todo_y_pomodoro_app/features/common/controllers/notification_controller.dart';
import 'package:todo_y_pomodoro_app/features/common/models/error_response.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/scaffold_wrapper.dart';
import 'package:todo_y_pomodoro_app/features/tasks/pages/tasks_home_page.dart';
import 'package:todo_y_pomodoro_app/features/tasks/providers/tasks_activity_provider.dart';

class RouterPage extends StatefulWidget {
  const RouterPage({super.key});

  @override
  State<RouterPage> createState() => _RouterPageState();
}

class _RouterPageState extends State<RouterPage> {
  final notificationController = NotificationController();
  final authController = AuthController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadSession();
    });
  }

  Future<void> loadSession() async {
    final resp = await Provider.of<UserProvider>(context, listen: false).getCurrentUser();
    if(resp is ErrorResponse){
      if(mounted){
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const TasksHomePage()), (route) => false);
      }
    }else{
      final user = resp as UserModel;
      final token = await notificationController.getToken() ?? "";
      await authController.updateToken(user.id, token);
      if(mounted){
        Provider.of<TasksActivityProvider>(context, listen: false).selectedTaskGroupId = user.lastGroupId;
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const TasksHomePage()), (route) => false);
      }
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return const ScaffoldWrapper(
      backgroundColor: Colors.white,
      body: Center(
        child: CircularProgressIndicator()
      ),
    );
  }
}