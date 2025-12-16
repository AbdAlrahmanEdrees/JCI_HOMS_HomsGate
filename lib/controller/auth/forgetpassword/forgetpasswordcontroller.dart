import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:trip/core/constanat/routing.dart';

import '../../../core/class/stutusconntection.dart';
import '../../../core/services/shared_preferences/pref_service.dart';

abstract class ForgetPasswordController extends GetxController {
  ForgetPassword();
}

class ForgetPasswordControllerImp extends ForgetPasswordController {
  late TextEditingController email;
  String? id;
  SharedPreferencesService services = Get.find();
  StatusRequest statusRequest = StatusRequest.none;
  @override
  ForgetPassword() async {
    Get.toNamed(AppRoute.verifycodeforgetpasswors);
  }

  @override
  void onInit() {
    email = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    email.dispose();
    super.dispose();
  }
}
