
import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:developer';
import 'package:wtf_gym/Utils/consts/app_urls.dart';
import 'package:dio/dio.dart';


class WtfGymApiService {

  Future<dynamic> getApiServiceResponse(
      String endPoint, ) async {
    try {

      Dio dio = Dio();
      var response =  await dio.get(AppUrls.baseUrl+ endPoint);
      log("URL : ${AppUrls.baseUrl}$endPoint");

      if (response.statusCode == 200) {
        //return _response(response);
        if(response.data != null){
          log('${response.data}');
          return response.data;
        }


      } else {
        log('Could not fetch Gym. HTTP Status Code: ${response.statusCode} .');
        return Future.value(null);
      }
    } on SocketException {
      log('No Internet connection');
      return Future.value(null);
    }catch(e){
      log(e.toString());
      return Future.value(null);
    }
  }




}
