import 'package:get/get.dart';
import 'package:trip/core/services/shared_preferences/pref_service.dart';
import 'package:trip/data/remote/auth/verifycodesignupdata.dart';

import '../../core/class/stutusconntection.dart';
import '../../core/constanat/routing.dart';
import '../../core/functions/handingdatacontroller.dart';

abstract class Verifycodesignup extends GetxController {
  verifyaccound(String verify);
}

class VerifyCodeSignUpcontollerImp extends Verifycodesignup {
  String? email;
  SharedPreferencesService myServices = Get.find();
  StatusRequest statusRequest = StatusRequest.none;

  Verifycodesignupdata verifycodesignupdata = Verifycodesignupdata(Get.find());
  List<Map<String, dynamic>> data = [];
  @override
  void onInit() {
    email = Get.arguments['email'];
    print(email);
    super.onInit();
  }

  @override
  verifyaccound(String verify) async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await verifycodesignupdata.PostVerifycodesignup(
      email!,
      verify,
    );
    print("=============================== Controller $response ");
    statusRequest = handlingData(response);
    update();
    print(statusRequest);
    if (statusRequest == StatusRequest.seccess) {
      Get.toNamed(AppRoute.signin);
    }
    if (response == StatusRequest.serverfailure) {
      Get.defaultDialog(
        title: "تحذير",
        middleText: "البريد الالكتروني او كلمة السر خاطئ",
      );
      print(statusRequest);
      statusRequest = StatusRequest.failure;
      update();
    }
    update();
  }
}
