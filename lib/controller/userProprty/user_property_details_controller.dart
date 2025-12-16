import 'package:get/get.dart';
import 'package:trip/data/models/propertymodel.dart';
class UserPropertyDetailsController extends GetxController{
  late PropertyModel data;
  List<String> imageurl=[];
  @override
  void onInit() {
    data=Get.arguments;
    if (data.images != null) {
      imageurl = data.images!.map<String>((image) => image.image!).toList();
    }    print('0000000000000000000000000000000000000000000000000');
    print(data);
    print(imageurl);
    super.onInit();
  }
}