import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:provider/provider.dart';
import 'package:todo_y_pomodoro_app/core/utils.dart';
import 'package:todo_y_pomodoro_app/features/auth/providers/user_provider.dart';
import 'package:todo_y_pomodoro_app/features/common/models/error_response.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/alerts.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/app_header.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/custom_button.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/custom_multiline_box.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/custom_text_button.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/custom_text_form_field.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/sheet_content_layout.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/v_spacing.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/duration_selector.dart';
import 'package:todo_y_pomodoro_app/features/tasks/models/task_model.dart';
import 'package:todo_y_pomodoro_app/features/tasks/providers/tasks_activity_provider.dart';
import 'package:todo_y_pomodoro_app/features/tasks/providers/tasks_provider.dart';
import 'package:todo_y_pomodoro_app/features/tasks/widgets/task_group_list.dart';

class UpdateTaskSheet extends StatefulWidget {
  final TaskModel taskModel;
  const UpdateTaskSheet({
    super.key,
    required this.taskModel,
  });

  @override
  State<UpdateTaskSheet> createState() => _UpdateTaskSheetState();
}

class _UpdateTaskSheetState extends State<UpdateTaskSheet> {
  late TextEditingController taskTitleController;
  late TextEditingController taskDescriptionController;
  late Duration selectedDuration;
  String groupNameError = '';

  @override
  void initState() {
    taskTitleController = TextEditingController(text: widget.taskModel.title);
    taskDescriptionController = TextEditingController(text: widget.taskModel.description);
    selectedDuration = Duration(seconds: widget.taskModel.pomodoro);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final taskGroupId = Provider.of<TasksActivityProvider>(context, listen: false).selectedTaskGroupId;
    return SheetContentLayout(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppHeader(title: FlutterI18n.translate(context, "pages.update_task_sheet.title")),
            const VSpacing(3),
            const TaskGroupList(),
            const VSpacing(3),
            CustomTextFormField(
              controller: taskTitleController,
              keyboardType: TextInputType.emailAddress,
              hintText: FlutterI18n.translate(context, "pages.update_task_sheet.title_input"),
              errorMessage: groupNameError,
            ),const VSpacing(3),
            CustomMultilineBox(
              controller: taskDescriptionController,
              keyboardType: TextInputType.emailAddress,
              hintText: FlutterI18n.translate(context, "pages.update_task_sheet.description_input"),
              errorMessage: groupNameError,
            ),
            const VSpacing(2),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: mqWidth(context, 5)
              ),
              child: Row(
                children: [
                  Text(FlutterI18n.translate(context, "pages.update_task_sheet.pomodoro_input"), style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            ),
            const VSpacing(1),
            DurationSelector(
              onSelectDuration: (newDate){
                selectedDuration = newDate;
                setState(() {});
              }, 
              currentDuration: selectedDuration, 
              hintText: FlutterI18n.translate(context, "pages.update_task_sheet.select_time"),
            ),
            const VSpacing(5),
            Selector<TasksProvider, bool>(
              selector: (context, tasksProvider) => tasksProvider.updateTaskLoading,
              builder: (context, updateTaskLoading, _) {
                return CustomButton(
                  loading: updateTaskLoading,
                  onPressed: () async {
                    if(taskTitleController.text.isEmpty){
                      groupNameError = FlutterI18n.translate(context, "pages.update_task_sheet.title_not_empty");
                      setState(() {});
                      return;
                    }
                    FocusScope.of(context).unfocus();
                    final tasksProvider = Provider.of<TasksProvider>(context, listen: false);
                    final userId = Provider.of<UserProvider>(context, listen: false).currentUser.id;
                    final task = widget.taskModel.copyWith(
                      id: widget.taskModel.id,
                      updatedAt: DateTime.now(), 
                      deletedAt: null, 
                      title: taskTitleController.text,
                      description: taskDescriptionController.text,
                      pomodoro: selectedDuration.inSeconds,
                      userId: userId,
                      groupId: taskGroupId
                    );
                    final resp = await tasksProvider.updateTask(task);
                    if(resp == null) return;
                    if(resp is ErrorResponse){
                      if(!mounted) return;
                      showErrorAlert(context, FlutterI18n.translate(context, "general.dear"), [resp.message]);
                      return;
                    }
                    if(!mounted) return;
                    Navigator.pop(context);
                  },
                  label: FlutterI18n.translate(context, "pages.update_task_sheet.update"),
                  width: mqWidth(context, 90), 
                  color: Theme.of(context).primaryColor
                );
              }
            ),
            const VSpacing(3),
            Selector<TasksProvider, bool>(
              selector: (context, tasksProvider) => tasksProvider.deleteTaskLoading,
              builder: (context, deleteTaskLoading, _) {
                return CustomTextButton(
                  loading: deleteTaskLoading,
                  label: FlutterI18n.translate(context, "pages.update_task_sheet.delete"),
                  onPressed: () async {
                    FocusScope.of(context).unfocus();
                    final tasksProvider = Provider.of<TasksProvider>(context, listen: false);
                    final resp = await tasksProvider.deleteTask(widget.taskModel);
                    if(resp == null) return;
                    if(resp is ErrorResponse){
                      if(!mounted) return;
                      showErrorAlert(context, FlutterI18n.translate(context, "general.dear"), [resp.message]);
                      return;
                    }
                    if(!mounted) return;
                    Navigator.pop(context);
                  }, 
                );
              }
            ),
          ],
        ),
      )
    );
  }
}