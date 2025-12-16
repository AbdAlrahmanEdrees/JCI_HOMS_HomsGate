// import 'dart:io';

// import '../../../core/class/crud.dart';
// import '../../core/constanat/apilink.dart';


// class PropertyImages {
//   Crud crud;

//   PropertyImages(this.crud);

//   AddPropertyImages(String token, List<File> files,String id)async{
//     var response =
//     await crud.postRequestWithListFile(ApiLink.uplodeimages, token, {
//       'property_id':id
//     }, files, 'image');
//     return response.fold((l) => l, (r) => r);
//   }
// }
