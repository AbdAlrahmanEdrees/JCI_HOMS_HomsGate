import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trip/controller/advertisements/advertisementController.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';
import 'package:trip/controller/advertisements/car_ad_controller.dart';
import 'package:trip/core/class/stutusconntection.dart';
import 'package:trip/core/constanat/colors.dart';
import 'package:trip/core/constanat/textstyles.dart';
import 'package:trip/view/widget/Advertisement/add_phones.dart';
import 'package:trip/view/widget/Advertisement/customTextFieldDigital.dart';
import 'package:trip/view/widget/Advertisement/customTextFieldHours.dart';
import 'package:trip/view/widget/Advertisement/custom_drop_down_menu.dart';
import 'package:trip/view/widget/Advertisement/custom_textfield.dart';
import 'package:trip/view/widget/Advertisement/customradiobuttom.dart';

class VehicleAdDetails extends StatelessWidget {
  const VehicleAdDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    // final adController = Get.find<AdvertisementController>();
    final adController = Get.put(AdvertisementController());
    // final carAdController = Get.put(CarAdController());
    return GetBuilder<CarAdController>(
      init: CarAdController(),
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
                    items: adController.items.typeOfRent.sublist(0, 5),
                    onchanged: controller.changeVehicleType,
                    value: controller.carRentType,
                    nameofitem: 'rent_type'.tr(),
                    ireq: true,
                  ),
              CustomTextFieldDigital(
                textEditingController: controller.carPrice,
                nameofitem: 'us_price'.tr(),
                ireq: true,
              ),
              SizedBox(
                height: 150.sp,
                child: AddPhonesWidget(
                  phoneTextEditingController: controller.phone,
                  phoneNumbersAdded: controller.phoneNumbersAdded,
                  getxController: controller,
                ),
              ),
              CustomDropDownMenu(
                items: adController.items.typeOfVehicle,
                onchanged: controller.changeVehicleType,
                value: controller.vehicleType,
                nameofitem: 'vehicle_type'.tr(),
                ireq: true,
              ),
              CustomDropDownMenu(
                items: adController.items.carBrands,
                onchanged: controller.changeCarBrand,
                value: controller.carBrand,
                nameofitem: 'brand'.tr(),
                ireq: true,
              ),
              CustomTextField(
                textEditingController: controller.carModel,
                nameofitem: 'model'.tr(),
                ireq: true,
              ),
              CustomDropDownMenu(
                items: adController.items.carTransmissions,
                onchanged: controller.changeCarTransmission,
                value: controller.carTransmission,
                nameofitem: 'transmission'.tr(),
                ireq: true,
              ),
              CustomTextFieldHoursWithUnitsTrailer(
                textEditingController: controller.kilometersTraveled,
                nameofitem: 'kilometers_traveled'.tr(),
                unit: 'kilometer'.tr(),
                ireq: true,
              ),
              CustomTextFieldDigital(
                textEditingController: controller.carYear,
                nameofitem: 'year'.tr(),
                ireq: true,
              ),
              CustomDropDownMenu(
                items: adController.items.governorate,
                onchanged: controller.changeCarLocationGovernorate,
                value: controller.carLocationGovernorate,
                nameofitem: 'governorate'.tr(),
                ireq: true,
              ),
              CustomTextField(
                textEditingController: controller.carLocationAddress,
                nameofitem: 'address'.tr(),
                ireq: true,
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
                              Text("post".tr(), style: AppTextStyles.h15b),
                              Icon(
                                Icons.upload,
                                color: AppColors.brown,
                                size: 18,
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
