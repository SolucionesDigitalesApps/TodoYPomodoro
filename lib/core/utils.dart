import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:package_info/package_info.dart';
import 'package:todo_y_pomodoro_app/core/constants.dart';
import 'package:todo_y_pomodoro_app/core/launcher_utils.dart';
import 'package:todo_y_pomodoro_app/features/common/models/app_update.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/alerts.dart';

double mqHeigth(BuildContext context, double percentage){
  return MediaQuery.of(context).size.height * (percentage/100);
}
double mqWidth(BuildContext context, double percentage){
  return MediaQuery.of(context).size.width * (percentage/100);
}

Future<void> showAppUpdateOrNot(BuildContext context, AppUpdate appUpdate) async {
  final isAndroid = Platform.isAndroid;
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  String buildNumber = packageInfo.buildNumber;
  final versionNumber = appUpdate.versionNumber;
  if (versionNumber > int.parse(buildNumber)) {
    // ignore: use_build_context_synchronously
    if(!context.mounted) return;
    showDialog(
      barrierDismissible: !appUpdate.forced,
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
          !appUpdate.forced
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
    ).then((value) async {
      if (value == null) {
        if (appUpdate.forced) {
          SystemNavigator.pop();
        }
      } else {
        String url = '';
        if(!isAndroid){
          //TODO: Cambiar
          url = "https://apps.apple.com/pe/app/miruta-viajes/id1669513361";
        }else{
          url = 'https://play.google.com/store/apps/details?id=com.hadtech.mirutaapp';
        }
        bool success = await LauncherUtils.openUrl(context, url);
        if (!success) {
          // ignore: use_build_context_synchronously
          if(!context.mounted) return;
          showInfoAlert(
            context,
            FlutterI18n.translate(context, "general.dear"),
            "${FlutterI18n.translate(context, "updates.must1")} ${isAndroid ? "PlayStore" : "AppStore"} ${FlutterI18n.translate(context, "general.must2")}"
          );
        }
        if (appUpdate.forced) {
          SystemNavigator.pop();
        }
      }
    });
  }
}

