import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:trip/controller/advertisements/advertisementController.dart';
import 'package:trip/controller/filters/search_by_price_widget_controller.dart';
import 'package:trip/core/class/stutusconntection.dart';
import 'package:trip/core/constanat/dropdownitems.dart';
import 'package:trip/data/models/ads_objects/estate.dart';
import 'package:trip/data/temp_todelete/0.dbcontroller.dart';

class EstatesAdController extends GetxController {
  final items = DropDownItems();
  final DbController _dbController = Get.find<DbController>();
  final AdvertisementController _adController =
      Get.find<AdvertisementController>();
  String forSale =
      '1'; // it is a string because of the custom Radio widget/ it should be sent as an integer for the endpoint
  TextEditingController phone = TextEditingController();
  List<String> phoneNumbersAdded = [];
  String rentType = 'daily';
  String locationGovernorate = 'homs';
  String typeOfEstate = 'house';
  String clothingLevel = 'unfurnished';
  TextEditingController usPrice = TextEditingController();
  TextEditingController space = TextEditingController();
  TextEditingController numOfRooms = TextEditingController();
  TextEditingController numOfFloors = TextEditingController();
  TextEditingController floorNumber = TextEditingController();
  bool greenDeed = false;
  bool hasSolarPanels = false;
  bool hasWifi = false;
  bool hasGarage = false;
  bool hasPool = false;
  TextEditingController locationAddress = TextEditingController();
  TextEditingController description = TextEditingController();
  StatusRequest statusRequest = StatusRequest.none;
  final sliderController = Get.put(SearchByPriceWidgetController());
  bool isPriceSearchSliderEnabled = false;
  RangeValues selectedRange = RangeValues(50, 100);

  void changeForSale(String? val) {
    if (val != null) {
      forSale = val;
      if (val == '1') {
        sliderController.setRange(2000, 10000, 300000);
        selectedRange = sliderController.selectedRange!;
      } else {
        sliderController.setRange(10, 100, 1000);
        selectedRange = sliderController.selectedRange!;
      }
      update();
    }
  }

  void changeTypeOfEstate(String? val) {
    if (val != null) {
      typeOfEstate = val;
      update();
    }
  }

  void changeRentType(String? val) {
    if (val != null) {
      rentType = val;
      if (val == 'daily') {
        sliderController.setRange(10, 50, 200);
        selectedRange = sliderController.selectedRange!;
      } else {
        sliderController.setRange(200, 500, 2000);
        selectedRange = sliderController.selectedRange!;
      }
      update();
    }
  }

  void changeGreenDeed(bool? val) {
    if (val != null) {
      greenDeed = val;
      update();
    }
  }

  void changeHasSolarPanels(bool? val) {
    if (val != null) {
      hasSolarPanels = val;
      update();
    }
  }

  void changeHasWifi(bool? val) {
    if (val != null) {
      hasWifi = val;
      update();
    }
  }

  void changeHasGarage(bool? val) {
    if (val != null) {
      hasPool = val;
      update();
    }
  }

  void changeHasPool(bool? val) {
    if (val != null) {
      hasPool = val;
      update();
    }
  }

  void changeClothingLevel(String? val) {
    if (val != null) {
      clothingLevel = val;
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
      final photosCsv =await _adController.copyImagesToPermanentStorage();

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
      final descriptionText = safe(description);
      if (addressText.isEmpty) throw 'Car model is required.';
      if (descriptionText.isEmpty) throw 'Address is required.';

      // --- Numbers (null-safe) ---
      final priceStr = safe(usPrice);
      final spaceStr = safe(space);
      final nmOfRoomsStr = safe(numOfRooms);
      final nmOfFloors = safe(numOfFloors);
      final nmOfFloor = safe(floorNumber);
      if (spaceStr.isEmpty) throw 'Space is required.';
      // if (nmOfRoomsStr.isEmpty) throw 'Space is required.';
      // if (nmOfFloors.isEmpty) throw 'Space is required.';
      // if (spaceStr.isEmpty) throw 'Space is required.';
      final spacee = int.tryParse(spaceStr) ?? 0;
      final nmberofrooms = int.tryParse(nmOfRoomsStr) ?? 0;

      final price = int.tryParse(priceStr) ?? 0;
      if (price < 0) throw 'Enter a valid positive price.';

      // --- forSale: keep '1'/'0' in controller, insert as int in DB ---
      final forSaleInt = int.tryParse(forSale) ?? 0;
      final floorNum = int.tryParse(floorNumber.text) ?? 0;
      final rentTypeOut = (forSaleInt == 0) ? rentType : '';

      // --- Build Car object expected by your DbController ---
      final estate = Estate(
        adID: null,
        // userID: 0, // TODO: replace with real user id
        photos: photosCsv, // TEXT (CSV) per your schema
        phoneNumbers: phonesCsv, // TEXT (CSV)
        forSale: forSaleInt, // INTEGER for DB
        clothing: clothingLevel,
        description: descriptionText,
        floorNumber: floorNum,
        greenDeed: greenDeed ? 1 : 0,
        hasSolarPanels: hasSolarPanels ? 1 : 0,
        hasWifi: hasWifi ? 1 : 0,
        numOfFloors: int.tryParse(nmOfFloor) ?? -404,
        space: spacee,
        numOfRooms: nmberofrooms,
        typeOfRent: rentTypeOut,
        usPrice: price,
        type: typeOfEstate,
        governorate: locationGovernorate,
        address: addressText,
      );

      await _dbController.insertEstateAd(estate);

      statusRequest = StatusRequest.none;
      update();
      Get.back();
      Get.snackbar('Success', 'Your estate ad has been posted.');
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
      final String type = typeOfEstate; // dropdown

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
      final String rntType = (forSaleInt == 0) ? rentType : '';

      await _dbController.estatesFilteredSearch(
        governorate: governorate,
        address: address,
        forSale: forSaleInt,
        type: type,
        isPriceSearchSliderEnabled: byPrice,
        minPrice: minPrice,
        maxPrice: maxPrice,
        greenDeed: greenDeed ? 1 : 0,
        hasSolarPanels: hasSolarPanels ? 1 : 0,
        rentType: rntType,
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
