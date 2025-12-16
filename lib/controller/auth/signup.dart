import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:trip/core/constanat/routing.dart';
import 'package:trip/core/services/shared_preferences/pref_service.dart';
import 'package:trip/data/remote/auth/signup.dart';
import '../../core/class/stutusconntection.dart';
import '../../core/functions/handingdatacontroller.dart';

abstract class SignUpcontroller extends GetxController {
  signUp();
  signinwithlinkedin();
  signinwithfacebook();
  signinwithinsta();
}

class SignUpContollerImp extends SignUpcontroller {
  late TextEditingController firstname;
  SharedPreferencesService services = Get.find();
  late TextEditingController lastname;
  late TextEditingController email;
  late TextEditingController password;
  late TextEditingController conipassword;
  SignUpData signUpData = SignUpData(Get.find());
  List<Map<String, dynamic>> data = [];
  String? userid;
  StatusRequest statusRequest = StatusRequest.none;
  @override
  void onInit() {
    firstname = TextEditingController();
    password = TextEditingController();
    email = TextEditingController();
    conipassword = TextEditingController();
    lastname = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    email.dispose();
    firstname.dispose();
    lastname.dispose();
    conipassword.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  signUp() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await signUpData.PostSignUpdata(
      firstname.text,
      lastname.text,
      email.text,
      password.text,
      conipassword.text,
    );
    print("=============================== Controller $response ");
    statusRequest = handlingData(response);
    update();
    print(statusRequest);
    if (statusRequest == StatusRequest.seccess) {
      Get.toNamed(AppRoute.verifycodesignup, arguments: {'email': email.text});
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

  @override
  signinwithfacebook() {
    // TODO: implement signinwithfacebook
    throw UnimplementedError();
  }

  @override
  signinwithinsta() {
    // TODO: implement signinwithinsta
    throw UnimplementedError();
  }

  @override
  signinwithlinkedin() {
    // TODO: implement signinwithlinkedin
    throw UnimplementedError();
  }
}
