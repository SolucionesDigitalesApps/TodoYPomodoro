import 'dart:io';

class AdHelper {

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-4366409574152602/9550578964';
    } else if (Platform.isIOS) {
      return 'Aqui va el id de nuestro banner de ios, el que creamos en el ultimo paso';
    } else {
      return "";
    }
  }
}