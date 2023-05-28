import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:wtf_gym/home/model/gym_details_model.dart';
import 'package:wtf_gym/home/service/home_api_service.dart';

import '../model/location_model.dart';

class HomeViewModel extends ChangeNotifier{
  List<Data>? gymDetailsList;
  final HomeApiService _apiService = HomeApiService();
  List<Data> allGymDetailsList=[];
  List<LocationModel> locationList = [];
  List<LocationModel> searchedLocationList = [];


  Future<void> getGymDetails({required int page,required int limit,required double lat,required double lang })async{
    gymDetailsList=null;
    final data = await _apiService.fetchGymDetails(page: page, limit: limit, lat: lat, lang: lang);
    if(data != null && data.length > 0){

      allGymDetailsList.addAll(data as Iterable<Data>);
      allGymDetailsList.forEach((data) =>locationList.add(LocationModel(data.address1 ??'',  double.parse(data.latitude??'28.5355161'), double.parse(data.latitude??'77.3910265'))));
      searchedLocationList = [...locationList];
    }
    gymDetailsList = data;
    notifyListeners();

  }
  void filterGym({required String key}){
    List<Data> filteredList = [];
    if(key == "Exclusive"){
      for(var data in allGymDetailsList){
      if(data.categoryName  == "Exclusive"){
        filteredList.add(data);
      }
      }
      gymDetailsList = filteredList;
      notifyListeners();
    }else if(key == "All"){
      gymDetailsList = allGymDetailsList;
      notifyListeners();
    }else if(key == "Powered"){
      for(var data in allGymDetailsList){
        if(data.categoryName  == "Powered"){
          filteredList.add(data);
        }
      }
      gymDetailsList = filteredList;
      notifyListeners();
    }else if(key == "Co-Branded"){
      for(var data in allGymDetailsList){
        if(data.categoryName  == "Co-Branded"){
          filteredList.add(data);
        }
      }
      gymDetailsList = filteredList;
      notifyListeners();
    }
  }
  Future<void> getSearchedLocation({required String searchText})async{
    List<LocationModel> filterdLocationModel = [];
    searchedLocationList.clear();
    if(searchText != ""){
      for(var data in locationList){

        if(data.locationName.toLowerCase().contains(searchText.toLowerCase())){
          filterdLocationModel.add(data);
        }
      }
      searchedLocationList = [...filterdLocationModel];
      notifyListeners();
    }else{
      searchedLocationList = [...locationList];
      notifyListeners();
    }



  }

  Future<List<Data>?> fetchPaginatedGymDetails({required int page, required int limit, required double lat, required double lang})async {
    final data = await _apiService.fetchGymDetails(page: page, limit: limit, lat: lat, lang: lang);
    if(data != null && data.length > 0){
      allGymDetailsList.addAll(data as Iterable<Data>);
      allGymDetailsList.forEach((data) =>locationList.add(LocationModel(data.address1 ??'',  double.parse(data.latitude??'28.5355161'), double.parse(data.latitude??'77.3910265'))));
      searchedLocationList = [...locationList];
    }
    return data;
  }




}