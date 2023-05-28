import 'dart:developer';


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/location_model.dart';
import '../viewModel/home_viewModel.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';

class LocationSearchScreen extends StatefulWidget {
  const LocationSearchScreen({Key? key}) : super(key: key);

  @override
  State<LocationSearchScreen> createState() => _LocationSearchScreenState();
}

class _LocationSearchScreenState extends State<LocationSearchScreen> {

  late HomeViewModel _homeViewModel;
  var _mainHeight;
  var _mainWidth;
  late TextEditingController locationTextController;

  @override
  void initState() {
    super.initState();
    locationTextController= TextEditingController();
    _homeViewModel = Provider.of<HomeViewModel>(context, listen: false);
   }
@override
  void dispose() {
  locationTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _mainHeight = MediaQuery.of(context).size.height;
    _mainWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
      elevation: 0,
        title: Text('Pick Location',style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,
        centerTitle: false,
        leading: GestureDetector(
          onTap: ()=>Navigator.of(context).pop(),
          child:
          Container(
            height: 10,
            width: 10,
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          ),

        actions: [
          Container(
              padding: EdgeInsets.only(right: 10,),
              child: Row(
                children: [
                  Text('Noida',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700),),
                  Icon(Icons.arrow_drop_down,color: Colors.black,)
                ],
              ))
        ],
      ),
      body: SingleChildScrollView(child:GestureDetector(
        onTap: ()=>FocusScope.of(context).requestFocus(FocusNode()),
        child: Container(
          height: _mainHeight,
          width: _mainWidth,
          color: Colors.white,
          padding: EdgeInsets.only(left: 10,right: 10,top: 10),
          child: Column(
            children: [
              getSearchBar(context: context),
              SizedBox(height: 10,),
              Container(
                width: _mainWidth,
                height: _mainHeight*0.05,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap:()async{
                        final position = await requestPermission();
                        if(position != null){
                          log('${position.latitude} -- ${position.longitude}');
                          Navigator.of(context).pop(LocationModel("", position.latitude, position.longitude));

                        }else{
                          log('Location permission is permanently denied.Please allow location Permission');
                        }

                      },
                      child: Container(
                        width: _mainWidth*0.8,
                        padding: EdgeInsets.only(left: 10,right: 10),
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          border: Border.all(color: Colors.black12),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.my_location_outlined,size: 20,),
                            SizedBox(width: _mainWidth*0.02,),
                            Text('Around Your Location',style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.black
                            ),),
                            Spacer(),
                            Icon(Icons.arrow_right_alt,color: Colors.red,),
                          ],
                        ),
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap:()async{
                        final position = await requestPermission();
                        if(position != null){
                          log('${position.latitude} -- ${position.longitude}');
                          Navigator.of(context).pop(LocationModel("", position.latitude, position.longitude));

                        }else{
                          log('Location permission is permanently denied.Please allow location Permission');
                        }

                      },
                      child: Container(
                        width: _mainWidth*0.1,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          border: Border.all(color: Colors.black12),
                        ),
                        child: Icon(Icons.edit_location,size: 20,),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: _mainHeight*0.04,),
              Container(
                width: _mainWidth,
                child: Row(
                  children: [
                    Text('AREA ',style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w700
                    ),),
                    Text('(No. of gyms)',style: TextStyle(

                    ),),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              getLocationsList(context:context)
            ],
          ),
        ),
      ),
      ),
    );
  }
  Future<Position?> requestPermission() async {

    final PermissionStatus permissionStatus =
    await Permission.locationWhenInUse.status;
    log('${permissionStatus}');
     if (permissionStatus != PermissionStatus.granted) {
      var status = await Permission.locationWhenInUse.request();
      if(await status == PermissionStatus.granted){
        final Position position = await _getUserLocation();
        return position;
      }else{
        return null;
      }

    }else{
       final Position position = await _getUserLocation();
       return position;
     }
  }
  Future<Position> _getUserLocation() async {
    var position = await GeolocatorPlatform.instance
        .getCurrentPosition();
    return position;
  }
  Widget getSearchBar({required BuildContext context}) {
    return GestureDetector(
      onTap: (){

      },
      child: Container(
        width: _mainWidth,
        // decoration: BoxDecoration(
        //   borderRadius: BorderRadius.all(
        //     Radius.circular(10),
        //   ),
        //   border: Border.all(color: Colors.black12),
        // ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

            Container(
              width: _mainWidth * 0.94,
              height: 50,
              child: TextField(
              onChanged: (text){
                if(text.length > 0){
                 _homeViewModel.getSearchedLocation( searchText: text);
                }else{
                  _homeViewModel.getSearchedLocation( searchText: "");
                }
              },
               controller: locationTextController,
                decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Colors.grey, width: 0.0),
                    ),
                    prefixIcon: Icon(Icons.search),
                   // suffix: locationTextController.value.text.isNotEmpty? IconButton(onPressed: (){}, icon: Icon(Icons.clear)):Text(''),
                    contentPadding: EdgeInsets.only(top: 5),
                    hintText:'Search location' ,
                    border: OutlineInputBorder()),

                    //enabledBorder: InputBorder.none,
                    // suffixIcon: Icon(Icons.search),
                    // contentPadding: EdgeInsets.only(right: 10, left: 10),
                    // hintStyle: TextStyle(fontSize: 16.0, fontFamily: 'Nunito', color: Colors.grey),
                    // hintText: 'Search by gym name'),
              ),
            ),

          ],
        ),
      ),
    );
  }




  Widget getLocationsList({required BuildContext context}) {
    return Consumer<HomeViewModel>(builder: (context, value, child) {
      return Container(
        height: _mainHeight*0.6,
        child: ListView.separated(
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: ()=>Navigator.of(context).pop(_homeViewModel.searchedLocationList[index]),
                child: Container(
                  height: _mainHeight*0.04,
                  width: _mainWidth,
                  padding: EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.location_on),
                      SizedBox(width: 10,),
                      Text(value.searchedLocationList[index].locationName)
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (_,__)=>SizedBox(height: 10,),
            itemCount: value.searchedLocationList.length),

      );
    },);
  }
}
