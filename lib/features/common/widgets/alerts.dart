import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:todo_y_pomodoro_app/core/constants.dart';
import 'package:todo_y_pomodoro_app/core/utils.dart';
import 'package:todo_y_pomodoro_app/features/common/models/app_update.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/v_spacing.dart';

Future<void> showInfoAlert(BuildContext context, String title, String message) async{
  await showDialog(
    context: context, 
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15)
      ),
      contentPadding: const EdgeInsets.all(10),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(
            fontWeight: FontWeight.bold
          )),
          const VSpacing(2),
          Container(
            margin: EdgeInsets.only(
              bottom: mqHeigth(context, 1),
              left: mqWidth(context, 3)
            ),
            child: Text(message)
          ),
        ],
      ),
      actions: [        
        TextButton(
          onPressed: () => Navigator.pop(context), 
          child: Text(FlutterI18n.translate(context, "general.close"))
        )
      ],
    )
  );
  return;
}
Future<bool?> showQuestionAlert(BuildContext context, String title, String message, {bool cancelEnabled = true}) async{
  final bool? confirmed = await showDialog(
    context: context, 
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15)
      ),
      contentPadding: const EdgeInsets.all(10),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(
            fontWeight: FontWeight.bold
          )),
          const VSpacing(2),
          Container(
            margin: EdgeInsets.only(
              bottom: mqHeigth(context, 1)
            ),
            child: Text(message)
          ),
        ],
      ),
      actions: [        
        if(cancelEnabled) TextButton(
          onPressed: () => Navigator.pop(context), 
          child: Text(FlutterI18n.translate(context, "general.cancel"), style: const TextStyle(
            color: Colors.black54
          ))
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true), 
          child: Text(FlutterI18n.translate(context, "general.accept"))
        )
      ],
    )
  );
  return confirmed;
}
Future<void> showSuccessAlert(BuildContext context, String title, String message) async{
  await showDialog(
    context: context, 
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15)
      ),
      contentPadding: const EdgeInsets.all(10),
      title: Text(title),
      content: Padding(
        padding: EdgeInsets.only(
          left: mqWidth(context, 3)
        ),
        child: Text(message),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context), 
          child: Text(FlutterI18n.translate(context, "general.close"))
        )
      ],
    )
  );
  return;
}
Future<bool?> showUpdateDialog(BuildContext context, AppUpdate appUpdate, bool regular) async{
  final forced = regular ? appUpdate.forcedRegular: appUpdate.forcedOta;
  final resp = await showDialog(
    barrierDismissible: !forced,
    context: context,
    builder: (context) => AlertDialog(
      title: Text(
        language == "es" ? appUpdate.titleSpanish : appUpdate.titleEnglish,
        style: TextStyle(
          fontSize: 18,
          color: Theme.of(context).textTheme.displayLarge!.color
        )
      ),
      content: Text(language == "es" ? appUpdate.descriptionSpanish : appUpdate.descriptionEnglish),
      actions: [
        !forced
          ? TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(FlutterI18n.translate(context, "general.not_now"),
                style: const TextStyle(color: Colors.grey)
              )
            )
          : Container(),
        TextButton(
          onPressed: () async {
            Navigator.pop(context, true);
          },
          child: Text(FlutterI18n.translate(context, "general.update"), style: TextStyle(color: Theme.of(context).primaryColor))
        ),
      ]
    )
  );
  return resp;
}
Future<void> showErrorAlert(BuildContext context, String title, List<String> message) async{
  await showDialog(
    context: context, 
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15)
      ),
      contentPadding: const EdgeInsets.all(10),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const VSpacing(1),
          Text(title, style: const TextStyle(
            fontWeight: FontWeight.bold
          )),
          const VSpacing(2),
          ...message.map((e) => Container(
            margin: EdgeInsets.only(
              bottom: mqHeigth(context, 1)
            ),
            child: Text(e)
          ))
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context), 
          child: Text(FlutterI18n.translate(context, "general.close"))
        )
      ],
    )
  );
  return;
}
Future<dynamic> showCustomBottomSheet(BuildContext context, Widget child) async {
  final value = await showModalBottomSheet(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(10.0)
      )
    ),
    backgroundColor: Colors.white,
    context: context,
    isScrollControlled: true,
    builder: (context) => child
  );
  return value;
}