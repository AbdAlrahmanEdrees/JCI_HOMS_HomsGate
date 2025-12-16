import 'package:flutter/widgets.dart';
import 'package:trip/data/models/dropdownStarsmodel.dart';

import '../../data/models/dropdownmodel.dart';
import 'package:easy_localization/easy_localization.dart';

class DropDownItems {
  List<DropDownModel> typeOfAd = [
    DropDownModel(text: "vehicle".tr(), value: "vehicle"),
    DropDownModel(text: "hotel".tr(), value: "hotel"),
    DropDownModel(text: "restaurant_or_cafe".tr(), value: "restaurant_or_cafe"),
    DropDownModel(text: "estate".tr(), value: "estate"),
  ];

  List<DropDownModel> restaurantOrCafe = [
    DropDownModel(text: "cafe".tr(), value: "cafe"),
    DropDownModel(text: "restaurant".tr(), value: "restaurant"),
  ];

  List<DropDownModel> typeOfVehicle = [
    DropDownModel(text: "car".tr(), value: "car"),
    DropDownModel(text: "van".tr(), value: "van"),
    DropDownModel(text: "bus".tr(), value: "bus"),
    DropDownModel(text: "truck".tr(), value: "truck"),
    DropDownModel(text: "pickup".tr(), value: "pickup"),
    DropDownModel(text: "minibus".tr(), value: "minibus"),
    DropDownModel(text: "suv".tr(), value: "suv"),
    DropDownModel(text: "motorcycle".tr(), value: "motorcycle"),
    // DropDownModel(text: "add_another_type".tr(), value: "add_another_type"),
  ];
  // Popular car brands (A→Z). Display text is human-friendly; value stays a stable slug.
  List<DropDownModel> carBrands = [
    DropDownModel(text: "Acura", value: "acura"),
    DropDownModel(text: "Alfa Romeo", value: "alfa_romeo"),
    DropDownModel(text: "Aston Martin", value: "aston_martin"),
    DropDownModel(text: "Audi", value: "audi"),
    DropDownModel(text: "Bentley", value: "bentley"),
    DropDownModel(text: "BMW", value: "bmw"),
    DropDownModel(text: "Bugatti", value: "bugatti"),
    DropDownModel(text: "Buick", value: "buick"),
    DropDownModel(text: "BYD", value: "byd"),
    DropDownModel(text: "Cadillac", value: "cadillac"),
    DropDownModel(text: "Chevrolet", value: "chevrolet"),
    DropDownModel(text: "Chrysler", value: "chrysler"),
    DropDownModel(text: "Citroen", value: "citroen"),
    DropDownModel(text: "Cupra", value: "cupra"),
    DropDownModel(text: "Dacia", value: "dacia"),
    DropDownModel(text: "Daihatsu", value: "daihatsu"),
    DropDownModel(text: "Dodge", value: "dodge"),
    DropDownModel(text: "DS Automobiles", value: "ds_automobiles"),
    DropDownModel(text: "Ferrari", value: "ferrari"),
    DropDownModel(text: "Fiat", value: "fiat"),
    DropDownModel(text: "Ford", value: "ford"),
    DropDownModel(text: "Geely", value: "geely"),
    DropDownModel(text: "Genesis", value: "genesis"),
    DropDownModel(text: "GMC", value: "gmc"),
    DropDownModel(text: "Great Wall", value: "great_wall"),
    DropDownModel(text: "Haval", value: "haval"),
    DropDownModel(text: "Honda", value: "honda"),
    DropDownModel(text: "Hyundai", value: "hyundai"),
    DropDownModel(text: "Infiniti", value: "infiniti"),
    DropDownModel(text: "Isuzu", value: "isuzu"),
    DropDownModel(text: "Jaguar", value: "jaguar"),
    DropDownModel(text: "Jeep", value: "jeep"),
    DropDownModel(text: "Kia", value: "kia"),
    DropDownModel(text: "Koenigsegg", value: "koenigsegg"),
    DropDownModel(text: "Lada", value: "lada"),
    DropDownModel(text: "Lamborghini", value: "lamborghini"),
    DropDownModel(text: "Land Rover", value: "land_rover"),
    DropDownModel(text: "Lexus", value: "lexus"),
    DropDownModel(text: "Lincoln", value: "lincoln"),
    DropDownModel(text: "Lotus", value: "lotus"),
    DropDownModel(text: "Lucid", value: "lucid"),
    DropDownModel(text: "Maserati", value: "maserati"),
    DropDownModel(text: "Mazda", value: "mazda"),
    DropDownModel(text: "McLaren", value: "mclaren"),
    DropDownModel(text: "Mercedes-Benz", value: "mercedes_benz"),
    DropDownModel(text: "MG", value: "mg"),
    DropDownModel(text: "MINI", value: "mini"),
    DropDownModel(text: "Mitsubishi", value: "mitsubishi"),
    DropDownModel(text: "NIO", value: "nio"),
    DropDownModel(text: "Nissan", value: "nissan"),
    DropDownModel(text: "Opel", value: "opel"),
    DropDownModel(text: "Peugeot", value: "peugeot"),
    DropDownModel(text: "Polestar", value: "polestar"),
    DropDownModel(text: "Proton", value: "proton"),
    DropDownModel(text: "Porsche", value: "porsche"),
    DropDownModel(text: "Ram", value: "ram"),
    DropDownModel(text: "Renault", value: "renault"),
    DropDownModel(text: "Rivian", value: "rivian"),
    DropDownModel(text: "Rolls-Royce", value: "rolls_royce"),
    DropDownModel(text: "SEAT", value: "seat"),
    DropDownModel(text: "Skoda", value: "skoda"),
    DropDownModel(text: "Smart", value: "smart"),
    DropDownModel(text: "SsangYong", value: "ssangyong"),
    DropDownModel(text: "Subaru", value: "subaru"),
    DropDownModel(text: "Suzuki", value: "suzuki"),
    DropDownModel(text: "Tata", value: "tata"),
    DropDownModel(text: "Tesla", value: "tesla"),
    DropDownModel(text: "Toyota", value: "toyota"),
    DropDownModel(text: "Vauxhall", value: "vauxhall"),
    DropDownModel(text: "VinFast", value: "vinfast"),
    DropDownModel(text: "Volkswagen", value: "volkswagen"),
    DropDownModel(text: "Volvo", value: "volvo"),
    DropDownModel(text: "Wuling", value: "wuling"),
    DropDownModel(text: "XPeng", value: "xpeng"),
  ];
  List<DropDownModel> carTransmissions = [
    DropDownModel(text: "automatic".tr(), value: "automatic"),
    DropDownModel(text: "manual".tr(), value: "manual"),
  ];
  List<DropDownModel> typeOfRent = [
    DropDownModel(text: "rent_by_kilometer".tr(), value: "rent_by_kilometer"),
    DropDownModel(text: "hourly".tr(), value: "hourly"),
    DropDownModel(text: "daily".tr(), value: "daily"),
    DropDownModel(text: "weekly".tr(), value: "weekly"),
    DropDownModel(text: "monthly".tr(), value: "monthly"),
    DropDownModel(text: "yearly".tr(), value: "yearly"),
  ];

