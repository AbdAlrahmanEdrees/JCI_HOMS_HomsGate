import 'package:get/get.dart';
import '../../core/class/stutusconntection.dart';
import '../../core/functions/handingdatacontroller.dart';
import '../../core/functions/urlluncher.dart';
import '../../core/services/shared_preferences/pref_service.dart';
import '../../data/models/get_one_property.dart';
import '../../data/remote/on_propery_data.dart';

class PropertyDetailsController extends GetxController {
  OnePropertyData propertyData = OnePropertyData(Get.find());
  GetOneProperty? data;
  SharedPreferencesService myServices = Get.find();
  late StatusRequest statusRequest;
  String? slug;
  List<String> imageurl = [];

  getdetailsforproperty() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await propertyData.getPropertyData(slug!);
    statusRequest = handlingData(response);
    update();
    print(statusRequest);
    if (statusRequest == StatusRequest.seccess) {
      if (response is Map<String, dynamic>) {
        data = GetOneProperty.fromJson(response);
        if (data!.images != null) {
          imageurl =
              data!.images!
                  .map((e) => e.image)
                  .where((image) => image != null)
                  .cast<String>()
                  .toList();
        } else {
          imageurl = [];
        }
      }

      update();
    } else {
      data = null;
    }
    update();
  }

  callwithphone(String phone) {
    lunchurl("tel:$phone");
  }

  @override
  void onInit() {
    slug = Get.arguments;
    getdetailsforproperty();
    super.onInit();
  }
}
