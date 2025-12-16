import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';
import 'package:trip/core/constanat/colors.dart';
import 'package:trip/core/constanat/routing.dart';

showCustomDialog() {
  return Get.defaultDialog(
    title: "warning",
    content: Text("custom_guest_dialog".tr()),
    onCancel: () {
      Get.back();
    },
    onConfirm: () {
      Get.offAllNamed(AppRoute.signin);
    },
    cancel: Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text("cancel".tr()),
    ),
    confirm: Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        color: AppColors.greencolor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text("sign_in", style: TextStyle(color: Colors.white)),
    ),
  );
}
