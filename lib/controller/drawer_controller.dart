import 'package:get/get.dart';
import 'package:trip/view/widget/custom_guest_dialog.dart';
import '../core/constanat/routing.dart';
import '../core/services/shared_preferences/pref_service.dart';

class MyDrawerController extends GetxController {
  SharedPreferencesService myServices = Get.find();

  logout() {
    myServices.pref.clear();
    Get.offAllNamed(AppRoute.signin);
  }

  goToPersonalInfo() {
    if (myServices.pref.getString('token') == null) {
      showCustomDialog();
    } else {
      Get.toNamed(AppRoute.personalinfo);
    }
  }

  goToAboutUs() {
    Get.toNamed(AppRoute.aboutus);
  }
}
