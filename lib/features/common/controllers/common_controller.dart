
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_y_pomodoro_app/features/common/models/app_update.dart';

class CommonController {

  CommonController._privateConstructor();
  static final CommonController _instance = CommonController._privateConstructor();
  factory CommonController() => _instance;

  final firestoreDB = FirebaseFirestore.instance;

  String configurationCollection = "configuration";

  Future<AppUpdate?> checkForUpdates() async {
    try {
      late DocumentSnapshot snapshot;
      if (Platform.isAndroid) {
        snapshot = await firestoreDB.collection(configurationCollection).doc("android").get();
      } else {
        snapshot = await firestoreDB.collection(configurationCollection).doc("ios").get();
      }
      if(snapshot.data() != null){
        final data = snapshot.data() as Map<String, dynamic>;
        return AppUpdate(
          versionNumber: data["version_number"] ?? 0,
          versionString: data["version_string"] ?? "1.0.0",
          forcedRegular: data["forced_regular"] ?? false,
          forcedOta: data["forced_ota"] ?? false,
          titleSpanish: data["title_spanish"]?? "",
          titleEnglish: data["title_english"]?? "",
          descriptionSpanish: data["description_spanish"]?? "",
          descriptionEnglish: data["description_english"]?? "",
          otaVersion: data["ota_version"]?.toDouble() ?? 0.0,
        );
      }else{
        return null;
      }
    } catch (e) {
      return null;
    }
  }

}