

import '../../../core/class/crud.dart';
import '../../core/constanat/apilink.dart';


class FavoriteData {
  Crud crud;

  FavoriteData(this.crud);

  addFavorite(
      String propertyid,String token) async {
    String link=ApiLink.addtofav;
    var response =
    await crud.postData(linkurl: link,Token: token,data: {
      'property_id':propertyid
    }
    );
    return response.fold((l) => l, (r) => r);
  }
  deleteFavorite(
      String propertyid,String token) async {
    String link=ApiLink.deletefromfav;
    var response =
    await crud.deleteData(linkurl: link,Token: token,
      data: {
      'property_id':propertyid
      }
    );
    return response.fold((l) => l, (r) => r);
  }
  getUserFavorites(String token)async{

      String link=ApiLink.addtofav;
      var response =
      await crud.getData(linkurl: link,Token: token
      );
      return response.fold((l) => l, (r) => r);
    }
  }

