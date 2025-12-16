
import '../../../core/class/crud.dart';


class SignUpData {
  Crud crud;

  SignUpData(this.crud);

  PostSignUpdata(
      String fname,String lname, String email,String password,String repassword) async {
    var response =
    await crud.postData(linkurl: 'https://housetech.onrender.com/api/v1/auth/register/',data: {
      'password':password,
      'password2':repassword,
      'email':email,
      'first_name':fname,
      'last_name':lname
    },
    );
    return response.fold((l) => l, (r) => r);
  }
}
