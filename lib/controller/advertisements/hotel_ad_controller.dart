import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:trip/controller/advertisements/advertisementController.dart';
import 'package:trip/core/class/stutusconntection.dart';
import 'package:trip/core/constanat/dropdownitems.dart';
import 'package:trip/data/models/ads_objects/hotel.dart';
import 'package:trip/data/temp_todelete/0.dbcontroller.dart';

class HotelAdController extends GetxController {
  final items = DropDownItems();
  // final adController = AddAdvertisementController();
  String forSale =
      '1'; // it is a string because of the custom Radio widget/ it should be sent as an integer for the endpoint
  TextEditingController phone = TextEditingController();
  List<String> phoneNumbersAdded = [];
  TextEditingController name = TextEditingController();
  String starRating = '3';
  String locationGovernorate = 'homs';
  TextEditingController usPrice = TextEditingController();
  TextEditingController openHour = TextEditingController();
  TextEditingController closeHour = TextEditingController();
  String amORpmOpen = 'am';
  String amORpmClose = 'pm';
  bool hasDelivery = false;
  bool hasElectricity = false;
  bool hasWifi = false;
  bool hasPool = false;
  TextEditingController locationAddress = TextEditingController();
  TextEditingController description = TextEditingController();
  StatusRequest statusRequest = StatusRequest.none;
  

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

  void changeHasPool(bool? val) {
    if (val != null) {
      hasPool = val;
      update();
    }
  }

  void changeLocationGovernorate(String? val) {
    if (val != null) {
      locationGovernorate = val;
      update();
    }
  }

  void changeStarRating(String? val) {
    if (val != null) {
      starRating = val;
      update();
    }
  }

  void uploadData() async {
    statusRequest = StatusRequest.loading;
    update();

    try {
      final dbController = Get.find<DbController>();
      final adController = Get.find<AdvertisementController>();

      // Extract image paths from XFile list
      // final List<String> imagePaths =
      //     adController.images.map((xfile) => xfile.path).toList();

      // Ensure at least one image is selected
      if (adController.images.isEmpty) {
        statusRequest = StatusRequest.failure;
        update();
        Get.snackbar("Error", "Please select at least three images for your ad.");
        return;
      }

      // Join image paths into a single comma-separated string
      final String photos =await adController.copyImagesToPermanentStorage();

      final hotel = Hotel(
        adID: null,
        // userID: 0, // Replace with actual user ID if available
        photos: photos,
        phoneNumbers: phoneNumbersAdded.join(','),
        hotelName: name.text,
        // starRating: double.tryParse(starRating) ?? 0.0,
        starRating: starRating,
        usPricePerNight: int.tryParse(usPrice.text) ?? 0,
        hasWifi: hasWifi ? 1 : 0,
        hasParking: hasDelivery ? 1 : 0, // Mapped from hasDelivery checkbox
        hasPool: hasPool ? 1 : 0,
        governorate: locationGovernorate,
        address: locationAddress.text,
        description: description.text, // Add description if needed
      );

      await dbController.insertHotelAd(hotel);

      statusRequest = StatusRequest.none;
      update();
      Get.back(); // Navigate back or show confirmation
      Get.snackbar('Success', 'Your hotel ad has been posted.');
    } catch (e) {
      statusRequest = StatusRequest.failure;
      update();
      print("Error uploading hotel ad: $e");
      Get.snackbar("Upload Failed", "Something went wrong. Please try again.");
    }
  }
}
