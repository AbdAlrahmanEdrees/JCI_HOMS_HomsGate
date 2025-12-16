import 'package:get/get.dart';
import 'package:trip/data/models/ads_objects/vehicle.dart';
import 'package:trip/data/models/ads_objects/estate.dart';
import 'package:trip/data/models/ads_objects/hotel.dart';
import 'package:trip/data/models/ads_objects/restaurantorcafe.dart';

import 'package:trip/data/temp_todelete/sqldb.dart';

class DbController extends GetxController {
  SqlDb db = SqlDb();
  RxList<Map> cars = <Map>[].obs;
  RxList<Map> filteredSearchCars = <Map>[].obs;
  RxList<Map> estates = <Map>[].obs;
  RxList<Map> userAds = <Map>[].obs;
  RxList<Map> userbooked = <Map>[].obs;
  RxList<Map> ads = <Map>[].obs;
  RxInt userId = 0.obs;
  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    selectCars();
    selectEstates();
    selectHotels();
    selectRestaurantsAndCafes();
    selectUserAds();
    selectUserBooked();
    // selectAllAds();
  }

  //stupid and just temp to run bookings & mine pages
  void toggleUserID() {
    if (userId.value == 0)
      userId.value = 1;
    else
      userId.value = 0;
  }

  ////////////////////////////    User Ads        ///////////////////////////////////
  // Future<void> selectAllAds() async {
  //   List<Map> response = await db.select('''SELECT * FROM ads
  //   WHERE publisher_id=${userId.value}''');
  //   ads.value = response;
  // }

  ////////////////////////////    User Ads        ///////////////////////////////////
  Future<void> selectUserAds() async {
    List<Map> response = await db.select('''SELECT * FROM ads
    WHERE publisher_id=${userId.value}''');
    userAds.value = response;
  }

  Future<void> deleteUserAd(int adId) async {
    await db.delete('''DELETE FROM ads
    WHERE id=$adId''');
    selectUserAds();
    selectCars();
    selectHotels();
    selectEstates();
    selectRestaurantsAndCafes();
    // STUPID  I KONW
  }

  ////////////////////////////////// User's booked ads  /////////////////////////////////////
  ///
  Future<void> selectUserBooked() async {
    List<Map> response = await db.select('''SELECT * FROM booked
    WHERE user_id=${userId.value}''');
    userbooked.value = response;
  }

  Future<void> bookAd(int adId) async {
    await SqlDb().insert('''
    INSERT INTO booked 
    VALUES (${userId.value},$adId)
  ''');
    selectUserAds();
    selectUserBooked();
  }

  Future<void> removeBookAd(int adId) async {
    await SqlDb().delete('''
    DELETE FROM booked 
    WHERE user_id=${userId.value}
       AND   ad_id=$adId
  ''');
    selectUserAds();
    selectUserBooked();
  }

  ////////////////////////////    cars        ///////////////////////////////////
  Future<void> selectCars() async {
    List<Map> response = await db.select('''SELECT * FROM cars''');
    cars.value = response;
    selectUserAds();
    selectUserBooked();
  }

  Future<void> deleteCarAd(int adID) async {
    await db.delete('''DELETE FROM cars
    WHERE id=$adID''');
  }

  // ============================================================================================
  // ================================   CAR   ===================================================
  Future<void> insertCarAd(Vehicle car) async {
    int adId = await SqlDb().insert('''
    INSERT INTO ads (publisher_id, num_of_book_marked, type)
    VALUES (${car.userID ?? userId.value}, 10, 'car')
  ''');

    car.adID = adId;
    await db.insert('''INSERT INTO cars (
      ad_id, user_id, phone_numbers, photos, for_sale, type_of_rent,
      us_price, type, brand, model, transmission, kilometers_traveled,
      year, governorate, address
    ) VALUES (
      ${car.adID}, ${car.userID ?? userId.value}, '${car.phoneNumbers}', '${car.photos}',
      ${car.forSale}, '${car.typeOfRent}', ${car.usPrice}, '${car.type}',
      '${car.brand}', '${car.model}', '${car.transmission}',
      ${car.kilometersTraveled}, ${car.year}, '${car.governorate}',
      '${car.address}')''');
    selectCars();
  }

  Future<void> editCarAd(Vehicle car) async {
    await db.update('''UPDATE cars 
    SET phone_numbers='${car.phoneNumbers}',
        photos='${car.photos}',
        type='${car.type}',
        brand='${car.brand}',
        model='${car.model}',
        for_sale=${car.forSale},
        transmission='${car.transmission}',
        kilometers_traveled = ${car.kilometersTraveled},
        year = ${car.year},
        type_of_rent = '${car.typeOfRent}',
        us_price=${car.usPrice},
        governorate='${car.governorate}',
        address = '${car.address}'
    WHERE ad_id=${car.adID}''');
    Get.back();
    selectCars();
  }

  Future<void> carsFilteredSearch({
    required String governorate,
    required String address,
    required int forSale,
    required String type,
    required String brand,
    required String model,
    required String transmission,
    required bool isPriceSearchSliderEnabled,
    required int minPrice,
    required int maxPrice,
    String typeOfRent = '',
  }) async {
    String sql = "SELECT * FROM cars WHERE for_sale = $forSale";

    // Optional filters
    if (governorate.isNotEmpty) {
      sql += " AND governorate = '$governorate'";
    }

    if (address.isNotEmpty) {
      sql += " AND address LIKE '%$address%'";
    }

    if (type.isNotEmpty) {
      sql += " AND type = '$type'";
    }

    if (brand.isNotEmpty) {
      sql += " AND brand = '$brand'";
    }

    if (model.isNotEmpty) {
      sql += " AND model = '$model'";
    }

    if (transmission.isNotEmpty) {
      sql += " AND transmission = '$transmission'";
    }

    if (forSale == 0 && typeOfRent.isNotEmpty) {
      sql += " AND type_of_rent = '$typeOfRent'";
    }

    if (isPriceSearchSliderEnabled) {
      if (forSale == 1) {
        sql += " AND us_price BETWEEN $minPrice AND $maxPrice";
      } else {
        sql +=
            " AND us_price BETWEEN $minPrice AND $maxPrice"; // Adjust if you later split rent prices by type
      }
    }

    // Execute and store results
    // filteredSearchCars = await db.select(sql);
    cars.value = await db.select(sql);
  }

  // ============================================================================================
  // ================================   Estate   ===================================================

  Future<void> selectEstates() async {
    List<Map> response = await db.select("SELECT * FROM estates");
    estates.value = response;
    selectUserAds();
    selectUserBooked();
  }

  Future<void> insertEstateAd(Estate estate) async {
    int adId = await SqlDb().insert('''
    INSERT INTO ads (publisher_id, num_of_book_marked, type)
    VALUES (${estate.userID ?? userId.value}, 10, 'estate')
  ''');

    estate.adID = adId;
    await db.insert('''INSERT INTO estates (
    ad_id, user_id, phone_numbers, photos, for_sale, type_of_rent,
    us_price, type, space, num_of_rooms, num_of_floors, floor_number,
    clothing, green_deed, has_wifi, has_solar_panels, governorate,
    address, description
  ) VALUES (
    ${estate.adID}, ${estate.userID ?? userId.value}, '${estate.phoneNumbers}', '${estate.photos}',
    ${estate.forSale}, '${estate.typeOfRent}', ${estate.usPrice}, '${estate.type}',
    ${estate.space}, ${estate.numOfRooms}, ${estate.numOfFloors}, ${estate.floorNumber},
    '${estate.clothing}', ${estate.greenDeed}, ${estate.hasWifi}, ${estate.hasSolarPanels},
    '${estate.governorate}', '${estate.address}', '${estate.description}'
  )''');
    selectEstates();
  }

  Future<void> deleteEstateAd(int adID) async {
    await db.delete("DELETE FROM estates WHERE ad_id=$adID");
    selectEstates();
  }

  RxList<Map> filteredSearchEstates = <Map>[].obs;

  Future<void> estatesFilteredSearch({
    required String governorate,
    required String address,
    required String type,
    required int forSale,
    required String rentType,
    required int hasSolarPanels,
    required int greenDeed,
    required bool isPriceSearchSliderEnabled,
    required int minPrice,
    required int maxPrice,
    // required int minRooms,
    // required int maxRooms,
    // required int minSpace,
    // required int maxSpace,
  }) async {
    String sql = "SELECT * FROM estates WHERE 1=1";

    if (governorate.isNotEmpty) {
      sql += " AND governorate = '$governorate'";
    }

    if (address.isNotEmpty) {
      sql += " AND address LIKE '%$address%'";
    }

    if (type.isNotEmpty) {
      sql += " AND type = '$type'";
    }

    // if (hasWifi) {
    //   sql += " AND has_wifi = 1";
    // }

    // if (hasSolarPanels) {
    //   sql += " AND has_solar_panels = 1";
    // }

    if (greenDeed == 1) {
      sql += " AND green_deed = 1";
    }

    if (isPriceSearchSliderEnabled) {
      sql += " AND us_price BETWEEN $minPrice AND $maxPrice";
    }

    // sql += " AND num_of_rooms BETWEEN $minRooms AND $maxRooms";
    // sql += " AND space BETWEEN $minSpace AND $maxSpace";

    filteredSearchEstates.value = await db.select(sql);
    estates.value = await db.select(sql);
  }

  // ============================================================================================
  // ================================   Restaurant and Cafe   ===================================================
  RxList<Map> restaurantsAndCafes = <Map>[].obs;

  Future<void> selectRestaurantsAndCafes() async {
    List<Map> response = await db.select("SELECT * FROM restaurants_and_cafes");
    restaurantsAndCafes.value = response;
    selectUserAds();
    selectUserBooked();
  }

  Future<void> insertRestaurantOrCafeAd(RestaurantOrCafe ad) async {
    int adId = await SqlDb().insert('''
    INSERT INTO ads (publisher_id, num_of_book_marked, type)
    VALUES (${ad.userID ?? userId.value}, 10, 'restaurant_or_cafe')
  ''');

    ad.adID = adId;
    await db.insert('''INSERT INTO restaurants_and_cafes (
    ad_id, user_id, phone_numbers, photos,type, name, us_price,
    open_hour, close_hour, am_or_pm_open, am_or_pm_close,
    has_delivery, has_electricity, has_wifi, governorate,
    address, description
  ) VALUES (
    ${ad.adID}, ${ad.userID ?? userId.value}, '${ad.phoneNumbers}', '${ad.photos}','${ad.type}', '${ad.name}',
    ${ad.usPrice}, '${ad.openHour}', '${ad.closeHour}', '${ad.amOrPmOpen}', '${ad.amOrPmClose}',
    ${ad.hasDelivery}, ${ad.hasElectricity}, ${ad.hasWifi}, '${ad.governorate}',
    '${ad.address}', '${ad.menuAndDescription}'
  )''');
    selectRestaurantsAndCafes();
  }

  Future<void> deleteRestaurantOrCafeAd(int adID) async {
    await db.delete("DELETE FROM restaurants_and_cafes WHERE ad_id=$adID");
    selectRestaurantsAndCafes();
  }

  RxList<Map> filteredSearchRestaurantsAndCafes = <Map>[].obs;

  Future<void> restaurantsAndCafesFilteredSearch({
    required String governorate,
    // required String address,
    required String type,
    required bool hasDelivery,
    required bool hasElectricity,
    required bool hasWifi,
    required bool isPriceSearchSliderEnabled,
    required int minPrice,
    required int maxPrice,
  }) async {
    String sql = "SELECT * FROM restaurants_and_cafes WHERE 1=1";

    // Optional filters
    if (governorate.isNotEmpty) {
      sql += " AND governorate = '$governorate'";
    }

    // if (address.isNotEmpty) {
    //   sql += " AND address LIKE '%$address%'";
    // }

    if (type.isNotEmpty) {
      sql += " AND type LIKE '%$type%'";
    }

    if (hasDelivery) {
      sql += " AND has_delivery = 1";
    }

    if (hasElectricity) {
      sql += " AND has_electricity = 1";
    }

    if (hasWifi) {
      sql += " AND has_wifi = 1";
    }

    if (isPriceSearchSliderEnabled) {
      sql += " AND us_price BETWEEN $minPrice AND $maxPrice";
    }

    // Execute and store results
    filteredSearchRestaurantsAndCafes.value = await db.select(sql);
    restaurantsAndCafes.value = await db.select(sql);
  }

  // ============================================================================================
  // ================================   Hotel   ===================================================
  RxList<Map> hotels = <Map>[].obs;

  Future<void> selectHotels() async {
    List<Map> response = await db.select("SELECT * FROM hotels");
    hotels.value = response;
    selectUserAds();
    selectUserBooked();
  }

  Future<void> insertHotelAd(Hotel hotel) async {
    int adId = await SqlDb().insert('''
    INSERT INTO ads (publisher_id, num_of_book_marked, type)
    VALUES (${hotel.userID ?? userId.value}, 10, 'hotel')
  ''');

    hotel.adID = adId;
    await db.insert('''INSERT INTO hotels (
    ad_id, user_id, phone_numbers, photos, hotel_name, star_rating,
    us_price_per_night, has_wifi, has_parking, has_pool,
    governorate, address, description
  ) VALUES (
    ${hotel.adID}, ${hotel.userID ?? userId.value}, '${hotel.phoneNumbers}', '${hotel.photos}',
    '${hotel.hotelName}', ${hotel.starRating}, ${hotel.usPricePerNight},
    ${hotel.hasWifi}, ${hotel.hasParking}, ${hotel.hasPool},
    '${hotel.governorate}', '${hotel.address}', '${hotel.description}'
  )''');
    selectHotels();
  }

  Future<void> deleteHotelAd(int adID) async {
    await db.delete("DELETE FROM hotels WHERE ad_id=$adID");
    selectHotels();
  }

  RxList<Map> filteredSearchHotels = <Map>[].obs;

  Future<void> hotelsFilteredSearch({
    required String governorate,
    required String address,
    required String hotelName,
    required bool hasWifi,
    required bool hasParking,
    required bool hasPool,
    required bool isPriceSearchSliderEnabled,
    required int minPrice,
    required int maxPrice,
    required double minRating,
    required double maxRating,
  }) async {
    String sql = "SELECT * FROM hotels WHERE 1=1";

    if (governorate.isNotEmpty) {
      sql += " AND governorate = '$governorate'";
    }

    if (address.isNotEmpty) {
      sql += " AND address LIKE '%$address%'";
    }

    if (hotelName.isNotEmpty) {
      sql += " AND hotel_name LIKE '%$hotelName%'";
    }

    if (hasWifi) {
      sql += " AND has_wifi = 1";
    }

    if (hasParking) {
      sql += " AND has_parking = 1";
    }

    if (hasPool) {
      sql += " AND has_pool = 1";
    }

    if (isPriceSearchSliderEnabled) {
      sql += " AND us_price_per_night BETWEEN $minPrice AND $maxPrice";
    }

    sql += " AND star_rating BETWEEN $minRating AND $maxRating";

    filteredSearchHotels.value = await db.select(sql);
  }
}
