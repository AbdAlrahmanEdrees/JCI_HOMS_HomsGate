
import '../../../core/class/crud.dart';


class SignInData {
  Crud crud;

  SignInData(this.crud);

  PostSignUpdata(
       String email, String password) async {
    var response =
    await crud.postData(linkurl: 'https://housetech.onrender.com/api/v1/auth/login/',data:  {
      'password': password,
      'email': email,

    },
    );
    return response.fold((l) => l, (r) => r);
  }
}
