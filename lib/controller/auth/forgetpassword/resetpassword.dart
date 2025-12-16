import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../core/class/stutusconntection.dart';
import '../../../core/constanat/routing.dart';

abstract class ResetPassword extends GetxController{
  ResetEndPassword();
}
class ResetPasswordControllerImp extends ResetPassword{
   TextEditingController newpassword=TextEditingController();
   String? userid;
   StatusRequest statusRequest=StatusRequest.none;

  @override
  void onInit() {
    //userid=Get.arguments['id'];
    super.onInit();
  }
  @override
  void dispose() {
    newpassword.dispose();
    super.dispose();
  }

  @override
  ResetEndPassword()
  {
    Get.toNamed(AppRoute.signin);
  }
}