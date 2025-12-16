import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';
import 'package:trip/controller/advertisements/hotel_ad_controller.dart';
import 'package:trip/controller/booking_for_trip/hotel_booking_controller.dart';
import 'package:trip/core/class/stutusconntection.dart';
import 'package:trip/core/constanat/colors.dart';
import 'package:trip/core/constanat/textstyles.dart';
import 'package:trip/data/models/ads_objects/hotel.dart';
import 'package:trip/data/temp_todelete/0.dbcontroller.dart';
import 'package:trip/view/screen/advertisement_panel/hotels/1.hotel_card.dart';
import 'package:trip/view/widget/Custom_text.dart';
import 'package:trip/view/widget/Advertisement/custom_drop_down_menu.dart';
import 'package:trip/view/widget/filteredsearch/CustomRangeSlider.dart';

class HotelsPage extends StatelessWidget {
  const HotelsPage({super.key});

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
            Get.delete<HotelAdController>();
          },
          icon: const Icon(Icons.arrow_back, color: AppColors.brown),
        ),
        title: Text(
          "hotels_ads_browser_page_title".tr(),
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
      body: GetBuilder<HotelAdController>(
        init: HotelAdController(),
        builder: (controller) {
          final items = db.hotels;

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
                          Icons.hotel,
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

                        final hotel = Hotel(
                          adID: row['ad_id'],
                          userID: row['user_id'],
                          photos: row['photos'],
                          phoneNumbers: row['phone_numbers'],
                          usPricePerNight: row['us_price_per_night'],
                          governorate: '${row['governorate']}'.tr(),
                          address: row['address'],
                          description: row['description'],
                          hasParking: row['has_parking'],
                          hasPool: row['has_pool'],
                          hasWifi: row['has_wifi'],
                          hotelName: row['hotel_name'],
                          starRating: row['star_rating'].toString(),
                        );

                        return HotelAdCard(hotel: hotel);
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
            child: GetBuilder<HotelBookingController>(
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
                        onchanged:
                            (val) => controller.updateTypeOfDropDown(
                              "locationselected",
                              val ?? '',
                            ),
                        value: controller.locationselected,
                        nameofitem: 'location'.tr(),
                        ireq: false,
                      ),
                      const SizedBox(height: 8),
                      CustomDropDownMenu(
                        items: rentalItems,
                        onchanged:
                            (val) => controller.updateTypeOfDropDown(
                              'Rentalperiodselected',
                              val ?? '',
                            ),
                        value: controller.rentalPeriodSelected,
                        nameofitem: 'rental_type'.tr(),
                        ireq: false,
                      ),
                      const SizedBox(height: 12),

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
                            value: controller.isSliderEnabled,
                            onChanged:
                                (v) => controller.toggleSlider(v ?? false),
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
                        controller.changeitems
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
                                  " ${controller.selectedRange.start.toInt()} ${controller.changeitems ? 'million'.tr() : 'syrian_pound'.tr()}",
                              fontsize: 15,
                            ),
                            CustomText(
                              data:
                                  " ${controller.selectedRange.end.toInt()} ${controller.changeitems ? 'million'.tr() : 'syrian_pound'.tr()}",
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
                        onChanged: (value) {},
                        isEnabled:
                            controller
                                .isSliderEnabled, // Pass the enabled state
                      ),
                      const SizedBox(height: 12),

                      // --- Action ---
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed:
                              controller.statusRequest == StatusRequest.loading
                                  ? null
                                  : controller.uplodeData,
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
