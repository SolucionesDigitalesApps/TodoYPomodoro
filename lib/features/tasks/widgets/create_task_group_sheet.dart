import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:provider/provider.dart';
import 'package:todo_y_pomodoro_app/core/utils.dart';
import 'package:todo_y_pomodoro_app/features/auth/providers/user_provider.dart';
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
          AppHeader(title: FlutterI18n.translate(context, "pages.create_task_group_sheet.title")),
          const VSpacing(3),
          CustomTextFormField(
            autofocus: true,
            controller: taskGroupLabelController,
            keyboardType: TextInputType.emailAddress,
            hintText: FlutterI18n.translate(context, "pages.create_task_group_sheet.label_input"),
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
                    groupNameError = FlutterI18n.translate(context, "pages.create_task_group_sheet.label_not_empty");
                    setState(() {});
                    return;
                  }
                  FocusScope.of(context).unfocus();
                  final group = Provider.of<TaskGroupsProvider>(context, listen: false);
                  final userId = Provider.of<UserProvider>(context, listen: false).currentUser.id;
                  final taskGroup = TaskGroupModel.empty.copyWith(
                    updatedAt: null, 
                    deletedAt: null, 
                    label: taskGroupLabelController.text,
                    userId: userId
                  );
                  final resp = await group.createTaskGroup(taskGroup);
                  if(resp == null) return;
                  if(resp is ErrorResponse){
                    if(!mounted) return;
                    showErrorAlert(context, FlutterI18n.translate(context, "general.dear"), [resp.message]);
                    return;
                  }
                  if(!mounted) return;
                  Navigator.pop(context);
                },
                label: FlutterI18n.translate(context, "general.create"), 
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