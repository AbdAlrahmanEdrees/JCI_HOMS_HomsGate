class Hotel {
  int? adID; // primary key, auto-increment
  int? userID; // NOT NULL
  final String photos; // separated with ','
  final String phoneNumbers; // separated with ','
  final String hotelName;
  final String starRating; // DECIMAL(2,1)
  final int usPricePerNight;
  final int hasWifi;    // 1 = yes, 0 = no, -404 = undefined
  final int hasParking; // 1 = yes, 0 = no, -404 = undefined
  final int hasPool;    // 1 = yes, 0 = no, -404 = undefined
  final String governorate;
  final String address;
  final String description;

  Hotel({
    this.adID,
    this.userID,
    required this.photos,// = '',
    required this.phoneNumbers,// = '',
    required this.hotelName,// = '',
    required this.starRating ,//= -404.0,
    required this.usPricePerNight ,//= -404,
    required this.hasWifi,// = -404,
    required this.hasParking ,//= -404,
    required this.hasPool ,//= -404,
    required this.governorate,// = '',
    required this.address ,//= '',
    required this.description ,//= '',
  });

  /// Convert a Map (from SQLite) to a Hotel object
  factory Hotel.fromMap(Map<String, dynamic> map) {
    return Hotel(
      adID: map['ad_id'],
      userID: map['user_id'],
      photos: map['photos'] ?? '',
      phoneNumbers: map['phone_numbers'] ?? '',
      hotelName: map['hotel_name'] ?? '',
      // starRating: (map['star_rating'] as num?)?.toDouble() ?? -404.0,
      starRating: map['star_rating'] ?? '',
      usPricePerNight: map['us_price_per_night'] ?? -404,
      hasWifi: map['has_wifi'] ?? -404,
      hasParking: map['has_parking'] ?? -404,
      hasPool: map['has_pool'] ?? -404,
      governorate: map['governorate'] ?? '',
      address: map['address'] ?? '',
      description: map['description'] ?? '',
    );
  }

  /// Convert a Hotel object to a Map (for SQLite)
  Map<String, dynamic> toMap() {
    return {
      'ad_id': adID,
      'user_id': userID,
      'photos': photos,
      'phone_numbers': phoneNumbers,
      'hotel_name': hotelName,
      'star_rating': starRating,
      'us_price_per_night': usPricePerNight,
      'has_wifi': hasWifi,
      'has_parking': hasParking,
      'has_pool': hasPool,
      'governorate': governorate,
      'address': address,
      'description': description,
    };
  }
}
