import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trip/controller/advertisements/advertisementController.dart';
import 'package:trip/controller/filters/search_by_price_widget_controller.dart';
import 'package:trip/core/class/stutusconntection.dart';
import 'package:trip/core/constanat/dropdownitems.dart';
import 'package:trip/data/models/ads_objects/restaurantorcafe.dart';
import 'package:trip/data/temp_todelete/0.dbcontroller.dart';
import 'package:trip/view/screen/advertisement_panel/restaurants/0.restaurants_browser.dart';
import 'package:trip/view/screen/advertisement_panel/restaurants/2.restaurant_profile.dart';

class RestaurantsAndCafesAdController extends GetxController {
  final _dbController = Get.find<DbController>();
  final _adController = Get.find<AdvertisementController>();
  final items = DropDownItems();
  // final adController = AddAdvertisementController();
  String forSale =
      '1'; // it is a string because of the custom Radio widget/ it should be sent as an integer for the endpoint
  TextEditingController phone = TextEditingController();
  List<String> phoneNumbersAdded = [];
  TextEditingController name = TextEditingController();
  String locationGovernorate = 'homs';
  String type = 'restaurant';
  TextEditingController usPrice = TextEditingController();
  TextEditingController openHour = TextEditingController();
  TextEditingController closeHour = TextEditingController();
  String amORpmOpen = 'am';
  String amORpmClose = 'pm';
  bool hasDelivery = false;
  bool hasElectricity = false;
  bool hasWifi = false;
  TextEditingController locationAddress = TextEditingController();
  TextEditingController menuAndDescription = TextEditingController();
  StatusRequest statusRequest = StatusRequest.none;
  final sliderController = Get.put(SearchByPriceWidgetController());
  bool isPriceSearchSliderEnabled = false;
  RangeValues selectedRange = RangeValues(5, 20);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    sliderController.setRange(5, 30, 500);
  }

  void toggleAmPmOpen() {
    if (amORpmOpen == 'am') {
      amORpmOpen = 'pm';
    } else {
      amORpmOpen = 'am';
    }
    update();
  }

  void toggleAmPmClose() {
    if (amORpmClose == 'am') {
      amORpmClose = 'pm';
    } else {
      amORpmClose = 'am';
    }
    update();
  }

  void changeHasDelivery(bool? val) {
    if (val != null) {
      hasDelivery = val;
      update();
    }
  }

  void changeHasElectricity(bool? val) {
    if (val != null) {
      hasElectricity = val;
      update();
    }
  }

  void changeHasWifi(bool? val) {
    if (val != null) {
      hasWifi = val;
      update();
    }
  }

  void changeType(String? val) {
    if (val != null) {
      type = val;
      update();
    }
  }

  void changeLocationGovernorate(String? val) {
    if (val != null) {
      locationGovernorate = val;
      update();
    }
  }

  void togglePriceSliderSearch(bool? val) {
    if (val != null) {
      isPriceSearchSliderEnabled = val;
      sliderController.toggleSlider(val);
      update();
    }
  }

  void changeRange(RangeValues values) {
    sliderController.changeRange(values);
    selectedRange = sliderController.selectedRange!;
    update();
  }

  Future<void> uploadData() async {
    // prevent double-tap
    if (statusRequest == StatusRequest.loading) return;

    statusRequest = StatusRequest.loading;
    update();

    String safe(TextEditingController? c) => (c?.text ?? '').trim();
    String esc(String s) => s.replaceAll("'", "''");

    try {
      // --- Images ---
      final imgs = _adController.images; // RxList<XFile>
      if (imgs.isEmpty) {
        throw 'Please select at least three images.';
      }
      // final photosCsv = imgs.map((x) => esc(x.path)).join(',');
      final String photosCsv =
          await _adController.copyImagesToPermanentStorage();

      // --- Phones (include what's in the text box if not added yet) ---
      final manualPhone = safe(phone);
      if (manualPhone.isNotEmpty && !phoneNumbersAdded.contains(manualPhone)) {
        phoneNumbersAdded.add(manualPhone);
      }
      if (phoneNumbersAdded.isEmpty) {
        throw 'Please add at least one phone number.';
      }
      final phonesCsv = phoneNumbersAdded
          .map((p) => esc(p.trim()))
          .where((p) => p.isNotEmpty)
          .join(',');

      // --- Required fields (null-safe) ---
      final addressText = safe(locationAddress);
      final descriptionText = safe(menuAndDescription);
      final namee = safe(name);
      if (addressText.isEmpty) throw 'Address is required.';
      if (descriptionText.isEmpty) throw 'Menu is required.';

      // --- Numbers (null-safe) ---
      final priceStr = safe(usPrice);

      final price = int.tryParse(priceStr) ?? 0;
      if (price < 0) throw 'Enter a valid positive price.';

      // --- forSale: keep '1'/'0' in controller, insert as int in DB ---
      final forSaleInt = int.tryParse(forSale) ?? 0;

      // --- Build Car object expected by your DbController ---
      final rc = RestaurantOrCafe(
        adID: null,
        // userID: 0, // TODO: replace with real user id
        photos: photosCsv, // TEXT (CSV) per your schema
        phoneNumbers: phonesCsv, // TEXT (CSV)
        openHour: openHour.text,
        closeHour: closeHour.text,
        amOrPmOpen: amORpmOpen,
        amOrPmClose: amORpmClose,
        hasDelivery: hasDelivery ? 1 : 0,
        hasElectricity: hasElectricity ? 1 : 0,
        name: namee,
        type: type,
        menuAndDescription: descriptionText,
        hasWifi: hasWifi ? 1 : 0,
        usPrice: price,
        governorate: locationGovernorate,
        address: addressText,
      );

      await _dbController.insertRestaurantOrCafeAd(rc);

      statusRequest = StatusRequest.none;
      update();
      Get.back();
      Get.snackbar('Success', 'Your ad has been posted.');
    } catch (e) {
      statusRequest = StatusRequest.failure;
      update();
      Get.snackbar('Upload Failed', e.toString());
    }
  }

  ////////////////// filtered search ////////////////////////
  Future<void> filterSearch() async {
    if (statusRequest == StatusRequest.loading) return; // avoid double taps
    statusRequest = StatusRequest.loading;
    update();

    String safe(TextEditingController? c) => (c?.text ?? '').trim();

    try {
      // Normalize inputs
      final int forSaleInt = int.tryParse(forSale) ?? 1; // '1' or '0' -> int
      final String governorate = locationGovernorate; // dropdown
      final String address = safe(locationAddress);

      // Price range
      final bool byPrice = isPriceSearchSliderEnabled;
      int minPrice = 0;
      int maxPrice = 2147483647; // effectively "no cap" if slider off
      if (byPrice) {
        final rv = sliderController.selectedRange ?? const RangeValues(0, 0);
        minPrice = rv.start.round();
        maxPrice = rv.end.round();
      }

      await _dbController.restaurantsAndCafesFilteredSearch(
        governorate: governorate,
        // address: address,
        hasDelivery: hasDelivery,
        type: type,
        isPriceSearchSliderEnabled: byPrice,
        minPrice: minPrice,
        maxPrice: maxPrice,
        hasElectricity: hasElectricity,
        hasWifi: hasWifi,
      );

      statusRequest = StatusRequest.none;
      update();
      Get.back(); // close the dialog after results are ready
    } catch (e) {
      statusRequest = StatusRequest.failure;
      update();
      Get.snackbar('Search Failed', e.toString());
    }
  }
}
