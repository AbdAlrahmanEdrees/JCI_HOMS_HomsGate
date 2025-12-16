import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';
import 'package:trip/controller/advertisements/estate_ad_controller.dart';
import 'package:trip/core/class/stutusconntection.dart';
import 'package:trip/core/constanat/colors.dart';
import 'package:trip/core/constanat/textstyles.dart';
import 'package:trip/data/models/ads_objects/estate.dart';
import 'package:trip/data/temp_todelete/0.dbcontroller.dart';
import 'package:trip/view/screen/advertisement_panel/estates/1.estate_card.dart';
import 'package:trip/view/widget/Custom_text.dart';
import 'package:trip/view/widget/Advertisement/customCheckbox.dart';
import 'package:trip/view/widget/Advertisement/custom_drop_down_menu.dart';
import 'package:trip/view/widget/Advertisement/customradiobuttom.dart';
import 'package:trip/view/widget/filteredsearch/CustomRangeSlider.dart';

class EstatesPage extends StatelessWidget {
  const EstatesPage({super.key});
  @override
  Widget build(BuildContext context) {
    final dbController = Get.find<DbController>();
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.brown),
        leading: IconButton(
          onPressed: () {
            Get.back();
            Get.delete<EstatesAdController>();
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text(
          "search_for_estates_page_title".tr(),
          style: AppTextStyles.h13b,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showSearchDialog(context);
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: GetBuilder<EstatesAdController>(
        init: EstatesAdController(),
        builder: (controller) {
          final estates = dbController.estates;
          return RefreshIndicator(
            onRefresh: () async {},
            child:
                estates.isEmpty
                    ? ListView(
                      children: [
                        SizedBox(height: 120.h),
                        Icon(
                          Icons.house,
                          size: 48.sp,
                          color: AppColors.brown,
                        ),
                        SizedBox(height: 12.h),
                        Center(
                          child: Text(
                            'no_ads_published'.tr(),
                            style: AppTextStyles.p1b,
                          ),
                        ),
                      ],
                    )
                    : ListView.separated(
                      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 24.h),
              itemCount: estates.length,
              separatorBuilder: (_, _) {
                return SizedBox(height: 10);
              },
              itemBuilder: (_, index) {
                final row = estates[index];
                final estate = Estate(
                  adID: row['ad_id'],
                  userID: row['user_id'],
                  photos: row['photos'],
                  phoneNumbers: row['phone_numbers'],
                  forSale: row['for_sale'],
                  typeOfRent: row['type_of_rent'],
                  type: row['type'],
                  space: row['us_price'],
                  numOfRooms: row['num_of_rooms'],
                  numOfFloors: row['num_of_floors'],
                  floorNumber: row['floor_number'],
                  clothing: row['clothing'],
                  greenDeed: row['green_deed'],
                  hasWifi: row['has_wifi'],
                  hasSolarPanels: row['has_solar_panels'],
                  governorate: row['governorate'],
                  address: row['address'],
                  description: row['description'],
                );
                return EstateAdCard(estate: estate,);
              },
            ),
          );
        },
      ),
    );
  }
}

void showSearchDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder:
        (_) => Dialog(
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 24,
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: context.width),
            child: GetBuilder<EstatesAdController>(
              init: EstatesAdController(),
              builder: (controller) {
                final rentalItems =
                    controller.items.rentalPeriod.take(2).toList();

                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // --- Dropdowns ---
                      CustomDropDownMenu(
                        items: controller.items.governorate,
                        onchanged: controller.changeLocationGovernorate,
                        value: controller.locationGovernorate,
                        nameofitem: 'governorate'.tr(),
                        ireq: false,
                      ),
                      // CustomTextField(
                      //   textEditingController: controller.locationAddress,
                      //   nameofitem: 'address'.tr(),
                      //   ireq: false,
                      // ),
                      const SizedBox(height: 8),
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
                            items: controller.items.typeOfRent.sublist(0, 5),
                            onchanged: controller.changeRentType,
                            value: controller.rentType,
                            nameofitem: 'rent_type'.tr(),
                            ireq: true,
                          ),
                      const SizedBox(height: 12),
                      CustomDropDownMenu(
                        items: controller.items.typeOfEstate,
                        onchanged: controller.changeTypeOfEstate,
                        value: controller.typeOfEstate,
                        nameofitem: 'type_of_estate'.tr(),
                        ireq: true,
                      ),
                      (controller.typeOfEstate == "land")
                          ? SizedBox()
                          : CustomDropDownMenu(
                            items: controller.items.clothingLevel,
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

                      // --- Divider ---
                      Container(
                        width: double.infinity, // let dialog constraints win
                        height: 1,
                        color: AppColors.grey300,
                      ),
                      const SizedBox(height: 12),

                      // --- Toggle ---
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Checkbox(
                            value: controller.isPriceSearchSliderEnabled,
                            onChanged: controller.togglePriceSliderSearch,
                          ),
                          Text(
                            "activate_search_by_price".tr(),
                            style: const TextStyle(
                              fontFamily: "Tejwal",
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),

                      // --- Range label ---
                      Text(
                        controller.forSale == "1"
                            ? "acceptable_price_range".tr()
                            : "acceptable_rent_range".tr(),
                        style: TextStyle(
                          color: AppColors.greencolor,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Tejwal",
                          fontSize: 15,
                        ),
                      ),

                      // --- Values row ---
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              data:
                                  " ${controller.selectedRange.start.toInt()} ${'usd'.tr()}",
                              fontsize: 15,
                            ),
                            CustomText(
                              data:
                                  " ${controller.selectedRange.end.toInt()} ${'usd'.tr()}",
                              fontsize: 15,
                            ),
                          ],
                        ),
                      ),

                      // --- Slider ---
                      // CustomRangeSlider(
                      //   selectedRange: controller.selectedRange,
                      //   onChanged: controller.isSliderEnabled
                      //       ? (rv) => controller.changeRange(rv)
                      //       : null,
                      //   isEnabled: controller.isSliderEnabled,
                      // ),
                      CustomRangeSlider(
                        onChanged: controller.changeRange,
                        isEnabled:
                            controller
                                .isPriceSearchSliderEnabled, // Pass the enabled state
                      ),
                      const SizedBox(height: 12),

                      // --- Action ---
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed:
                              controller.statusRequest == StatusRequest.loading
                                  ? null
                                  : controller.filterSearch,
                          child:
                              controller.statusRequest == StatusRequest.loading
                                  ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                  : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "search".tr(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      const Icon(
                                        Icons.search,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
  );
}
