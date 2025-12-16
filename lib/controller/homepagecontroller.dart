import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:trip/controller/advertisements/advertisementController.dart';
import 'package:trip/controller/personal_info_controller.dart';
import 'package:trip/core/constanat/routing.dart';
import 'package:trip/core/services/shared_preferences/pref_service.dart';
import 'package:trip/data/temp_todelete/0.dbcontroller.dart';
import 'package:trip/view/screen/addAdvertisement/0.addAdvertisement.dart';
import 'package:trip/view/screen/offers_screen.dart';
import 'package:trip/view/screen/saved_ads_screen.dart';
import 'package:trip/view/screen/mainpagescreen.dart';
import 'package:trip/view/screen/userproperty/user_advertisements.dart';
import 'package:trip/view/widget/custom_guest_dialog.dart';

import 'favorite_controller.dart';

abstract class HomePageController extends GetxController {}

class HomePageControllerImp extends HomePageController {
  SharedPreferencesService myServices = Get.find();
  FavoriteController favoriteController = Get.put(FavoriteController());
  DbController dbController = Get.put(DbController());
  AdvertisementController adController = Get.put(AdvertisementController());

  int page = 0;
  List<String> pageTitles = [
    'home',
    'saved',
    'my_ads_page_title',
    'offers',
    'add_ad',
  ];
  List<Widget> pages = [
    MainPageScreen(),
    const SavedAdsScreen(),
    const UserAdvertisements(),
    const OffersScreen(),
    // const FilteredSearch(),
    // const AddProperyPhotos(),
    AddAdvertisement(),
  ];

  void onpress(int index) {
    // check if user is signed in:
    // if (myServices.pref.getString('token') == null) {
    //   showCustomDialog();
    // } else {
    //   page = index;
    //   if (index == 1) {
    //     favoriteController.getUserFavorite();
    //   }
    // }
    page = index;
    update();
  }

  GlobalKey<CurvedNavigationBarState> bottomNavigationKey = GlobalKey();

  @override
  void onInit() {
    Get.put(PersonalInfoController());
    super.onInit();
  }

  goToFavScreen() {
    if (myServices.pref.getString('token') == null) {
      showCustomDialog();
    } else {
      Get.toNamed(AppRoute.saved);
    }
  }

  goToCustomizeScreen() {
    if (myServices.pref.getString('token') == null) {
      showCustomDialog();
    } else {
      Get.toNamed(AppRoute.coustomizesearsh);
    }
  }
}
