import 'package:flutter/material.dart';
import 'package:todo_y_pomodoro_app/core/utils.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/app_header.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/custom_button.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/custom_text_button.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/custom_text_form_field.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/sheet_content_layout.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/v_spacing.dart';

class EditGroupSheet extends StatefulWidget {
  const EditGroupSheet({super.key});

  @override
  State<EditGroupSheet> createState() => _EditGroupSheetState();
}

class _EditGroupSheetState extends State<EditGroupSheet> {
  String groupNameError = '';
  @override
  Widget build(BuildContext context) {
    return SheetContentLayout(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const AppHeader(title: "Editar grupo de tareas"),
          const VSpacing(3),
          CustomTextFormField(
            keyboardType: TextInputType.emailAddress,
            hintText: "Ingrese el nombre del grupo",
            errorMessage: groupNameError,
          ),
          const VSpacing(5),
          CustomButton(
            onPressed: (){},
            label: "Editar", 
            width: mqWidth(context, 90), 
            color: Theme.of(context).primaryColor
          ),
          const VSpacing(3),
          CustomTextButton(
            label: "Eliminar grupo", 
            onPressed: (){
              
            }, 
          )
        ],
      )
    );
  }
}