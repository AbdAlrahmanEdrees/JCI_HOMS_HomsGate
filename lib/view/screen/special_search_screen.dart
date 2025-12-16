import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';
import '../../controller/spisial_search_controller.dart';
import '../../core/constanat/colors.dart';
import '../widget/Advertisement/customradiobuttom.dart';
import '../widget/Advertisement/custom_drop_down_menu.dart';

class SpicialSearchScreen extends StatelessWidget {
  const SpicialSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SpicialSearchController controller = Get.put(SpicialSearchController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.greencolor,
        title: Text(
          "what_are_you_interested_in".tr(),
          style: TextStyle(color: Colors.white, fontFamily: "Tejwal"),
        ),
        centerTitle: true,
      ),
      body: GetBuilder<SpicialSearchController>(
        builder: (controller) {
          return Column(
            children: [
              Image.asset("Assets/images/123333.PNG"),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomRedioButton(
                    val: "for_rent".tr(),
                    groupval: controller.stutus,
                    onchanged: (val) {
                      controller.changestutus(val);
                    },
                    title: 'rent'.tr(),
                  ),
                  CustomRedioButton(
                    val: "for_sale".tr(),
                    groupval: controller.stutus,
                    onchanged: (val) {
                      controller.changestutus(val);
                    },
                    title: 'sale',
                  ),
                ],
              ),
              CustomDropDownMenu(
                items: controller.items.typeOfEstate,
                onchanged: (String? val) {
                  controller.typeOfPropertyupdate(val!);
                },
                value: controller.typeOfPropertyselected,
                nameofitem: "property_type".tr(),
                ireq: true,
              ),
              SizedBox(height: 14.sp),
              CustomDropDownMenu(
                items: controller.items.governorate,
                onchanged: (String? val) {
                  controller.locationupdate(val!);
                },
                value: controller.locationselected,
                nameofitem: 'location'.tr(),
                ireq: true,
              ),
              ElevatedButton(
                onPressed: () {
                  controller.sentnoti();
                },
                child: Padding(
                  padding: EdgeInsets.all(10.sp),
                  child: Text("done".tr()),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
