import 'package:get/get.dart';

import '../../view/screen/auth/signin.dart';
import '../../view/screen/auth/signup.dart';

abstract class BoardingScreen extends GetxController{
  gotosignin();
  gotosignup();
}
class BoardingcontrollernImp extends BoardingScreen{
  @override
  gotosignin() {
    Get.to(SignIn(),transition: Transition.zoom,duration: Duration(milliseconds: 1000));
  }

  @override
  gotosignup() {
    Get.to(SignUp(),transition: Transition.zoom,duration: Duration(milliseconds: 1000));

  }

}