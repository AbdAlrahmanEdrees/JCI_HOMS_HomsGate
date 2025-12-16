

import '../../../core/class/crud.dart';
import '../../core/constanat/apilink.dart';


class UserPropertyData {
  Crud crud;

  UserPropertyData(this.crud);

  getPropertyData(String token) async {
    String link=ApiLink.userproperty;
    var response =
    await crud.getData(linkurl:  link,Token: token
    );
    return response.fold((l) => l, (r) => r);
  }
  deleteProperty(
      String slug,String token) async {
    var response =
    await crud.deleteData(linkurl: '${ApiLink.deleteproperty}$slug/',
        Token: token
    );
    return response.fold((l) => l, (r) => r);
  }
}
