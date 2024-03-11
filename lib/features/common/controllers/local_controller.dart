
import 'package:shared_preferences/shared_preferences.dart';

class LocalController {
  LocalController._privateConstructor();
  static final LocalController _instance = LocalController._privateConstructor();
  factory LocalController() => _instance;

  late SharedPreferences _prefs;

  Future<void> initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  set localLanguage(String localLanguage) {
    _prefs.setString('todoYPomodoroLocalLang', localLanguage);
  }

  String get localLanguage {
    return _prefs.getString('todoYPomodoroLocalLang') ?? "";
  }



}
