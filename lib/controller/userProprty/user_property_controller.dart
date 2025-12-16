import 'package:get/get.dart';
import 'package:trip/core/constanat/routing.dart';
import 'package:trip/data/remote/user_property-data.dart';
import '../../core/class/stutusconntection.dart';
import '../../core/constanat/staticdata.dart';
import '../../core/functions/handingdatacontroller.dart';
import '../../core/services/shared_preferences/pref_service.dart';
import '../../data/models/propertymodel.dart';

class UserPropertyController extends GetxController {
  UserPropertyData userPropertyData = UserPropertyData(Get.find());
  SharedPreferencesService myServices = Get.find();
  List<PropertyModel> data = [];
  late StatusRequest statusRequest;

  @override
  void onInit() {
    initialData();
    super.onInit();
  }

  deleteProperty(String slug, int index) async {
    statusRequest = StatusRequest.loading;
    update();

    var response = await userPropertyData.deleteProperty(
      slug,
      Staticdata.token!,
    );
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.seccess) {
      Get.snackbar("تمت", "تم حذف العقار بنجاح");
      data.removeWhere((element) => element.slug == slug);
    }
    update();
  }

  goToUpdateScreen(var data) {
    Get.toNamed(AppRoute.updateuserproprty, arguments: data);
  }

  initialData() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await userPropertyData.getPropertyData(Staticdata.token!);
    statusRequest = handlingData(response);
    print(statusRequest);
    print(myServices.pref.getString('token'));
    if (statusRequest == StatusRequest.seccess) {
      if (response is List) {
        print(myServices.pref.getString('token'));
        data = response.map((item) => PropertyModel.fromJson(item)).toList();
        print(data);
      }
    }
    update();
  }

  void goToDetailsProperty(PropertyModel data) {
    Get.toNamed(
      AppRoute.userpropertydetails,
      arguments: data,
      preventDuplicates: false,
    );
  }
}
