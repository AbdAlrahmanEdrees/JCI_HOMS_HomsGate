import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trip/controller/advertisements/advertisementController.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';
import 'package:trip/controller/advertisements/restaurants_and_cafes_controller.dart';
import 'package:trip/core/class/stutusconntection.dart';
import 'package:trip/core/constanat/colors.dart';
import 'package:trip/core/constanat/textstyles.dart';
import 'package:trip/view/widget/Advertisement/add_phones.dart';
import 'package:trip/view/widget/Advertisement/customCheckbox.dart';
import 'package:trip/view/widget/Advertisement/customTextFieldDigital.dart';
import 'package:trip/view/widget/Advertisement/customTextFieldHours.dart';
import 'package:trip/view/widget/Advertisement/custom_drop_down_menu.dart';
import 'package:trip/view/widget/Advertisement/custom_textfield.dart';

class RestaurantsAndCafesDetails extends StatelessWidget {
  const RestaurantsAndCafesDetails({super.key});

  @override
  Widget build(BuildContext context) {
    // Get.put(RestaurantsAndCafesAdController());
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final adController = Get.find<AdvertisementController>();
    // final carAdController = Get.put(CarAdController());
    return GetBuilder<RestaurantsAndCafesAdController>(
      init: RestaurantsAndCafesAdController(),
      builder:
          (controller) => Column(
            spacing: 3.sp,
            children: [
              CustomDropDownMenu(
                items: adController.items.restaurantOrCafe,
                onchanged: controller.changeType,
                value: controller.type,
                nameofitem: 'restaurant_or_cafe'.tr(),
                ireq: true,
              ),
              CustomTextField(
                textEditingController: controller.name,
                nameofitem: 'name'.tr(),
                ireq: true,
              ),
              CustomTextFieldDigital(
                textEditingController: controller.usPrice,
                nameofitem: 'avg_us_bill'.tr(),
                ireq: true,
              ),
              SizedBox(
                // height: 150.sp,
                child: AddPhonesWidget(
                  phoneTextEditingController: controller.phone,
                  phoneNumbersAdded: controller.phoneNumbersAdded,
                  getxController: controller,
                ),
              ),
              CustomTextFieldHoursWithUnitsTrailer(
                textEditingController: controller.openHour,
                unit: controller.amORpmOpen,
                tapOnUnit: controller.toggleAmPmOpen,
                nameofitem: 'open_at'.tr(),
                ireq: true,
              ),
              CustomTextFieldHoursWithUnitsTrailer(
                textEditingController: controller.closeHour,
                unit: controller.amORpmClose,
                tapOnUnit: controller.toggleAmPmClose,
                nameofitem: 'close_at'.tr(),
                ireq: true,
              ),
              CustomCheckBox(
                onChanged: controller.changeHasDelivery,
                value: controller.hasDelivery,
                nameofitem: 'delivery_service'.tr(),
                ireq: true,
              ),
              CustomCheckBox(
                onChanged: controller.changeHasElectricity,
                value: controller.hasElectricity,
                nameofitem: 'electricity'.tr(),
                ireq: true,
              ),
              CustomCheckBox(
                onChanged: controller.changeHasWifi,
                value: controller.hasWifi,
                nameofitem: 'wifi'.tr(),
                ireq: true,
              ),
              CustomDropDownMenu(
                items: adController.items.governorate,
                onchanged: controller.changeLocationGovernorate,
                value: controller.locationGovernorate,
                nameofitem: 'governorate'.tr(),
                ireq: true,
              ),
              CustomTextField(
                textEditingController: controller.locationAddress,
                nameofitem: 'address'.tr(),
                ireq: true,
              ),
              Container(
                width: screenWidth,
                decoration: BoxDecoration(border: BoxBorder.all()),
                child: TextField(
                  controller: controller.menuAndDescription,
                  minLines: 5,
                  maxLines: 20,
                  style: AppTextStyles.p1,
                  decoration: InputDecoration(
                    hint: Center(
                      child: Text(
                        'menu_and_description'.tr(),
                        style: AppTextStyles.h15b,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    controller.uploadData();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        controller.statusRequest == StatusRequest.loading
                            ? AppColors.blue
                            : AppColors.beige,
                  ),
                  child:
                      controller.statusRequest == StatusRequest.loading
                          ? CircularProgressIndicator(color: Colors.white)
                          : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("post".tr(), style: AppTextStyles.h14b),
                              Icon(
                                Icons.upload,
                                color: AppColors.brown,
                                size: 20,
                              ),
                            ],
                          ),
                ),
              ),

              // CustomTextField(value: 'value', nameofitem: 'nameofitem', ireq: true)
              // CustomDropDownMenu(
              //   items: adController.items.cladding,
              //   onchanged: (String? val) {
              //     adController.updateTypeOfDropDown(
              //       'typeOfSellingOrRentingSelected',
              //       val!,
              //     );
              //   },
              //   value: adController.typeOfSelingOrRentingSelected,
              //   nameofitem: "type_of_property",
              //   ireq: true,
              // ),
            ],
          ),
    );
  }
}
