import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide Trans;
import 'package:trip/controller/advertisements/restaurants_and_cafes_controller.dart';
import 'package:trip/core/class/stutusconntection.dart';
import 'package:trip/core/constanat/colors.dart';
import 'package:trip/core/constanat/textstyles.dart';
import 'package:trip/data/models/ads_objects/restaurantorcafe.dart';
import 'package:trip/data/temp_todelete/0.dbcontroller.dart';
import 'package:trip/view/screen/advertisement_panel/restaurants/1.restaurant_card.dart';
import 'package:trip/view/widget/Custom_text.dart';
import 'package:trip/view/widget/Advertisement/customCheckbox.dart';
import 'package:trip/view/widget/Advertisement/custom_drop_down_menu.dart';
import 'package:trip/view/widget/Advertisement/custom_textfield.dart';
import 'package:trip/view/widget/filteredsearch/CustomRangeSlider.dart';

class RestaurantsAndCafesPage extends StatelessWidget {
  const RestaurantsAndCafesPage({super.key});


  @override
  Widget build(BuildContext context) {
    final db = Get.find<DbController>();

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0.5,
        leading: IconButton(
          onPressed: () {
            Get.back();
            Get.delete<RestaurantsAndCafesAdController>();
          },
          icon: const Icon(Icons.arrow_back, color: AppColors.brown),
        ),
        title: Text(
          "restaurants_and_cafes_ads_browser_page_title".tr(),
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
      body: GetBuilder<RestaurantsAndCafesAdController>(
        init: RestaurantsAndCafesAdController(),
        builder: (controller) {
          final items = db.restaurantsAndCafes;

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
                          Icons.restaurant,
                          size: 48.sp,
                          color: AppColors.brown,
                        ),
                        SizedBox(height: 12.h),
                        Center(
                          child: Text(
                            'no_results'.tr(),
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

                        final ad = RestaurantOrCafe(
                          adID: row['ad_id'],
                          userID: row['user_id'],
                          photos: row['photos'],
                          phoneNumbers: row['phone_numbers'],
                          name:row['name'],
                          type: row['type'],
                          usPrice: row['us_price'],
                          openHour: row['open_hour'],
                          closeHour: row['close_hour'],
                          amOrPmOpen: row['am_or_pm_open'],
                          amOrPmClose: row['am_or_pm_close'],
                          hasDelivery: row['has_delivery'],
                          hasElectricity: row['has_electricity'],
                          hasWifi: row['has_wifi'],
                          menuAndDescription: row['description'],
                          governorate: '${row['governorate']}'.tr(),
                          address: row['address'],
                        );

                        return RestaurantAndCafesAdCard(ad: ad);
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
            child: GetBuilder<RestaurantsAndCafesAdController>(
              init: RestaurantsAndCafesAdController(),
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
                      CustomTextField(
                        textEditingController: controller.locationAddress,
                        nameofitem: 'address'.tr(),
                        ireq: false,
                      ),
                      const SizedBox(height: 12),
                      CustomCheckBox(
                        value: controller.hasDelivery,
                        onChanged: controller.changeHasDelivery,
                        nameofitem: 'delivery_service'.tr(),
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
                          onPressed: () {},
                          // controller.statusRequest == StatusRequest.loading
                          //     ? null
                          //     : controller.filterSearch,
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
