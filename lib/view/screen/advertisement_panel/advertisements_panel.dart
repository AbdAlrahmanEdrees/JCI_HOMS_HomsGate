import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:trip/core/constanat/colors.dart';
import 'package:trip/core/constanat/textstyles.dart';
import 'package:trip/view/screen/advertisement_panel/estates/0.estates_browser.dart';
import 'package:trip/view/screen/advertisement_panel/hotels/0.hotels_browser.dart';
import 'package:trip/view/screen/advertisement_panel/restaurants/0.restaurants_browser.dart';
import 'package:trip/view/screen/advertisement_panel/vehicles/0.vehicle_browser.dart';

class AdvertisementsPanel extends StatelessWidget {
  const AdvertisementsPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: screenHeight / 3.8,
        // color: AppColors.grey300.withOpacity(0.3),
        color: AppColors.white,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
            children: [
              Text(
                "advertisements".tr(),
                style: AppTextStyles.h13b,
              ),
              // SizedBox(height: 5),
              Row(
                spacing: 10,
                children: [
                  serviceCard(0),
                  Expanded(child: SizedBox()),
                  serviceCard(1),
                ],
              ),
              Expanded(child: SizedBox()),
              Row(
                spacing: 10,
                children: [
                  serviceCard(2),
                  Expanded(child: SizedBox()),
                  serviceCard(3),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget serviceCard(int cardNumber) {
  final imagesPaths = [
    'Assets/app_icons/house.png',
    'Assets/app_icons/car.png',
    'Assets/app_icons/hotel.png',
    'Assets/app_icons/restaurant.png',
  ];
  final pages = [
    EstatesPage(),
    CarsPage(),
    HotelsPage(),
    RestaurantsAndCafesPage(),
  ];
  RxBool blink = false.obs;
  return InkWell(
    onTap: () {
      // Get.to(MyHome());
      blink.value = true;
      Get.to(pages[cardNumber]);
      Future.delayed(const Duration(milliseconds: 100), () {
        blink.value = false;
      });
    },
    child: Obx(
      () => AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        width: 160,
        height: 60,
        decoration: BoxDecoration(
          color:
              // blink.value ? AppColors.cyan1.withOpacity(0.3) : AppColors.white,
              blink.value ? AppColors.blue : AppColors.beige,
          border: Border.all(width: 1, color: AppColors.brown),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  // color: AppColors.cyan2.withOpacity(0.2),
                  color: AppColors.blue.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(
                height: 50,
                width: 50,
                child: Image.asset(imagesPaths[cardNumber]),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
