import 'package:flutter/material.dart';
import 'package:todo_y_pomodoro_app/core/utils.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/app_header.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/app_version_label.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/custom_button.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/custom_text_form_field.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/sheet_content_layout.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/v_spacing.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/duration_selector.dart';
import 'package:todo_y_pomodoro_app/features/tasks/widgets/task_group_list.dart';

class CreateTaskSheet extends StatefulWidget {
  const CreateTaskSheet({super.key});

  @override
  State<CreateTaskSheet> createState() => _CreateTaskSheetState();
}

class _CreateTaskSheetState extends State<CreateTaskSheet> {
  String groupNameError = '';
  @override
  Widget build(BuildContext context) {
    return SheetContentLayout(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const AppHeader(title: "Crear tarea"),
            const VSpacing(3),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: mqWidth(context, 5)
              ),
              child: const TaskGroupList(),
            ),
            const VSpacing(3),
            CustomTextFormField(
              keyboardType: TextInputType.emailAddress,
              hintText: "Título de la tarea",
              errorMessage: groupNameError,
            ),const VSpacing(3),
            CustomTextFormField(
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
              onSelectDuration: (newDate){
                
              }, 
              currentDuration: null, 
              hintText: "Seleccion tiempo"
            ),
            const VSpacing(5),
            CustomButton(
              onPressed: (){},
              label: "Crear tarea", 
              width: mqWidth(context, 90), 
              color: Theme.of(context).primaryColor
            ),
            const VSpacing(2),
            const AppVersionLabel(),
          ],
        ),
      )
    );
  }
}