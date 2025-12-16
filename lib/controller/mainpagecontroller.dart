import 'package:get/get.dart' hide Trans;
import 'package:trip/core/constanat/routing.dart';
import 'package:trip/core/services/shared_preferences/pref_service.dart';
import 'package:trip/view/widget/custom_guest_dialog.dart';

class MainScreenController extends GetxController {
  SharedPreferencesService myServices = Get.find();
  goToFavScreen() {
    if (myServices.pref.getString('token') == null) {
      showCustomDialog();
    } else {
      Get.toNamed(AppRoute.saved);
    }
  }

  List<String> category = [
    'villa',
    'building',
    'flat',
    'land',
    'chalet',
    'holiday_villa',
    'office',
    'store',
  ];

  List<String> imageurl = [
    "Assets/images/piece-of-land-1.jpg",
    "Assets/images/piece-of-land-2.jpg",
    "Assets/images/piece-of-land-3.jpg",
    "Assets/images/piece-of-land-4.jpg",
  ];
  gotodetailsscreen(String type, List category, int index) {
    Get.toNamed(
      AppRoute.detailsscreeen,
      arguments: {"type": type, "category": category, "index": index},
    );
  }
}
