import 'package:get/get.dart';
import 'package:trip/core/services/shared_preferences/pref_service.dart';

SharedPreferencesService myServices = Get.find();

class Staticdata {
  static String? token = myServices.pref.getString('token');
}
