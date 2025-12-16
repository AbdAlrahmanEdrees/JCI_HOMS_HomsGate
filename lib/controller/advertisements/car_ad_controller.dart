import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trip/controller/advertisements/advertisementController.dart';
import 'package:trip/controller/filters/search_by_price_widget_controller.dart';
import 'package:trip/core/class/stutusconntection.dart';
import 'package:trip/core/constanat/dropdownitems.dart';
import 'package:trip/data/models/ads_objects/vehicle.dart';
import 'package:trip/data/temp_todelete/0.dbcontroller.dart';
import 'package:trip/view/screen/addAdvertisement/0.addAdvertisement.dart';

class CarAdController extends GetxController {
  DbController dbController = Get.find<DbController>();
  DropDownItems items = DropDownItems();
  final adController = Get.find<AdvertisementController>();
  // final adController = AddAdvertisementController();
  String forSale =
      '1'; // it is a string because of the custom Radio widget/ it should be sent as an integer for the endpoint
  TextEditingController phone = TextEditingController();
  List<String> phoneNumbersAdded = [];
  String vehicleType = 'car';
  bool newCarType = false; //when the user chooses to put a new type of car
  String carBrand = 'kia';
  TextEditingController carModel = TextEditingController();
  String carTransmission = 'automatic';
  TextEditingController kilometersTraveled = TextEditingController();
  TextEditingController carYear = TextEditingController();
  TextEditingController carPrice = TextEditingController();
  String carRentType = 'daily';
  String carLocationGovernorate = 'homs';
  TextEditingController carLocationAddress = TextEditingController();
  StatusRequest statusRequest = StatusRequest.none;
  final sliderController = Get.put(SearchByPriceWidgetController());
  bool isPriceSearchSliderEnabled = false;
  RangeValues selectedRange = RangeValues(50, 100);

  void changeForSale(String? val) {
    if (val != null) {
      forSale = val;
      if (val == '1') {
        sliderController.setRange(500, 3000, 20000);
        selectedRange = sliderController.selectedRange!;
      } else {
        sliderController.setRange(10, 30, 100);
        selectedRange = sliderController.selectedRange!;
      }
      update();
    }
  }

  void changeVehicleType(String? val) {
    if (val != null) {
      vehicleType = val;
      update();
    }
  }

  void changeCarBrand(String? val) {
    if (val != null) {
      carBrand = val;
      update();
    }
  }

  void changeCarTransmission(String? val) {
    if (val != null) {
      carTransmission = val;
      update();
    }
  }

  void changeRentType(String? val) {
    if (val != null) {
      carRentType = val;
      if (val == 'daily') {
        sliderController.setRange(10, 30, 100);
        selectedRange = sliderController.selectedRange!;
      } else {
        sliderController.setRange(200, 500, 2000);
        selectedRange = sliderController.selectedRange!;
      }
      update();
    }
  }

  void changeCarLocationGovernorate(String? val) {
    if (val != null) {
      carLocationGovernorate = val;
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

  ///////////////// insert ///////////////////////

  Future<void> uploadData() async {
    // prevent double-tap
    if (statusRequest == StatusRequest.loading) return;

    statusRequest = StatusRequest.loading;
    update();

    String safe(TextEditingController? c) => (c?.text ?? '').trim();
    String esc(String s) => s.replaceAll("'", "''");

    try {
      // --- Images ---
      final imgs = adController.images; // RxList<XFile>
      if (imgs.isEmpty) {
        throw 'Please select at least three images.';
      }
      // final photosCsv = imgs.map((x) => esc(x.path)).join(',');
      final photos = await adController.copyImagesToPermanentStorage();

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
      final modelText = safe(carModel);
      final addressText = safe(carLocationAddress);
      if (modelText.isEmpty) throw 'Car model is required.';
      if (addressText.isEmpty) throw 'Address is required.';

      // --- Numbers (null-safe) ---
      final priceStr = safe(carPrice);
      final kmsStr = safe(kilometersTraveled);
      final yearStr = safe(carYear);

      final price = int.tryParse(priceStr) ?? 0;
      if (price < 0) throw 'Enter a valid positive price.';

      final kms = int.tryParse(kmsStr) ?? 0;
      if (kms < 0) throw 'Kilometers cannot be negative.';

      final yearVal = int.tryParse(yearStr);
      final currentYear = DateTime.now().year;
      if (yearVal == null || yearVal < 1950 || yearVal > currentYear + 1) {
        throw 'Enter a valid year between 1950 and ${currentYear + 1}.';
      }

      // --- Transmission sanity ---
      final allowedTransmissions = {'automatic', 'manual'};
      if (!allowedTransmissions.contains(carTransmission)) {
        throw 'Transmission must be automatic or manual.';
      }

      // --- forSale: keep '1'/'0' in controller, insert as int in DB ---
      final forSaleInt = int.tryParse(forSale) ?? 0;
      final rentTypeOut = (forSaleInt == 0) ? carRentType : '';

      // --- Build Car object expected by your DbController ---
      final car = Vehicle(
        adID: null,
        // userID: 0, // TODO: replace with real user id
        photos: photos, // TEXT (CSV) per your schema
        phoneNumbers: phonesCsv, // TEXT (CSV)
        forSale: forSaleInt, // INTEGER for DB
        typeOfRent: rentTypeOut,
        usPrice: price,
        type: vehicleType,
        brand: carBrand,
        model: modelText,
        transmission: carTransmission,
        kilometersTraveled: kms,
        year: yearVal,
        governorate: carLocationGovernorate,
        address: addressText,
      );

      await dbController.insertCarAd(car);

      statusRequest = StatusRequest.none;
      update();
      Get.back();
      Get.snackbar('Success', 'Your vehicle ad has been posted.');
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
      final String governorate = carLocationGovernorate; // dropdown
      final String address = safe(carLocationAddress);
      final String type = vehicleType; // dropdown
      final String brand = carBrand; // dropdown
      final String model = safe(carModel);
      final String transmission = carTransmission; // dropdown

      // Price range
      final bool byPrice = isPriceSearchSliderEnabled;
      int minPrice = 0;
      int maxPrice = 2147483647; // effectively "no cap" if slider off
      if (byPrice) {
        final rv = sliderController.selectedRange ?? const RangeValues(0, 0);
        minPrice = rv.start.round();
        maxPrice = rv.end.round();
      }

      // Rent type only when forSale == 0 (rent)
      final String rentType = (forSaleInt == 0) ? carRentType : '';

      await dbController.carsFilteredSearch(
        governorate: governorate,
        address: address,
        forSale: forSaleInt,
        type: type,
        brand: brand,
        model: model,
        transmission: transmission,
        isPriceSearchSliderEnabled: byPrice,
        minPrice: minPrice,
        maxPrice: maxPrice,
        typeOfRent: rentType,
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
