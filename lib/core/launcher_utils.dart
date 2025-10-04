import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/alerts.dart';
import 'package:url_launcher/url_launcher.dart';

class LauncherUtils {
  static Future<bool> openUrl(BuildContext context, String urlString, {bool errorVisible = true}) async {
    try{
      if(Platform.isAndroid){
        // ignore: deprecated_member_use
        if (await canLaunch(urlString)) {
          // ignore: deprecated_member_use
          await launch(urlString);
          return true;
        } else {
          // ignore: use_build_context_synchronously
          if(!context.mounted) return false;
          showErrorAlert(context, FlutterI18n.translate(context, "general.dear"), [FlutterI18n.translate(context, "general.error")]);
          return false;
        }
      }else{
        if (await canLaunchUrl(Uri.parse(urlString))) {
          await launchUrl(Uri.parse(urlString));
          return true;
        } else {
          // ignore: use_build_context_synchronously
          if(!context.mounted) return false;
          showErrorAlert(context, FlutterI18n.translate(context, "general.dear"), [FlutterI18n.translate(context, "general.error")]);
          return false;
        }
      }
    }catch(_){
      if(errorVisible){
        if(!context.mounted) return false;
        showErrorAlert(context, FlutterI18n.translate(context, "general.dear"), [FlutterI18n.translate(context, "general.error")]);
      }
      return false;
    }
  }
}