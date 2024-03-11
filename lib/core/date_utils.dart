import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

String formatDuration(BuildContext context, Duration duration) {
  final hours = duration.inHours.remainder(24);
  final minutes = duration.inMinutes.remainder(60);
  final formattedHours = hours > 0 ? '$hours ${hours == 1 ? FlutterI18n.translate(context, "time.hour") : FlutterI18n.translate(context, "time.hours")}' : '';
  final formattedMinutes = minutes > 0? '$minutes ${minutes == 1 ? FlutterI18n.translate(context, "time.minute") : FlutterI18n.translate(context, "time.minutes")}' : '';
  return [formattedHours, formattedMinutes]
     .where((element) => element.isNotEmpty)
     .join(FlutterI18n.translate(context, "time.and"));
}
//Create a function to convert int seconds to string like "25 minutes"
String formatSeconds(BuildContext context, int seconds) {
  if (seconds < 60) {
    return '$seconds seconds';
  } else {
    int minutes = seconds ~/ 60;
    if (minutes < 60) {
      return '$minutes ${minutes == 1 ? FlutterI18n.translate(context, "time.minute") : FlutterI18n.translate(context, "time.minutes")}';
    } else {
      int hours = minutes ~/ 60;
      if (hours < 24) {
        return '$hours ${hours == 1 ? FlutterI18n.translate(context, "time.hour") : FlutterI18n.translate(context, "time.hours")}';
      } else {
        int days = hours ~/ 24;
        return '$days ${days == 1 ? FlutterI18n.translate(context, "time.day") : FlutterI18n.translate(context, "time.days")}';
      }
    }
  }
}