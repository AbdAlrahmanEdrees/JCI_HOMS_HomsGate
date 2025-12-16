

import '../../../core/class/crud.dart';
import '../../core/constanat/apilink.dart';


class OnePropertyData {
  Crud crud;

  OnePropertyData(this.crud);

  getPropertyData(
      String propertySlug) async {
    String link="${ApiLink.onproperty}$propertySlug";
    var response =
    await crud.getDataAsMap(linkurl: link,
    );
    return response.fold((l) => l, (r) => r);
  }
}
