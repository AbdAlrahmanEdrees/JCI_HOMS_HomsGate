
import 'package:trip/core/constanat/apilink.dart';

import '../../../core/class/crud.dart';


class EditProfileData {
  Crud crud;

  EditProfileData(this.crud);

  PatchProfiledata(
      String key, String value,String token) async {
    var response =
    await crud.patchData(linkurl: ApiLink.editprofile,data:  {
      key: value,
    },
      Token: token
    );
    return response.fold((l) => l, (r) => r);
  }
}
