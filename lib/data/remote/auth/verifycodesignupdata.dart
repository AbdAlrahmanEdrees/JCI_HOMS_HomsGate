
import '../../../core/class/crud.dart';


class Verifycodesignupdata {
  Crud crud;

  Verifycodesignupdata(this.crud);

  PostVerifycodesignup(
      String email,String verify) async {
    var response =
    await crud.postData(linkurl: 'https://housetech.onrender.com/api/v1/auth/verify-email/',data: {
      'email':email,
      'otp':verify
    },
    );
    return response.fold((l) => l, (r) => r);
  }
}
