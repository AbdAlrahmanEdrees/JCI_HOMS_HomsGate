import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constanat/routing.dart';
import '../services/shared_preferences/pref_service.dart';

class MyMiddleWare extends GetMiddleware {
  SharedPreferencesService pref = Get.find();
  @override
  int get priority => 1;
  @override
  RouteSettings? redirect(String? route) {
    if (pref.getOnBoard()) {
      if (pref.getSignedIn()) {
        return RouteSettings(name: AppRoute.homepage);
      } else {
        return RouteSettings(name: AppRoute.signin);
      }
    }
    return null;
  }
}
