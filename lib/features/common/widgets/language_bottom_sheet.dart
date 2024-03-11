import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:todo_y_pomodoro_app/features/common/controllers/local_controller.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/alerts.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/app_header.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/sheet_content_layout.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/v_spacing.dart';

class LanguageBottomSheet extends StatefulWidget {
  const LanguageBottomSheet({super.key});

  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  final localController = LocalController();
  late String initialLanguage;

  String groupNameError = '';

  @override
  void initState() {
    initialLanguage = localController.localLanguage;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SheetContentLayout(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppHeader(title: FlutterI18n.translate(context, "pages.language_sheet.title")),
            const VSpacing(3),
            const Divider(),
            ListTile(
              onTap: (){
                changeLanguage(context, "es").then((value) => Navigator.pop(context));
              },
              title: Text(FlutterI18n.translate(context, "pages.language_sheet.spanish")),
              trailing: initialLanguage == "es" ? const Icon(Icons.check) : null,
            ),
            const Divider(),
            ListTile(
              onTap: (){
                changeLanguage(context, "en").then((value) => Navigator.pop(context));
              },
              title: Text(FlutterI18n.translate(context, "pages.language_sheet.english")),
               trailing: initialLanguage == "en" ? const Icon(Icons.check) : null,
            ),
            const Divider(),
          ],
        ),
      )
    );
  }

  Future<bool> changeLanguage(BuildContext context, String language) async {
    final newLocale = Locale(language);
    localController.localLanguage = newLocale.languageCode;
    final currentLang = newLocale;
    try{
      if(!mounted) return false;
      await FlutterI18n.refresh(context, currentLang);
    }catch(_){
      if(!mounted) return false;
      showErrorAlert(context, FlutterI18n.translate(context, "general.dear"), [FlutterI18n.translate(context, "general.error")]);
    }
    if(mounted){
      setState(() {});
    }
    return true;
  }
}