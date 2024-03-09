import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_y_pomodoro_app/core/utils.dart';
import 'package:todo_y_pomodoro_app/features/common/models/error_response.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/alerts.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/app_header.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/custom_button.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/custom_text_form_field.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/sheet_content_layout.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/v_spacing.dart';
import 'package:todo_y_pomodoro_app/features/tasks/models/task_group_model.dart';
import 'package:todo_y_pomodoro_app/features/tasks/providers/task_groups_provider.dart';

class CreateTaskGroupSheet extends StatefulWidget {
  const CreateTaskGroupSheet({super.key});

  @override
  State<CreateTaskGroupSheet> createState() => _CreateTaskGroupSheetState();
}

class _CreateTaskGroupSheetState extends State<CreateTaskGroupSheet> {
  String groupNameError = '';
  final taskGroupLabelController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SheetContentLayout(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const AppHeader(title: "Nuevo grupo de tareas"),
          const VSpacing(3),
          CustomTextFormField(
            autofocus: true,
            controller: taskGroupLabelController,
            keyboardType: TextInputType.emailAddress,
            hintText: "Ingrese el nombre del grupo",
            errorMessage: groupNameError,
            maxLength: 30,
            onTap: (){
              groupNameError = "";
              setState(() {});
            },
          ),
          const VSpacing(5),
          Selector<TaskGroupsProvider, bool>(
            selector: (context, userProvider) => userProvider.createTaskGroupLoading,
            builder: (context, createTaskGroupLoading, _) {
              return CustomButton(
                onPressed: () async {
                  if(taskGroupLabelController.text.isEmpty){
                    groupNameError = "El nombre del grupo no puede estar vacío";
                    setState(() {});
                    return;
                  }
                  final group = Provider.of<TaskGroupsProvider>(context, listen: false);
                  final taskGroup = TaskGroupModel.empty.copyWith(updatedAt: null, deletedAt: null, label: taskGroupLabelController.text);
                  final resp = await group.createTaskGroup(taskGroup);
                  if(resp == null) return;
                  if(resp is ErrorResponse){
                    if(!mounted) return;
                    showErrorAlert(context, "Estimado usuario", [resp.message]);
                    return;
                  }
                  if(!mounted) return;
                  Navigator.pop(context);
                },
                label: "Crear", 
                width: mqWidth(context, 90), 
                loading: createTaskGroupLoading,
                color: Theme.of(context).primaryColor
              );
            },
          ),
        ],
      )
    );
  }
}