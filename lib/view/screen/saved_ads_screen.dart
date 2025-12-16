import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';
import 'package:trip/core/constanat/colors.dart';
import 'package:trip/core/constanat/textstyles.dart';
import 'package:trip/data/models/ads_objects/estate.dart';
import 'package:trip/data/models/ads_objects/hotel.dart';
import 'package:trip/data/models/ads_objects/restaurantorcafe.dart';
import 'package:trip/data/models/ads_objects/vehicle.dart';
import 'package:trip/data/temp_todelete/0.dbcontroller.dart';
import 'package:trip/view/screen/advertisement_panel/estates/1.estate_card.dart';
import 'package:trip/view/screen/advertisement_panel/hotels/1.hotel_card.dart';
import 'package:trip/view/screen/advertisement_panel/restaurants/1.restaurant_card.dart';
import 'package:trip/view/screen/advertisement_panel/vehicles/1.vehicle_card.dart';

class SavedAdsScreen extends StatelessWidget {
  const SavedAdsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final db = Get.find<DbController>();

    return Scaffold(
      backgroundColor: AppColors.white,

      body: GetBuilder<DbController>(
        init: DbController(),
        builder: (controller) {
          final bookedAds = db.userbooked;
          final estates = db.estates;
          final hotels = db.hotels;
          final cars = db.cars;
          final restaurantsAndCafes = db.restaurantsAndCafes;
          final savedAds = db.userbooked;
          final userId = db.userId.value;

          // Pull-to-refresh wrapper (optional: wire to your controller’s reload)
          return RefreshIndicator(
            color: AppColors.blue,
            onRefresh: () async {
              // await controller.fetchCars();
              await Future.delayed(const Duration(milliseconds: 500));
            },
            child:
                bookedAds.isEmpty
                    ? ListView(
                      children: [
                        SizedBox(height: 120.h),
                        Icon(
                          Icons.warning,
                          size: 48.sp,
                          color: AppColors.brown,
                        ),
                        SizedBox(height: 12.h),
                        Center(
                          child: Text(
                            'empty_saved'.tr(),
                            style: AppTextStyles.p1b,
                          ),
                        ),
                      ],
                    )
                    : ListView.separated(
                      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 24.h),
                      itemCount: bookedAds.length,
                      separatorBuilder: (_, __) => SizedBox(height: 10.h),
                      itemBuilder: (context, index) {
                        final ad = bookedAds[index];
                        final saved = savedAds.firstWhere(
                          (row) =>
                              row['ad_id'] == ad['id'] &&
                              row['user_id'] == userId,
                          orElse: () => {}, //return an empty map
                        );
                        if (ad['type'] == 'hotel') {
                          final hotelAd = hotels.firstWhere(
                            (row) => row['ad_id'] == ad['id'],
                          );
                          final hotel = Hotel(
                            adID: hotelAd['ad_id'],
                            userID: hotelAd['user_id'],
                            photos: hotelAd['photos'],
                            phoneNumbers: hotelAd['phone_numbers'],
                            usPricePerNight: hotelAd['us_price_per_night'],
                            governorate: '${hotelAd['governorate']}'.tr(),
                            address: hotelAd['address'],
                            description: hotelAd['description'],
                            hasParking: hotelAd['has_parking'],
                            hasPool: hotelAd['has_pool'],
                            hasWifi: hotelAd['has_wifi'],
                            hotelName: hotelAd['hotel_name'],
                            starRating: hotelAd['star_rating'].toString(),
                          );

                          return HotelAdCard(hotel: hotel);
                        } else if (ad['type'] == 'restaurant_or_cafe') {
                          final row = restaurantsAndCafes.firstWhere(
                            (row) => row['ad_id'] == ad[index]['id'],
                          );
                          final rcad = RestaurantOrCafe(
                            adID: row['ad_id'],
                            userID: row['user_id'],
                            photos: row['photos'],
                            phoneNumbers: row['phone_numbers'],
                            name: row['name'],
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

                          return RestaurantAndCafesAdCard(ad: rcad);
                        } else if (ad['type'] == 'car') {
                          final row = cars.firstWhere(
                            (row) => row['ad_id'] == ad['id'],
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

                          return VehicleAdCard(
                            car: car,
                            saved: saved.isNotEmpty,
                          );
                        } else if(ad['type']=='estate'){
                          final row = estates.firstWhere(
                            (row) => row['ad_id'] == ad['id'],
                          );
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
                          return EstateAdCard(estate: estate);
                        }
                        return const SizedBox.shrink();
                        // return Text("NO ADs");
                      },
                    ),
          );
        },
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:get/get.dart' hide Trans;
// import 'package:easy_localization/easy_localization.dart';
// import 'package:trip/controller/my_favorite_controller.dart';
// import '../../core/class/handlingrequstveiw.dart';
// import '../../data/models/propertymodel.dart';
// import '../widget/custom_card_handling.dart';
// import '../widget/favorite/custom_card_fav.dart';

// class SavedAdsScreen extends StatelessWidget {
//   const SavedAdsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     MyFavoriteController controller = Get.put(MyFavoriteController());
//     return Scaffold(
//       backgroundColor: const Color(0xF3F3F3E7),
//       body: Obx(() {
//         return HandlingDataViewShimmer(
//           shimmerwidget: CustomCardHandling(),
//           statusRequest: controller.favoriteController.statusRequest.value,
//           widget:
//               controller.favoriteController.data.isEmpty
//                   ? Center(child: Text("empty_favorite".tr()))
//                   : ListView.builder(
//                     padding: const EdgeInsets.all(10),
//                     itemCount: controller.favoriteController.data.length,
//                     itemBuilder: (context, index) {
//                       PropertyModel data =
//                           controller.favoriteController.data[index];
//                       return InkWell(
//                         onTap: () {
//                           controller.goToPropertyDetails(data.slug!);
//                         },
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: CustomFavoriteCard(
//                             cover: data.coverPhoto!,
//                             title: data.title ?? "",
//                             street: data.location?.street ?? "",
//                             location: data.location?.city ?? "",
//                             price: " ${data.price}",
//                             onDeletePressed: () {
//                               controller.deletePropertyFromFav(index, data.id!);
//                             },
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//         );
//       }),
//     );
//   }
// }
