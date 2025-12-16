import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';

import '../../core/class/stutusconntection.dart';
import '../../core/constanat/dropdownitems.dart';
import '../../core/constanat/routing.dart';
import '../../core/functions/handingdatacontroller.dart';
import '../../core/services/shared_preferences/pref_service.dart';
import '../../data/models/propertymodel.dart';
import '../../data/remote/filtered_search_data.dart';

class CarBookingController extends GetxController {
  FilteredSearchData filteredSearchData = FilteredSearchData(Get.find());
  List<PropertyModel> data = [];
  SharedPreferencesService myServices = Get.find();
  int selectedType = 0;
  StatusRequest statusRequest = StatusRequest.none;
  String Rentalperiodselected = 'daily';
  String locationselected = 'all_around_syria';
  bool changeitems = true;
  bool isSliderEnabled = false;
  RangeValues selectedRange = RangeValues(50, 100);

  DropDownItems items = DropDownItems();

  void toggleType(int index) {
    selectedType = index;
    update();
  }

  void changeRange(RangeValues values) {
    selectedRange = values;
    update();
  }

  void toggleSlider(bool isEnabled) {
    isSliderEnabled = isEnabled;
    update();
  }

  void updateTypeOfDropDown(String type, String val) {
    switch (type) {
      case 'locationselected':
        locationselected = val;
        break;
      case 'Rentalperiodselected':
        Rentalperiodselected = val;
        break;
      default:
        print("00000000");
    }
    update();
  }

  void uplodeData() async {
    data.clear();
    print("00000000000000000000000000000000000");
    statusRequest = StatusRequest.loading;
    update();
    var response = await filteredSearchData.getPropertyData(
      token: myServices.pref.getString('token')!,
      rent_type: changeitems ? '' : Rentalperiodselected.tr(),
      city: locationselected.tr(),
      price_gt: isSliderEnabled ? "${selectedRange.end.toInt()}" : '',
      price_lt: isSliderEnabled ? "${selectedRange.start.toInt()}" : '',
    );
    statusRequest = handlingData(response);
    print(myServices.pref.getString('token')!);

    update();
    print(statusRequest);
    if (statusRequest == StatusRequest.seccess) {
      data =
          (response as List)
              .map((item) => PropertyModel.fromJson(item))
              .toList();
      Get.toNamed(AppRoute.filteredpropertysearch, arguments: data);

      update();
    }
  }
}
