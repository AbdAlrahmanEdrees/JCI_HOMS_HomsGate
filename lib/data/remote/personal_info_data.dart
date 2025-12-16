import '../../../core/class/crud.dart';
import '../../core/constanat/apilink.dart';

class PersonalInfoData {
  Crud crud;

  PersonalInfoData(this.crud);

  getPersonalInfo(String token) async {
    String link = ApiLink.pesonalinfo;
    var response = await crud.getDataAsMap(linkurl: link, Token: token);
    return response.fold((l) => l, (r) => r);
  }
}
