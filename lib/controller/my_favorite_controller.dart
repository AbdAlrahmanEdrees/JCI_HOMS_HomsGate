import 'package:get/get.dart';
import 'package:trip/controller/favorite_controller.dart';
import '../core/constanat/routing.dart';

class MyFavoriteController extends GetxController {
  FavoriteController favoriteController = Get.put(FavoriteController());

  @override
  void onInit() {
    super.onInit();
    favoriteController.getUserFavorite();
  }

  deletePropertyFromFav(int index, String propertyid) {
    favoriteController.deleteFromFav(propertyid);
    favoriteController.data.removeAt(index);
    favoriteController.update();
  }

  goToPropertyDetails(String slug) {
    Get.toNamed(AppRoute.propertdetailsscreen, arguments: slug);
  }
}
