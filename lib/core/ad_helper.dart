import 'dart:io';

class AdHelper {

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/1033173712';
    } else if (Platform.isIOS) {
      return 'Aqui va el id de nuestro banner de ios, el que creamos en el ultimo paso';
    } else {
      return "";
    }
  }
}