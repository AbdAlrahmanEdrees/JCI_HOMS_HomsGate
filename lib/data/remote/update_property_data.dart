
import '../../../core/class/crud.dart';
import '../../core/constanat/apilink.dart';


class UpdateUserPropertyData {
  Crud crud;

  UpdateUserPropertyData(this.crud);

  UpdatePropertyDeatilsData

      (

      String propertyType,String phoneNumber,String title, String description, String city,
      String region, String street , String propertyNumber , String price , String plotArea , String totalFloors ,
      String floorNumber , String bedrooms ,String bathrooms , String kitchens , String livingRooms ,
      String propertyStatus, bool elevator , bool pool , bool solarPanels , String furnishing , String direction ,
      String totalRooms , String rentType , String covering , String token,String slug) async {
    var response =
    await crud.patchData(linkurl: "${ApiLink.updateproperty}$slug/",Token: token,data: {
      "property_type":propertyType,
      "property_status":propertyStatus,
      "elevator":elevator.toString(),
      "pool":pool.toString(),
      "solar_panels":solarPanels.toString(),
      "furnishing":furnishing,
      "direction":direction,
      "total_rooms":totalRooms,
      "rent_type":"شهري",
      "covering":"عادي",
      "phone_number":phoneNumber,
      "title":title,
      "description":description,
      'location.city':city,
      'location.street':street,
      'location.region':region,
      "property_number":propertyNumber,
      "price":price,
      "plot_area":plotArea,
      "total_floors":totalFloors,
      "floor_number":"2",
      "bedrooms":bedrooms,
      "bathrooms":bathrooms,
      "kitchens":kitchens,
      "living_rooms":livingRooms
    },
    );
    return response.fold((l) => l, (r) => r);
  }
}