  List<DropDownModel> typeOfEstate = [
    // DropDownModel(text: "hotel".tr(), value: "hotel"),
    DropDownModel(text: "flat".tr(), value: "flat"),
    DropDownModel(text: "house".tr(), value: "house"),
    DropDownModel(text: "villa".tr(), value: "villa"),
    DropDownModel(text: "holiday_villa".tr(), value: "holiday_villa"),
    DropDownModel(text: "chalet".tr(), value: "chalet"),
    DropDownModel(text: "land".tr(), value: "land"),
    DropDownModel(text: "office".tr(), value: "office"),
    DropDownModel(text: "store".tr(), value: "store"),
    DropDownModel(text: "building".tr(), value: "building"),
    DropDownModel(text: "other".tr(), value: "other"),
  ];

  List<DropDownModel> floor = [
    DropDownModel(text: "choose".tr(), value: "choose"),
    DropDownModel(text: "basement_2".tr(), value: "basement_2"),
    DropDownModel(text: "basement_1".tr(), value: "basement_1"),
    DropDownModel(text: "ground_floor".tr(), value: "ground_floor"),
    DropDownModel(text: "floor_1".tr(), value: "floor_1"),
    DropDownModel(text: "floor_2".tr(), value: "floor_2"),
    DropDownModel(text: "floor_3".tr(), value: "floor_3"),
    DropDownModel(text: "floor_4".tr(), value: "floor_4"),
    DropDownModel(text: "floor_5".tr(), value: "floor_5"),
    DropDownModel(text: "floor_6".tr(), value: "floor_6"),
    DropDownModel(text: "floor_7".tr(), value: "floor_7"),
    DropDownModel(text: "floor_8".tr(), value: "floor_8"),
    DropDownModel(text: "floor_9".tr(), value: "floor_9"),
    DropDownModel(text: "floor_10".tr(), value: "floor_10"),
    DropDownModel(text: "floor_11".tr(), value: "floor_11"),
    DropDownModel(text: "floor_12".tr(), value: "floor_12"),
  ];

  List<DropDownModel> prpertyFounder = [
    DropDownModel(text: "green_deed".tr(), value: "green_deed"),
    DropDownModel(
      text: "final_sales_contract".tr(),
      value: "final_sales_contract",
    ),
    DropDownModel(text: "court_ruling".tr(), value: "court_ruling"),
    DropDownModel(text: "notarized_agency".tr(), value: "notarized_agency"),
    DropDownModel(text: "shared_deed".tr(), value: "shared_deed"),
    DropDownModel(text: "agricultural_deed".tr(), value: "agricultural_deed"),
    DropDownModel(text: "housing_deed".tr(), value: "housing_deed"),
    DropDownModel(text: "evacuation_right".tr(), value: "evacuation_right"),
  ];

