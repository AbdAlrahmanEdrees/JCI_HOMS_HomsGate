import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trip/controller/userProprty/user_property_controller.dart';
import 'package:trip/core/class/stutusconntection.dart';
import 'package:trip/core/constanat/routing.dart';
import 'package:trip/core/constanat/staticdata.dart';
import 'package:trip/core/services/shared_preferences/pref_service.dart';

import '../../core/constanat/dropdownitems.dart';
import '../../core/functions/handingdatacontroller.dart';
import '../../data/models/propertymodel.dart';
import '../../data/remote/update_property_data.dart';

class UpdateUserPropertyController extends GetxController {
  DropDownItems items = DropDownItems();
  late PropertyModel data;
  File? imgFile;

  String typeOfPropertyselected = 'other';
  String floorselected = '2';
  String prpertyFounderselected = 'green_deed';
  String Ownertypeselected = 'owner';
  String claddingselected = 'half_cladding';
  String directionselected = 'south';
  String conditionselected = 'excellent';
  String locationselected = 'damascus';
  String Rentalperiodselected = 'daily';
  String stutus = "for_sale";
  bool pool = false;
  bool solar_panels = false;
  bool elevator = false;
  String? propertyid;

  final GlobalKey<FormState> propertydetailsKey = GlobalKey<FormState>();
  bool changeitems = true;
  UpdateUserPropertyData updateUserPropertyData = UpdateUserPropertyData(
    Get.find(),
  );
  UserPropertyController userpropertycontroller = Get.find();
  late TextEditingController price;
  late TextEditingController size;
  late TextEditingController numOfRoom;
  late TextEditingController description;
  late TextEditingController userPhone;
  late TextEditingController Dateuser;
  late TextEditingController title;
  late TextEditingController regoin;
  late TextEditingController street;
  late TextEditingController bedroom;
  late TextEditingController bathroom;
  late TextEditingController kitchin;
  late TextEditingController livingroom;
  late TextEditingController numofproperty;
  StatusRequest statusRequest = StatusRequest.none;
  SharedPreferencesService myServices = Get.find();
  void updateValues(PropertyModel data) {
    typeOfPropertyselected = data.propertyType ?? 'other';
    floorselected = data.floorNumber?.toString() ?? '2';
    prpertyFounderselected = data.covering ?? 'green_deed';
    Ownertypeselected = data.userType ?? 'owner';
    claddingselected = data.furnishing ?? 'half_cladding';
    directionselected = data.direction ?? 'south';
    conditionselected = data.covering ?? 'excellent';
    locationselected = data.location?.city ?? 'damascus';
    stutus = data.propertyStatus ?? "for_sale";
    pool = data.pool ?? false;
    solar_panels = data.solarPanels ?? false;
    elevator = data.elevator ?? false;
  }

  onCancle() {
    print("00000000000000000");
    Get.back();
  }

  void changestateofAdditionalfeatures(String featureName) {
    if (featureName == "pool") {
      pool = !pool;
    } else if (featureName == "solar_panels") {
      solar_panels = !solar_panels;
    } else if (featureName == "elevator") {
      elevator = !elevator;
    }
    update();
  }

  Future<void> pickImages() async {
    final selectedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (selectedImage != null) {
      imgFile = File(selectedImage.path);
      update();
    }
  }

  void changestutus(String? val) {
    stutus = val!;
    changeitems = val == "for_sale";
    update();
  }

  void updateType(String val, String type) {
    type = val;
    update();
  }

  UpdateData() async {
    data.title = title.text;
    data.price = int.tryParse(price.text);
    data.plotArea = size.text;
    data.totalRooms = int.tryParse(numOfRoom.text);
    data.description = description.text;
    data.location!.street = street.text;
    data.location!.region = regoin.text;
    data.bedrooms = int.tryParse(bedroom.text);
    data.bathrooms = int.tryParse(bathroom.text);
    data.kitchens = int.tryParse(kitchin.text);
    data.livingRooms = int.tryParse(livingroom.text);
    data.floorNumber = int.tryParse(numofproperty.text);

    statusRequest = StatusRequest.loading;
    update();

    var response = await updateUserPropertyData.UpdatePropertyDeatilsData(
      typeOfPropertyselected,
      userPhone.text,
      title.text,
      description.text,
      locationselected,
      regoin.text,
      street.text,
      numofproperty.text,
      price.text,
      "",
      "",
      floorselected,
      bedroom.text,
      bathroom.text,
      kitchin.text,
      livingroom.text,
      stutus,
      elevator,
      pool,
      solar_panels,
      claddingselected,
      directionselected,
      numOfRoom.text,
      Ownertypeselected,
      conditionselected,
      Staticdata.token!,
      data.slug!,
    );

    statusRequest = handlingData(response);
    update();

    if (statusRequest == StatusRequest.seccess) {
      userpropertycontroller.data.clear();
      userpropertycontroller.initialData();
      Get.snackbar("done".tr(), "done_snackbar_edit_property_message".tr());
      Get.offAndToNamed(AppRoute.userproperty);
    }
  }

  @override
  void onInit() {
    data = Get.arguments;
    updateValues(data);
    userPhone = TextEditingController(text: data.phoneNumber);
    Dateuser = TextEditingController();
    price = TextEditingController(text: data.price.toString());
    numOfRoom = TextEditingController(text: data.totalRooms.toString());
    size = TextEditingController(text: data.plotArea);
    description = TextEditingController(text: data.description);
    street = TextEditingController(text: data.location!.street);
    title = TextEditingController(text: data.title);
    regoin = TextEditingController(text: data.location!.region);
    bathroom = TextEditingController(text: data.bathrooms.toString());
    bedroom = TextEditingController(text: data.bedrooms.toString());
    kitchin = TextEditingController(text: data.kitchens.toString());
    livingroom = TextEditingController(text: data.livingRooms.toString());
    numofproperty = TextEditingController(text: data.floorNumber.toString());

    super.onInit();
  }

  @override
  void dispose() {
    numofproperty.dispose();
    bedroom.dispose();
    bathroom.dispose();
    kitchin.dispose();
    livingroom.dispose();
    userPhone.dispose();
    Dateuser.dispose();
    price.dispose();
    description.dispose();
    numOfRoom.dispose();
    size.dispose();
    title.dispose();
    super.dispose();
  }
}
