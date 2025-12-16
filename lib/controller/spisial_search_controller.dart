import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';
import 'package:trip/core/constanat/routing.dart';

import '../core/constanat/dropdownitems.dart';

class SpicialSearchController extends GetxController {
  String typeOfPropertyselected = 'شقة';
  String locationselected = 'دمشق';
  String stutus = "للبيع";
  DropDownItems items = DropDownItems();
  bool changeitems = true;
  void typeOfPropertyupdate(String? val) {
    typeOfPropertyselected = val!;
    update();
  }

  void locationupdate(String? val) {
    locationselected = val!;
    update();
  }

  void changestutus(String? val) {
    stutus = val!;
    if (val == "للبيع") {
      changeitems = true;
    } else {
      changeitems = false;
    }
    update();
  }

  sentnoti() {
    String val = "$locationselected-$typeOfPropertyselected-$stutus";
    String encodedString = Uri.encodeComponent(val);
    print(val);
    print(encodedString);
    FirebaseMessaging.instance.subscribeToTopic(encodedString);
    Get.offAndToNamed(AppRoute.homepage);
    Get.snackbar("done".tr(), "done_successfully_snackbar_message".tr());
  }
}
