import 'package:flutter/material.dart';
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
          const AppHeader(title: "Editar grupo de tareas"),
          const VSpacing(3),
          CustomTextFormField(
            autofocus: true,
            controller: taskGroupLabelController,
            keyboardType: TextInputType.emailAddress,
            hintText: "Ingrese el nombre del grupo",
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
                    groupNameError = "El nombre del grupo no puede estar vacío";
                    setState(() {});
                    return;
                  }
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
                    showErrorAlert(context, "Estimado usuario", [resp.message]);
                    return;
                  }
                  if(!mounted) return;
                  Navigator.pop(context);
                },
                label: "Editar", 
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
                label: "Eliminar grupo", 
                loading: deleteTaskLoading, 
                onPressed: () async {
                  final groupId = Provider.of<TasksActivityProvider>(context, listen: false).selectedTaskGroupId;
                  final tasksProvider = Provider.of<TasksProvider>(context, listen: false);
                  final currentTasks = tasksProvider.tasksPerGroup(groupId);
                  if(currentTasks.isNotEmpty){
                    showInfoAlert(context, "Estimado usuario", "No se puede eliminar el grupo porque tiene tareas relacionadas");
                    return;
                  }
                  final taskGroupsProvider = Provider.of<TaskGroupsProvider>(context, listen: false);
                  final resp = await taskGroupsProvider.deleteTaskGroup(widget.taskGroupModel);
                  if(resp == null) return;
                  if(resp is ErrorResponse){
                    if(!mounted) return;
                    showErrorAlert(context, "Estimado usuario", [resp.message]);
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