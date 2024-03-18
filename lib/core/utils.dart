import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:package_info/package_info.dart';
import 'package:shorebird_code_push/shorebird_code_push.dart';
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
  final shorebirdCodePush = ShorebirdCodePush();
  double otaVersion = localController.otaVersion;
  if(otaVersion == 0.0){
    otaVersion = double.parse(buildNumber);
  }
  if (versionNumber > int.parse(buildNumber)) {
    // ignore: use_build_context_synchronously
    if(!context.mounted) {
      localController.otaVersion = appUpdate.otaVersion;
      return;
    }
    showUpdateDialog(context, appUpdate, true).then((value) async {
      if (value == null) {
        if (appUpdate.forcedRegular) {
          localController.otaVersion = appUpdate.otaVersion;
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
          if(!context.mounted){
            localController.otaVersion = appUpdate.otaVersion;
          }
          showInfoAlert(
            context,
            FlutterI18n.translate(context, "general.dear"),
            "${FlutterI18n.translate(context, "updates.must1")} ${isAndroid ? "PlayStore" : "AppStore"} ${FlutterI18n.translate(context, "general.must2")}"
          );
        }
        if (appUpdate.forcedRegular) {
          localController.otaVersion = appUpdate.otaVersion;
          SystemNavigator.pop();
        }
      }
    });
  }else if(appUpdate.otaVersion > otaVersion){
    //Se hace una doble verificación, desde Firebase y desde Shorebird
    final isUpdateAvailable = await shorebirdCodePush.isNewPatchAvailableForDownload();

    if (!isUpdateAvailable) {
      localController.otaVersion = appUpdate.otaVersion;
      return;
    }
    if(!context.mounted) {
      localController.otaVersion = appUpdate.otaVersion;
      return;
    }
    showUpdateDialog(context, appUpdate, false).then((value) async {
      if (value == null) {
        if (appUpdate.forcedOta) {
          await shorebirdCodePush.downloadUpdateIfAvailable();
        }
      } else {
        await shorebirdCodePush.downloadUpdateIfAvailable();
      }
    });
  }
  localController.otaVersion = appUpdate.otaVersion;
}

