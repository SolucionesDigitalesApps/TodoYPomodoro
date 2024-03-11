import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_y_pomodoro_app/core/task_state_enum.dart';
import 'package:todo_y_pomodoro_app/core/utils.dart';
import 'package:todo_y_pomodoro_app/features/auth/providers/user_provider.dart';
import 'package:todo_y_pomodoro_app/features/common/models/error_response.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/alerts.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/app_header.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/app_version_label.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/custom_button.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/custom_text_form_field.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/sheet_content_layout.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/v_spacing.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/duration_selector.dart';
import 'package:todo_y_pomodoro_app/features/tasks/models/task_model.dart';
import 'package:todo_y_pomodoro_app/features/tasks/providers/tasks_activity_provider.dart';
import 'package:todo_y_pomodoro_app/features/tasks/providers/tasks_provider.dart';
import 'package:todo_y_pomodoro_app/features/tasks/widgets/task_group_list.dart';

class CreateTaskSheet extends StatefulWidget {
  const CreateTaskSheet({
    super.key,
  });

  @override
  State<CreateTaskSheet> createState() => _CreateTaskSheetState();
}

class _CreateTaskSheetState extends State<CreateTaskSheet> {
  final taskTitleController = TextEditingController();
  final taskDescriptionController = TextEditingController();
  Duration selectedDuration = const Duration(seconds: 0);
  String groupNameError = '';

  @override
  Widget build(BuildContext context) {
    final taskGroupId = Provider.of<TasksActivityProvider>(context).selectedTaskGroupId;
    return SheetContentLayout(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const AppHeader(title: "Crear tarea"),
            const VSpacing(3),
            const TaskGroupList(),
            const VSpacing(3),
            CustomTextFormField(
              controller: taskTitleController,
              keyboardType: TextInputType.emailAddress,
              hintText: "Título de la tarea",
              errorMessage: groupNameError,
            ),const VSpacing(3),
            CustomTextFormField(
              controller: taskDescriptionController,
              keyboardType: TextInputType.emailAddress,
              hintText: "Descripción de la tarea (Opcional)",
              errorMessage: groupNameError,
            ),
            const VSpacing(2),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: mqWidth(context, 5)
              ),
              child: Row(
                children: [
                  Text("Agregar pomodoro (Opcional)", style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            ),
            const VSpacing(1),
            DurationSelector(
              onSelectDuration: (newDuration){
                selectedDuration = newDuration;
                setState(() {});
              }, 
              currentDuration: selectedDuration, 
              hintText: "Seleccion tiempo"
            ),
            const VSpacing(5),
            Selector<UserProvider, bool>(
              selector: (context, userProvider) => userProvider.updateUserLoading,
              builder: (context, updateUserLoading, _) {
                return Selector<TasksProvider, bool>(
                  selector: (context, tasksProvider) => tasksProvider.createTaskLoading,
                  builder: (context, createTaskLoading, _) {
                    return CustomButton(
                      loading: createTaskLoading || updateUserLoading,
                      onPressed: () async {
                        if(taskTitleController.text.isEmpty){
                          groupNameError = "El título de la tarea no puede estar vacío";
                          setState(() {});
                          return;
                        }
                        FocusScope.of(context).unfocus();
                        final tasksProvider = Provider.of<TasksProvider>(context, listen: false);
                        final userProvider = Provider.of<UserProvider>(context, listen: false);
                        final newOrder = userProvider.currentUser.lastTaskOrder + 1;
                        final task = TaskModel.empty.copyWith(
                          updatedAt: null, 
                          deletedAt: null, 
                          title: taskTitleController.text,
                          state: TaskState.pending.value,
                          description: taskDescriptionController.text,
                          pomodoro: selectedDuration.inSeconds,
                          userId: userProvider.currentUser.id,
                          groupId: taskGroupId,
                          order: newOrder
                        );
                        final resp = await tasksProvider.createTask(task);
                        if(resp == null) return;
                        if(resp is ErrorResponse){
                          if(!mounted) return;
                          showErrorAlert(context, "Estimado usuario", [resp.message]);
                          return;
                        }
                        final respUser = await userProvider.updateUser(userProvider.currentUser.copyWith(
                          lastTaskOrder: newOrder
                        ));
                        if(respUser == null) return;
                        if(respUser is ErrorResponse){
                          if(!mounted) return;
                          showErrorAlert(context, "Estimado usuario", [resp.message]);
                          return;
                        }
                        userProvider.setNewUser(userProvider.currentUser.copyWith(
                          lastTaskOrder: newOrder
                        ));
                        if(!mounted) return;
                        Navigator.pop(context);
                      },
                      label: "Crear tarea", 
                      width: mqWidth(context, 90), 
                      color: Theme.of(context).primaryColor
                    );
                  }
                );
              }
            ),
            const VSpacing(2),
            const AppVersionLabel(),
          ],
        ),
      )
    );
  }
}