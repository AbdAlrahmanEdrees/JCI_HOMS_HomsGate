class Vehicle {
  int? adID;
  final int? userID;
  final String photos; // separated with ','
  final String phoneNumbers;
  final int forSale; // 1: for sale,  0: for rent
  final String typeOfRent;
  final int usPrice;
  final String type; // car, van, suv, motorcycle...
  final String brand;
  final String model;
  final String transmission; //automatic / manual
  final int kilometersTraveled;
  final int year;
  final String governorate;
  final String address;
  Vehicle({
    required this.adID,
    this.userID,
    required this.photos,
    required this.phoneNumbers,
    required this.forSale,
    required this.typeOfRent,
    this.usPrice = 0,
    required this.type,
    required this.brand,
    required this.model,
    required this.transmission,
    required this.kilometersTraveled,
    required this.year,
    required this.governorate,
    required this.address,
  });
}

// enum Transmission { automatic, manual }

// enum CarRentageType { perKilometer, daily, weekly, montly }
