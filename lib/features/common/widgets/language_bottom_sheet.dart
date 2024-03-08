import 'package:flutter/material.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/app_header.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/sheet_content_layout.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/v_spacing.dart';

class LanguageBottomSheet extends StatefulWidget {
  const LanguageBottomSheet({super.key});

  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  String groupNameError = '';
  @override
  Widget build(BuildContext context) {
    return SheetContentLayout(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            AppHeader(title: "Seleccione lenguaje"),
            VSpacing(3),
            Divider(),
            ListTile(
              title: Text("Español"),
              trailing: Icon(Icons.check),
            ),
            Divider(),
            ListTile(
              title: Text("Inglés"),
            ),
            Divider(),
          ],
        ),
      )
    );
  }
}