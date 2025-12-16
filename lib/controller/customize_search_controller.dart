import 'package:get/get.dart';
import 'package:trip/core/constanat/routing.dart';
import 'package:trip/core/services/shared_preferences/pref_service.dart';

class CustomizedSearchController extends GetxController {
  SharedPreferencesService myServices = Get.find();
  var showWidget = true.obs;

  @override
  void onInit() {
    super.onInit();
    _checkFirstUse();
  }

  Future<void> _checkFirstUse() async {
    bool? isFirstUse = myServices.pref.getBool('ISFirstUse');
    if (isFirstUse != null) {
      if (!isFirstUse) {
        showWidget.value = false;
      }
    }
  }

  Future<void> dismissWidget() async {
    await myServices.pref.setBool('ISFirstUse', false);
    showWidget.value = false;
  }

  goToselectSearchscreen() {
    Get.toNamed(AppRoute.spicealsearch);
  }
}
