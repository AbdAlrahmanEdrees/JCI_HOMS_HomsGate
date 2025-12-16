

import '../../../core/class/crud.dart';
import '../../core/constanat/apilink.dart';


class FilteredSearchData {
  Crud crud;

  FilteredSearchData(this.crud);

  getPropertyData(
      {String? token,
      String? property_type,
      String? property_status,
      String? covering,
      String? rent_type,
      String? city,
      String? floor_number,
      String? furnishing,
      String? price_lt,
      String? price_gt}) async {
    String link="${ApiLink.property}?floor_number=$floor_number&=$property_status&property_status=$property_status&covering=$covering&rent_type=$rent_type&city=$city&furnishing=$furnishing&price_lt=$price_lt&price_gt=$price_gt";
    var response =
    await crud.getData(linkurl: link,
    );
    return response.fold((l) => l, (r) => r);
  }
}
