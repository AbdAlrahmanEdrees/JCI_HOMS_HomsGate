class RestaurantOrCafe {
  int? adID;
  final int? userID;
  final String photos; // separated with ','
  final String phoneNumbers;  // separated with ','
  final String type;
  final String name;
  final int usPrice;
  final String openHour;
  final String closeHour;
  final String amOrPmOpen;
  final String amOrPmClose;
  final int hasDelivery; // 1: yes, 0: no
  final int hasElectricity; // 1: yes, 0: no
  final int hasWifi; // 1: yes, 0: no
  final String governorate;
  final String address;
  final String menuAndDescription;

  RestaurantOrCafe({
    required this.adID,
    this.userID,
    required this.photos,
    required this.phoneNumbers,
    required this.type,
    required this.name,
    required this.usPrice,
    required this.openHour,
    required this.closeHour,
    required this.amOrPmOpen,
    required this.amOrPmClose,
    required this.hasDelivery,
    required this.hasElectricity,
    required this.hasWifi,
    required this.governorate,
    required this.address,
    required this.menuAndDescription,
  });
}
