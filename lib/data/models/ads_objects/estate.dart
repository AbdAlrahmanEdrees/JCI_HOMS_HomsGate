class Estate {
  int? adID;
  final int? userID;
  final String photos; // separated with ','
  final String phoneNumbers;
  final int forSale; // 1: for sale, 0: for rent
  final String typeOfRent;
  final int usPrice;
  final String type; // house, flat, villa, office, a piece of land ...
  final int space;
  final int numOfRooms;
  final int numOfFloors;
  final int floorNumber;
  final String clothing; // cladding/ no cladding, mid cladding, full cladding
  final int greenDeed; // 1: yes, 0: no
  final int hasWifi; // 1: yes, 0: no
  final int hasSolarPanels; // 1: yes, 0: no
  final String governorate;
  final String address;
  final String description;

  Estate({
    required this.adID,
    this.userID,
    required this.photos,
    required this.phoneNumbers,
    required this.forSale,
    required this.typeOfRent,
    this.usPrice = 0,
    required this.type,
    required this.space,
    required this.numOfRooms,
    required this.numOfFloors,
    required this.floorNumber,
    required this.clothing,
    required this.greenDeed,
    required this.hasWifi,
    required this.hasSolarPanels,
    required this.governorate,
    required this.address,
    required this.description,
  });
}
