import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trip/controller/advertisements/advertisementController.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';
import 'package:trip/controller/advertisements/hotel_ad_controller.dart';
import 'package:trip/core/class/stutusconntection.dart';
import 'package:trip/core/constanat/colors.dart';
import 'package:trip/core/constanat/textstyles.dart';
import 'package:trip/view/widget/Advertisement/add_phones.dart';
import 'package:trip/view/widget/Advertisement/customCheckbox.dart';
import 'package:trip/view/widget/Advertisement/customTextFieldDigital.dart';
import 'package:trip/view/widget/Advertisement/custom_drop_down_menu.dart';
import 'package:trip/view/widget/Advertisement/custom_dropdown_star_rating.dart';
import 'package:trip/view/widget/Advertisement/custom_textfield.dart';

class HotelAdDetails extends StatelessWidget {
  const HotelAdDetails({super.key});

  @override
  Widget build(BuildContext context) {
    // Get.put(RestaurantsAndCafesAdController());
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final adController = Get.find<AdvertisementController>();
    // final carAdController = Get.put(CarAdController());
    return GetBuilder<HotelAdController>(
      init: HotelAdController(),
      builder:
          (controller) => Column(
            spacing: 3.sp,
            children: [
              CustomTextField(
                textEditingController: controller.name,
                nameofitem: 'name'.tr(),
                ireq: true,
              ),
              CustomTextFieldDigital(
                textEditingController: controller.usPrice,
                nameofitem: 'avg_price_per_night'.tr(),
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
              CustomDropDownStarRating(
                items: adController.items.stars,
                onchanged: controller.changeStarRating,
                value: controller.starRating,
                nameofitem: 'star_rating'.tr(),
                ireq: true,
              ),
              CustomCheckBox(
                onChanged: controller.changeHasDelivery,
                value: controller.hasDelivery,
                nameofitem: 'has_parking'.tr(),
                ireq: true,
              ),
              CustomCheckBox(
                onChanged: controller.changeHasWifi,
                value: controller.hasWifi,
                nameofitem: 'wifi'.tr(),
                ireq: true,
              ),
              CustomCheckBox(
                onChanged: controller.changeHasPool,
                value: controller.hasPool,
                nameofitem: 'pool'.tr(),
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
                  controller: controller.description,
                  minLines: 5,
                  maxLines: 20,
                  decoration: InputDecoration(
                    hint: Center(
                      child: Text(
                        'description'.tr(),
                        style: TextStyle(
                          fontFamily: "Tejwal",
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.sp,
                        ),
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
                              Text(
                                "post".tr(),
                                style: AppTextStyles.h15b,
                              ),
                              Icon(Icons.upload, color: AppColors.brown, size:18),
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
