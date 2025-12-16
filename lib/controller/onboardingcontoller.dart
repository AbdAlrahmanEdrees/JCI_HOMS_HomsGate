import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trip/core/constanat/routing.dart';
import 'package:trip/core/services/shared_preferences/pref_service.dart';
import '../data/static/onbordring.dart';

abstract class OnBoardingController extends GetxController {
  next();
  onpagechange(int m);
}

class OnBoardingControll extends OnBoardingController {
  int currentindex = 0;
  late PageController pageController;
  final pref = Get.find<SharedPreferencesService>();

  @override
  next() {
    currentindex++;
    if (currentindex < data.length) {
      pageController.animateToPage(
        currentindex,
        duration: Duration(seconds: 1),
        curve: Curves.easeOutBack,
      );
    } else {
      pref.setOnBoardTrue();
      Get.toNamed(AppRoute.signin);
    }
    update();
  }

  @override
  onpagechange(int index) {
    currentindex = index;
    update();
  }

  @override
  void onInit() {
    pageController = PageController();
    super.onInit();
  }
}
