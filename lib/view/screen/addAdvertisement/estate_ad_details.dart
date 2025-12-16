import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trip/controller/advertisements/advertisementController.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';
import 'package:trip/controller/advertisements/estate_ad_controller.dart';
import 'package:trip/core/class/stutusconntection.dart';
import 'package:trip/core/constanat/colors.dart';
import 'package:trip/core/constanat/textstyles.dart';
import 'package:trip/view/widget/Advertisement/add_phones.dart';
import 'package:trip/view/widget/Advertisement/customCheckbox.dart';
import 'package:trip/view/widget/Advertisement/customTextFieldDigital.dart';
import 'package:trip/view/widget/Advertisement/custom_drop_down_menu.dart';
import 'package:trip/view/widget/Advertisement/custom_textfield.dart';
import 'package:trip/view/widget/Advertisement/customradiobuttom.dart';

class EstateAdDetails extends StatelessWidget {
  const EstateAdDetails({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(EstatesAdController());
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final adController = Get.find<AdvertisementController>();
    // final carAdController = Get.put(CarAdController());
    return GetBuilder<EstatesAdController>(
      init: EstatesAdController(),
      builder:
          (controller) => Column(
            spacing: 3.sp,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomRedioButton(
                    val: "1", //1: for sale
                    groupval: controller.forSale,
                    onchanged: (val) {
                      controller.changeForSale(val!);
                    },
                    title: "sale".tr(),
                  ),
                  CustomRedioButton(
                    val: "0",
                    groupval: controller.forSale,
                    onchanged: (val) {
                      controller.changeForSale(val!);
                    },
                    title: "rent".tr(),
                  ),
                ],
              ),
              controller.forSale == '1'
                  ? SizedBox()
                  : CustomDropDownMenu(
                    items: adController.items.typeOfRent.sublist(2, 6),
                    onchanged: controller.changeRentType,
                    value: controller.rentType,
                    nameofitem: 'rent_type'.tr(),
                    ireq: true,
                  ),
              CustomTextFieldDigital(
                textEditingController: controller.usPrice,
                nameofitem: 'us_price'.tr(),
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
              CustomDropDownMenu(
                items: adController.items.typeOfEstate,
                onchanged: controller.changeTypeOfEstate,
                value: controller.typeOfEstate,
                nameofitem: 'type_of_estate'.tr(),
                ireq: true,
              ),
              CustomTextFieldDigital(
                textEditingController: controller.space,
                nameofitem: 'space'.tr(),
                ireq: true,
              ),
              (controller.typeOfEstate == "land")
                  ? SizedBox()
                  : CustomTextFieldDigital(
                    textEditingController: controller.numOfRooms,
                    nameofitem: 'number_of_rooms'.tr(),
                    ireq: true,
                  ),
              (controller.typeOfEstate != "house" &&
                      controller.typeOfEstate != 'villa' &&
                      controller.typeOfEstate != 'holiday_villa' &&
                      controller.typeOfEstate != 'building')
                  ? SizedBox()
                  : CustomTextFieldDigital(
                    textEditingController: controller.numOfFloors,
                    nameofitem: 'number_of_floors'.tr(),
                    ireq: true,
                  ),
              (controller.typeOfEstate != "flat" &&
                      controller.typeOfEstate != 'office' &&
                      controller.typeOfEstate != 'chalet' &&
                      controller.typeOfEstate != 'store')
                  ? SizedBox()
                  : CustomTextFieldDigital(
                    textEditingController: controller.floorNumber,
                    nameofitem: 'floor_number'.tr(),
                    ireq: true,
                  ),
              (controller.typeOfEstate == "land")
                  ? SizedBox()
                  : CustomDropDownMenu(
                    items: adController.items.clothingLevel,
                    onchanged: controller.changeClothingLevel,
                    value: controller.clothingLevel,
                    nameofitem: 'clothing_level'.tr(),
                    ireq: true,
                  ),
              (controller.typeOfEstate == 'flat')
                  ? SizedBox()
                  : CustomCheckBox(
                    nameofitem: 'green_deed'.tr(),
                    ireq: true,
                    value: controller.greenDeed,
                    onChanged: controller.changeGreenDeed,
                  ),
              (controller.typeOfEstate == "land")
                  ? SizedBox()
                  : CustomCheckBox(
                    nameofitem: 'has_wifi'.tr(),
                    ireq: true,
                    value: controller.hasWifi,
                    onChanged: controller.changeHasWifi,
                  ),
                   CustomCheckBox(
                    nameofitem: 'has_solar_panels'.tr(),
                    ireq: true,
                    value: controller.hasSolarPanels,
                    onChanged: controller.changeHasSolarPanels,
                  ),
              // CustomCheckBox(
              //   nameofitem: 'has_garage'.tr(),
              //   ireq: true,
              //   value: controller.hasPool,
              //   onChanged: controller.changeHasGarage,
              // ),
              // CustomCheckBox(
              //   nameofitem: 'has_pool'.tr(),
              //   ireq: true,
              //   value: controller.hasPool,
              //   onChanged: controller.changeHasPool,
              // ),
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
                  style: AppTextStyles.p1,
                  controller:controller.description,
                  minLines: 5,
                  maxLines: 20,
                  decoration: InputDecoration(
                    hint: Center(
                      child: Text(
                        'add_description'.tr(),
                        style: AppTextStyles.h15b
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
                            ? Colors.blue
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
                              Icon(Icons.upload, color: AppColors.brown,size:20),
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
