

import '../../../core/class/crud.dart';
import '../../core/constanat/apilink.dart';


class PropertyData {
  Crud crud;

  PropertyData(this.crud);

  getPropertyData(
      String propertyType) async {
    String link="${ApiLink.property}?property_type=$propertyType";
    var response =
    await crud.getData(linkurl: link,
    );
    return response.fold((l) => l, (r) => r);
  }
}
