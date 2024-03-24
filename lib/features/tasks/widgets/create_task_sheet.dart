import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:provider/provider.dart';
import 'package:todo_y_pomodoro_app/core/task_state_enum.dart';
import 'package:todo_y_pomodoro_app/core/utils.dart';
import 'package:todo_y_pomodoro_app/features/auth/providers/user_provider.dart';
import 'package:todo_y_pomodoro_app/features/common/models/error_response.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/alerts.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/app_header.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/app_version_label.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/custom_button.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/custom_multiline_box.dart';
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
            AppHeader(title: FlutterI18n.translate(context, "pages.create_task_sheet.title")),
            const VSpacing(3),
            const TaskGroupList(),
            const VSpacing(3),
            CustomTextFormField(
              autofocus: true,
              controller: taskTitleController,
              keyboardType: TextInputType.emailAddress,
              hintText: FlutterI18n.translate(context, "pages.create_task_sheet.title_input"),
              errorMessage: groupNameError,
              maxLength: 50,
            ),const VSpacing(3),
            CustomMultilineBox(
              controller: taskDescriptionController,
              keyboardType: TextInputType.emailAddress,
              hintText: FlutterI18n.translate(context, "pages.create_task_sheet.description_input"),
              errorMessage: groupNameError,
              maxLength: 200,
            ),
            const VSpacing(2),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: mqWidth(context, 5)
              ),
              child: Row(
                children: [
                  Text(FlutterI18n.translate(context, "pages.create_task_sheet.pomodoro_input"), style: Theme.of(context).textTheme.bodyMedium),
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
              hintText: FlutterI18n.translate(context, "pages.create_task_sheet.select_time")
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
                          groupNameError = FlutterI18n.translate(context, "pages.create_task_sheet.title_not_empty");
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
                          showErrorAlert(context, FlutterI18n.translate(context, "general.dear"), [resp.message]);
                          return;
                        }
                        final newUser = userProvider.currentUser.copyWith(
                          lastTaskOrder: newOrder
                        );
                        final respUser = await userProvider.updateUser(newUser);
                        if(respUser == null) return;
                        if(respUser is ErrorResponse){
                          if(!mounted) return;
                          showErrorAlert(context, FlutterI18n.translate(context, "general.dear"), [resp.message]);
                          return;
                        }
                        userProvider.setNewUser(newUser);
                        if(!mounted) return;
                        Navigator.pop(context);
                      },
                      label: FlutterI18n.translate(context, "pages.create_task_sheet.create"), 
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