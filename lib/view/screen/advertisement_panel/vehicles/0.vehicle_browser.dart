import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:trip/controller/advertisements/car_ad_controller.dart';
import 'package:trip/core/class/stutusconntection.dart';
import 'package:trip/core/constanat/colors.dart';
import 'package:trip/core/constanat/textstyles.dart';
import 'package:trip/data/models/ads_objects/vehicle.dart';
import 'package:trip/data/temp_todelete/0.dbcontroller.dart';
import 'package:trip/view/screen/advertisement_panel/vehicles/1.vehicle_card.dart';
import 'package:trip/view/widget/Custom_text.dart';
import 'package:trip/view/widget/Advertisement/custom_drop_down_menu.dart';
import 'package:trip/view/widget/Advertisement/custom_textfield.dart';
import 'package:trip/view/widget/Advertisement/customradiobuttom.dart';
import 'package:trip/view/widget/filteredsearch/CustomRangeSlider.dart';

class CarsPage extends StatelessWidget {
  const CarsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final db = Get.find<DbController>();
    final userId = db.userId.value;
    final savedAds = db.userbooked;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0.5,
        leading: IconButton(
          onPressed: () {
            Get.back();
            Get.delete<CarAdController>();
          },
          icon: const Icon(Icons.arrow_back, color: AppColors.brown),
        ),
        title: Text(
          "vehicles_ads_browser_page_title".tr(),
          style: AppTextStyles.h13b,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => showSearchDialog(context),
            icon: const Icon(Icons.search, color: AppColors.brown),
            tooltip: 'search'.tr(),
          ),
        ],
      ),
      body: GetBuilder<CarAdController>(
        init: CarAdController(),
        builder: (controller) {
          final items = db.cars;

          // Pull-to-refresh wrapper (optional: wire to your controller’s reload)
          return RefreshIndicator(
            color: AppColors.blue,
            onRefresh: () async {
              // await controller.fetchCars();
              await Future.delayed(const Duration(milliseconds: 500));
            },
            child:
                items.isEmpty
                    ? ListView(
                      children: [
                        SizedBox(height: 120.h),
                        Icon(
                          Icons.directions_car_filled,
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
                      itemCount: items.length,
                      separatorBuilder: (_, __) => SizedBox(height: 10.h),
                      itemBuilder: (context, index) {
                        final row = items[index];
                        final saved = savedAds.firstWhere(
                          (r) =>
                              r['ad_id'] == row['id'] &&
                              r['user_id'] == userId,
                          orElse: () => {}, //return an empty map
                        );

                        final car = Vehicle(
                          adID: row['ad_id'],
                          userID: row['user_id'],
                          photos: row['photos'],
                          phoneNumbers: row['phone_numbers'],
                          forSale: row['for_sale'],
                          typeOfRent: row['type_of_rent'],
                          usPrice: row['us_price'],
                          type: row['type'],
                          brand: row['brand'],
                          model: row['model'],
                          transmission: '${row['transmission']}'.tr(),
                          kilometersTraveled: row['kilometers_traveled'],
                          year: row['year'],
                          governorate: '${row['governorate']}'.tr(),
                          address: row['address'],
                        );

                        return VehicleAdCard(car: car,saved:saved.isNotEmpty);
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
            child: GetBuilder<CarAdController>(
              init: CarAdController(),
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
                        onchanged: controller.changeCarLocationGovernorate,
                        value: controller.carLocationGovernorate,
                        nameofitem: 'governorate'.tr(),
                        ireq: false,
                      ),
                      CustomTextField(
                        textEditingController: controller.carLocationAddress,
                        nameofitem: 'address'.tr(),
                        ireq: false,
                      ),
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
                            value: controller.carRentType,
                            nameofitem: 'rent_type'.tr(),
                            ireq: false,
                          ),
                      const SizedBox(height: 12),
                      CustomDropDownMenu(
                        items: controller.items.typeOfVehicle,
                        onchanged: controller.changeVehicleType,
                        value: controller.vehicleType,
                        nameofitem: 'car_type'.tr(),
                        ireq: false,
                      ),
                      CustomDropDownMenu(
                        items: controller.items.carBrands,
                        onchanged: controller.changeCarBrand,
                        value: controller.carBrand,
                        nameofitem: 'car_brand'.tr(),
                        ireq: false,
                      ),
                      CustomTextField(
                        textEditingController: controller.carModel,
                        nameofitem: 'car_model'.tr(),
                        ireq: false,
                      ),
                      CustomDropDownMenu(
                        items: controller.items.carTransmissions,
                        onchanged: controller.changeCarBrand,
                        value: controller.carTransmission,
                        nameofitem: 'transmission'.tr(),
                        ireq: false,
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
                            activeColor: AppColors.blue,
                          ),
                          Text(
                            "activate_search_by_price".tr(),
                            style: AppTextStyles.h15b,
                          ),
                        ],
                      ),

                      // --- Range label ---
                      Text(
                        controller.forSale == "1"
                            ? "acceptable_price_range".tr()
                            : "acceptable_rent_range".tr(),
                        style: AppTextStyles.h15b,
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
                                      color: AppColors.blue,
                                    ),
                                  )
                                  : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "search".tr(),
                                        style: AppTextStyles.h15b,
                                      ),
                                      const SizedBox(width: 8),
                                      const Icon(
                                        Icons.search,
                                        color: AppColors.brown,
                                        size: 20,
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
