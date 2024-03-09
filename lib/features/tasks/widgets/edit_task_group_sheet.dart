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

class EditTaskGroupSheet extends StatefulWidget {
  final TaskGroupModel taskGroupModel;
  const EditTaskGroupSheet({
    super.key,
    required this.taskGroupModel
  });

  @override
  State<EditTaskGroupSheet> createState() => _EditTaskGroupSheetState();
}

class _EditTaskGroupSheetState extends State<EditTaskGroupSheet> {
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
          Selector<TaskGroupsProvider, bool>(
            selector: (context, userProvider) => userProvider.deleteTaskGroupLoading,
            builder: (context, deleteTaskGroupLoading, _) {
              return CustomTextButton(
                label: "Eliminar grupo", 
                loading: deleteTaskGroupLoading, 
                onPressed: () async {
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