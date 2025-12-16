import 'package:get/get.dart';
import 'package:trip/core/constanat/routing.dart';

import '../../../core/class/stutusconntection.dart';
abstract class VerifycodeForgetPasswordController extends GetxController{
  gotoresetpassword(String verifycode);
}
class VerifycodeForgetPasswordrControllerImp extends VerifycodeForgetPasswordController{
  String? userid;

  StatusRequest statusRequest=StatusRequest.none;
  @override
  gotoresetpassword( String verifycode)async{
Get.to(AppRoute.resetpassword);
  }
  @override
  void onInit() {
    //userid=Get.arguments['id'];
    super.onInit();
  }
}