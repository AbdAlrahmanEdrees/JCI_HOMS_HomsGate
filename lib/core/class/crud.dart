import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:trip/core/class/stutusconntection.dart';

import '../functions/checkinternet.dart';

class Crud {
  Future<Either<StatusRequest, Map>> postData(
      {String? linkurl,@required String? Token, Map? data}) async {
    if (await checkInternet()) {
      http.Response response;
      if (Token != null) {
        response = await http.post(
          Uri.parse(linkurl!),
          body: data,
          headers: {"Authorization": "Token $Token"},
        );
      } else {
        response = await http.post(
          Uri.parse(linkurl!),
          body: data,
        );
      }

      print(response.statusCode);
      print(utf8.decode(response.bodyBytes));
      if (response.statusCode == 200 || response.statusCode == 201) {
        Map responsebody = jsonDecode(utf8.decode(response.bodyBytes));
        print(responsebody);

        return Right(responsebody);
      } else {
        return const Left(StatusRequest.serverfailure);
      }
    } else {
      return const Left(StatusRequest.offlinefailure);
    }
  }
  Future<Either<StatusRequest, Map>> patchData(
      {String? linkurl,@required String? Token, Map? data}) async {
    if (await checkInternet()) {
      http.Response response;
      if (Token != null) {
        response = await http.patch(
          Uri.parse(linkurl!),
          body: data,
          headers: {"Authorization": "Token $Token"},
        );
      } else {
        response = await http.patch(
          Uri.parse(linkurl!),
          body: data,
        );
      }

      print(response.statusCode);
      print(utf8.decode(response.bodyBytes));
      if (response.statusCode == 200 || response.statusCode == 201) {
        Map responsebody = jsonDecode(utf8.decode(response.bodyBytes));
        print(responsebody);

        return Right(responsebody);
      } else {
        return const Left(StatusRequest.serverfailure);
      }
    } else {
      return const Left(StatusRequest.offlinefailure);
    }
  }

  Future<Either<StatusRequest, Map>> postRequestWithFile(
      String url, String Token, Map data, File file, String FileName) async {
    if (await checkInternet()) {
      Map<String, String> header = {};
      header.addAll({"Authorization": "Token $Token"});
          var request = http.MultipartRequest('POST', Uri.parse(url));
      request.headers.addAll(header);
      var length = await file.length();
      var stream = http.ByteStream(file.openRead());

      var multipartFile = http.MultipartFile(FileName, stream, length,
          filename: basename(file.path));
      request.files.add(multipartFile);
      data.forEach((key, value) {
        request.fields[key] = value;
      });
      var myrequest = await request.send();
      var response = await http.Response.fromStream(myrequest);
      if (response.statusCode == 200 || response.statusCode == 201) {
        var res = jsonDecode(response.body);
        return Right(res);
      } else {
        return const Left(StatusRequest.serverfailure);
      }
    } else {
      return const Left(StatusRequest.offlinefailure);
    }
  }


  Future<Either<StatusRequest, dynamic>> postRequestWithListFile(String url,
      String token, Map data, List<File> files, String listImageName) async {
    if (await checkInternet()) {
      Map<String, String> header = {};
      header.addAll({"Authorization": "Token $token"});
    
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.headers.addAll(header);
      for (var file in files) {
        var length = await file.length();
        var stream = http.ByteStream(file.openRead());

        var multipartFile = http.MultipartFile(listImageName, stream, length,
            filename: basename(file.path));
        request.files.add(multipartFile);
      }

      data.forEach((key, value) {
        request.fields[key] = value;
      });

      var myRequest = await request.send();

      var response = await http.Response.fromStream(myRequest);
      print(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        var res = jsonDecode(response.body);
        if (res is Map) {
          return Right(res);
        } else if (res is List) {
          return Right(res);
        } else {
          return const Left(StatusRequest.serverfailure);
        }
      } else {
        return const Left(StatusRequest.serverfailure);
      }
    } else {
      return const Left(StatusRequest.offlinefailure);
    }
  }
Future<Either<StatusRequest, Map<String, dynamic>>> getDataAsMap(
    {required String linkurl,  String? Token}) async {
  Map<String, String> header = {};
  print(Token);
  if (Token != null) {
    header.addAll({"authorization": "token $Token"});
  }

  if (await checkInternet()) {
    var response = await http.get(Uri.parse(linkurl,), headers: header);
    print(response.body);
    print(response.statusCode);


    if (response.statusCode == 200 || response.statusCode == 201) {
      var responsebody = jsonDecode(utf8.decode(response.bodyBytes));
      print(responsebody);

      return Right(responsebody);
    } else {
      return const Left(StatusRequest.serverfailure);
    }
  } else {
    return const Left(StatusRequest.offlinefailure);
  }
}
Future<Either<StatusRequest, dynamic>> getData(
    {required String linkurl,  String? Token}) async {
  Map<String, String> header = {};
  if (Token != null) {
    header.addAll({"Authorization": "Token $Token"});
  }

  if (await checkInternet()) {
    var response = await http.get(Uri.parse(linkurl), headers: header);
    print(response);
    print(response.statusCode);

    if (response.statusCode == 200 || response.statusCode == 201) {
      var responsebody = jsonDecode(utf8.decode(response.bodyBytes));
      print(responsebody);
        return Right(responsebody);

    } else {
      return const Left(StatusRequest.serverfailure);
    }
  } else {
    return const Left(StatusRequest.offlinefailure);
  }
}
  Future<Either<StatusRequest, dynamic>> deleteData(
      {required String linkurl,  String? Token, Map? data}) async {
    Map<String, String> header = {};
    if (Token != null) {
      header.addAll({"Authorization": "Token $Token"});
    }

    if (await checkInternet()) {
      var response = await http.delete(Uri.parse(linkurl), headers: header,body: data);
      print(response.statusCode);
      if (response.statusCode == 200 || response.statusCode == 201|| response.statusCode == 204) {
        if(response.body.isNotEmpty){

          var responsebody = jsonDecode(utf8.decode(response.bodyBytes));
          print(responsebody);
          return Right(responsebody);
        }
        else{
          return Right({});
        }

      } else {
        return const Left(StatusRequest.serverfailure);
      }
    } else {
      return const Left(StatusRequest.offlinefailure);
    }
  }
}

