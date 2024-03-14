import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:package_info/package_info.dart';
import 'package:todo_y_pomodoro_app/core/launcher_utils.dart';
import 'package:todo_y_pomodoro_app/features/common/controllers/local_controller.dart';
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
  final localController = LocalController();
  String buildNumber = packageInfo.buildNumber;
  final versionNumber = appUpdate.versionNumber;
  if (versionNumber > int.parse(buildNumber)) {
    // ignore: use_build_context_synchronously
    if(!context.mounted) return;
    showUpdateDialog(context, appUpdate, true).then((value) async {
      if (value == null) {
        if (appUpdate.forcedRegular) {
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
        if (appUpdate.forcedRegular) {
          SystemNavigator.pop();
        }
      }
    });
  }else if(appUpdate.otaVersion > localController.otaVersion){
    if(!context.mounted) return;
    showUpdateDialog(context, appUpdate, false).then((value) async {
      if (value == null) {
        if (appUpdate.forcedOta) {
          SystemNavigator.pop();
        }
      } else {
        if (appUpdate.forcedOta) {
          SystemNavigator.pop();
        }
      }
    });
  }
  localController.otaVersion = appUpdate.otaVersion;
}