  List<DropDownModel> ownertype = [
    DropDownModel(text: "owner".tr(), value: "owner"),
    DropDownModel(text: "trader".tr(), value: "trader"),
  ];

  List<DropDownModel> clothingLevel = [
    // DropDownModel(text: "choose".tr(), value: "choose"),
    DropDownModel(text: "unfurnished".tr(), value: "unfurnished"),
    DropDownModel(text: "semi_furnished".tr(), value: "semi_furnished"),
    DropDownModel(text: "furnished".tr(), value: "furnished"),
  ];

  List<DropDownModel> direction = [
    DropDownModel(text: "west".tr(), value: "west"),
    DropDownModel(text: "east".tr(), value: "east"),
    DropDownModel(text: "north".tr(), value: "north"),
    DropDownModel(text: "south".tr(), value: "south"),
    DropDownModel(text: "northeast".tr(), value: "northeast"),
    DropDownModel(text: "northwest".tr(), value: "northwest"),
    DropDownModel(text: "southeast".tr(), value: "southeast"),
    DropDownModel(text: "southwest".tr(), value: "southwest"),
  ];

  List<DropDownModel> condition = [
    DropDownModel(text: "choose".tr(), value: "choose"),
    DropDownModel(text: "standard".tr(), value: "standard"),
    DropDownModel(text: "super".tr(), value: "super"),
    DropDownModel(text: "good".tr(), value: "good"),
    DropDownModel(text: "very_good".tr(), value: "very_good"),
    DropDownModel(text: "excellent".tr(), value: "excellent"),
  ];
  List<DropDownStarsModel> stars = [
    DropDownStarsModel(
      stars: List.generate(1, (v) {
        return Image.asset('Assets/app_icons/star-24.png', height: 25);
      }),
      value: '1',
    ),
    DropDownStarsModel(
      stars: List.generate(2, (v) {
        return Image.asset('Assets/app_icons/star-24.png', height: 25);
      }),
      value: '2',
    ),
    DropDownStarsModel(
      stars: List.generate(3, (v) {
        return Image.asset('Assets/app_icons/star-24.png', height: 25);
      }),
      value: '3',
    ),
    DropDownStarsModel(
      stars: List.generate(4, (v) {
        return Image.asset('Assets/app_icons/star-24.png', height: 25);
      }),
      value: '4',
    ),
    DropDownStarsModel(
      stars: List.generate(5, (v) {
        return Image.asset('Assets/app_icons/star-24.png', height: 25);
      }),
      value: '5',
    ),
  ];

  List<DropDownModel> governorate = [
    DropDownModel(text: "all_around_syria".tr(), value: "all_around_syria"),
    DropDownModel(text: "damascus".tr(), value: "damascus"),
    DropDownModel(text: "rural_damascus".tr(), value: "rural_damascus"),
    DropDownModel(text: "latakia".tr(), value: "latakia"),
    DropDownModel(text: "rural_latakia".tr(), value: "rural_latakia"),
    DropDownModel(text: "aleppo".tr(), value: "aleppo"),
    DropDownModel(text: "rural_aleppo".tr(), value: "rural_aleppo"),
    DropDownModel(text: "homs".tr(), value: "homs"),
    DropDownModel(text: "rural_homs".tr(), value: "rural_homs"),
    DropDownModel(text: "hama".tr(), value: "hama"),
    DropDownModel(text: "rural_hama".tr(), value: "rural_hama"),
    DropDownModel(text: "tartous".tr(), value: "tartous"),
    DropDownModel(text: "rural_tartous".tr(), value: "rural_tartous"),
    DropDownModel(text: "as_suwayda".tr(), value: "as_suwayda"),
    DropDownModel(text: "rural_as_suwayda".tr(), value: "rural_as_suwayda"),
    DropDownModel(text: "deir_ez_zor".tr(), value: "deir_ez_zor"),
    DropDownModel(text: "rural_deir_ez_zor".tr(), value: "rural_deir_ez_zor"),
    DropDownModel(text: "daraa".tr(), value: "daraa"),
    DropDownModel(text: "rural_daraa".tr(), value: "rural_daraa"),
    DropDownModel(text: "hasakah".tr(), value: "hasakah"),
    DropDownModel(text: "rural_hasakah".tr(), value: "rural_hasakah"),
    DropDownModel(text: "quneitra".tr(), value: "quneitra"),
    DropDownModel(text: "rural_quneitra".tr(), value: "rural_quneitra"),
  ];

  List<DropDownModel> rentalPeriod = [
    DropDownModel(text: "daily".tr(), value: "daily"),
    DropDownModel(text: "monthly".tr(), value: "monthly"),
    DropDownModel(text: "yearly".tr(), value: "yearly"),
  ];
}
