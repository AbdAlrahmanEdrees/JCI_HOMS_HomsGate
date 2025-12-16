import 'package:get/get.dart';
import 'package:trip/core/constanat/routing.dart';
import 'package:trip/core/services/shared_preferences/pref_service.dart';

class SettingController extends GetxController {
  SharedPreferencesService myServices = Get.find();
  logout() {
    myServices.pref.clear();
    Get.offAllNamed(AppRoute.signin);
  }
}
