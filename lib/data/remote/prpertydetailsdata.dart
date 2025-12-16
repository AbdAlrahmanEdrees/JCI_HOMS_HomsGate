// import 'dart:io';

// import 'package:trip/core/constanat/staticdata.dart';
// import '../../../core/class/crud.dart';
// import '../../core/constanat/apilink.dart';


// class PropertyDetailsData {
//   Crud crud;

//   PropertyDetailsData(this.crud);

//   AddPropertyDetialsData

//   (

//   String propertyType,File cover,String phoneNumber,String title, String description, String city,
//       String region, String street , String propertyNumber , String price , String plotArea , String totalFloors ,
//       String floorNumber , String bedrooms ,String bathrooms , String kitchens , String livingRooms ,
//       String propertyStatus, bool elevator , bool pool , bool solarPanels , String furnishing , String direction ,
//       String totalRooms , String rentType , String covering , String token) async {
//   print(Staticdata.token);
//   var response =
//   await crud.postRequestWithFile(ApiLink.addproperty,token,{
//     "property_type":propertyType,
//     "property_status":propertyStatus,
//     "elevator":elevator.toString(),
//     "pool":pool.toString(),
//     "solar_panels":solarPanels.toString(),
//     "furnishing":furnishing,
//     "direction":direction,
//     "total_rooms":totalRooms,
//     "rent_type":"شهري",
//     "covering":"عادي",
//     "phone_number":phoneNumber,
//     "title":title,
//     "description":description,
//     'location.city':city,
//     'location.street':street,
//     'location.region':region,
//     "property_number":propertyNumber,
//     "price":price,
//     "plot_area":plotArea,
//     "total_floors":totalFloors,
//     "floor_number":"2",
//     "bedrooms":bedrooms,
//     "bathrooms":bathrooms,
//     "kitchens":kitchens,
//     "living_rooms":livingRooms
//   },cover,"cover_photo"
//   );
//   return response.fold((l) => l, (r) => r);
//   }

// }
