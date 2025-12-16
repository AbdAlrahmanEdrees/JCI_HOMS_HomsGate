import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trip/core/services/shared_preferences/pref_keys.dart';

class SharedPreferencesService extends GetxService {
  late SharedPreferences pref;
  Future<SharedPreferencesService> init() async {
    //creating the I/O stream instance, this will be used whenever we call getInstance() again:
    pref = await SharedPreferences.getInstance();
    return this;
  }
  //================================================
  void setOnBoardTrue() {
    pref.setBool(PrefKeys.isOnBoard, true);
  }
  bool getOnBoard() {
    final bool onBoarded = pref.getBool(PrefKeys.isOnBoard) ?? false;
    return onBoarded;
  }
  //================================================
  void setSignedInTrue() {
    pref.setBool(PrefKeys.isOnBoard, true);
  }
  bool getSignedIn() {
    final bool signed = pref.getBool(PrefKeys.signedIn) ?? false;
    return signed;
  }
  //================================================
  void setLanguage(String language) {
    // en, ar,
    pref.setString(PrefKeys.language, language);
  }
  String getLanguage() {
    final String lang = pref.getString(PrefKeys.language) ?? 'en';
    return lang;
  }
  //===========================================
}
