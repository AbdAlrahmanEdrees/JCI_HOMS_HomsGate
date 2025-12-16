import 'package:get/get.dart';

import '../../core/constanat/routing.dart';
import '../../data/models/propertymodel.dart';
class FilteredPropertyController extends GetxController{
  List<PropertyModel> data = [];
  @override
  void onInit() {
    data=Get.arguments;
    // TODO: implement onInit
    super.onInit();
  }
  void goToDetailsProperty(PropertyModel data) {
    Get.toNamed(AppRoute.userpropertydetails, arguments: data,
        preventDuplicates: false);
  }
  }