import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:provider/provider.dart';
import 'package:todo_y_pomodoro_app/core/utils.dart';
import 'package:todo_y_pomodoro_app/features/common/models/error_response.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/alerts.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/app_header.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/custom_button.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/custom_text_button.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/custom_text_form_field.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/sheet_content_layout.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/v_spacing.dart';
import 'package:todo_y_pomodoro_app/features/tasks/models/task_group_model.dart';
import 'package:todo_y_pomodoro_app/features/tasks/providers/task_groups_provider.dart';
import 'package:todo_y_pomodoro_app/features/tasks/providers/tasks_activity_provider.dart';
import 'package:todo_y_pomodoro_app/features/tasks/providers/tasks_provider.dart';

class UpdateTaskGroupSheet extends StatefulWidget {
  final TaskGroupModel taskGroupModel;
  const UpdateTaskGroupSheet({
    super.key,
    required this.taskGroupModel
  });

  @override
  State<UpdateTaskGroupSheet> createState() => _UpdateTaskGroupSheetState();
}

class _UpdateTaskGroupSheetState extends State<UpdateTaskGroupSheet> {
  late TextEditingController taskGroupLabelController;
  String groupNameError = '';

  @override
  void initState() {
    taskGroupLabelController = TextEditingController(text: widget.taskGroupModel.label);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SheetContentLayout(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppHeader(title: FlutterI18n.translate(context, "pages.update_task_group_sheet.title")),
          const VSpacing(3),
          CustomTextFormField(
            autofocus: true,
            controller: taskGroupLabelController,
            keyboardType: TextInputType.emailAddress,
            hintText: FlutterI18n.translate(context, "pages.update_task_group_sheet.name_input"),
            errorMessage: groupNameError,
          ),
          const VSpacing(5),
          Selector<TaskGroupsProvider, bool>(
            selector: (context, taskGroupsProvider) => taskGroupsProvider.updateTaskGroupLoading,
            builder: (context, updateTaskGroupLoading, _) {
              return CustomButton(
                loading: updateTaskGroupLoading,
                onPressed: () async {
                  if(taskGroupLabelController.text.isEmpty){
                    groupNameError = FlutterI18n.translate(context, "pages.update_task_group_sheet.name_not_empty");
                    setState(() {});
                    return;
                  }
                  FocusScope.of(context).unfocus();
                  final taskGroupsProvider = Provider.of<TaskGroupsProvider>(context, listen: false);
                  final newTaskGroup = widget.taskGroupModel.copyWith(
                    label: taskGroupLabelController.text,
                    deletedAt: widget.taskGroupModel.deletedAt,
                    updatedAt: widget.taskGroupModel.updatedAt
                  );
                  final resp = await taskGroupsProvider.updateTaskGroup(newTaskGroup);
                  if(resp == null) return;
                  if(resp is ErrorResponse){
                    if(!mounted) return;
                    showErrorAlert(context, FlutterI18n.translate(context, "general.dears"), [resp.message]);
                    return;
                  }
                  if(!mounted) return;
                  Navigator.pop(context);
                },
                label: FlutterI18n.translate(context, "general.edit"), 
                width: mqWidth(context, 90), 
                color: Theme.of(context).primaryColor
              );
            }
          ),
          const VSpacing(3),
          Selector<TasksProvider, bool>(
            selector: (context, userProvider) => userProvider.deleteTaskLoading,
            builder: (context, deleteTaskLoading, _) {
              return CustomTextButton(
                label: FlutterI18n.translate(context, "pages.update_task_group_sheet.delete"), 
                loading: deleteTaskLoading, 
                onPressed: () async {
                  final groupId = Provider.of<TasksActivityProvider>(context, listen: false).selectedTaskGroupId;
                  final tasksProvider = Provider.of<TasksProvider>(context, listen: false);
                  final currentTasks = tasksProvider.tasksPerGroup(groupId);
                  if(currentTasks.isNotEmpty){
                    showInfoAlert(context, FlutterI18n.translate(context, "general.dear"), FlutterI18n.translate(context, "pages.update_task_group_sheet.cant_delete"));
                    return;
                  }
                  FocusScope.of(context).unfocus();
                  final taskGroupsProvider = Provider.of<TaskGroupsProvider>(context, listen: false);
                  final resp = await taskGroupsProvider.deleteTaskGroup(widget.taskGroupModel);
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
          )
        ],
      )
    );
  }
}