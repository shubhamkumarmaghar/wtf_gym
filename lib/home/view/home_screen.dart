import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wtf_gym/Utils/widgets/alert_widgets.dart';
import 'package:wtf_gym/home/model/gym_details_model.dart';
import 'package:wtf_gym/home/model/location_model.dart';
import 'package:wtf_gym/home/viewModel/home_viewModel.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';

import 'location_search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _mainHeight;
  var _mainWidth;
  bool selectedAll = true;
  bool selectedExclusive = false;
  bool selectedPowered = false;
  bool selectedCoBranded = false;
  ScrollController _gymScrollController = ScrollController();
  int pageCount = 1;
  int tempCount = 1;
  int pageSize = 5;

  late HomeViewModel _homeViewModel;

  @override
  @override
  void initState() {
    super.initState();
    _homeViewModel = Provider.of<HomeViewModel>(context, listen: false);
    getLocation();
    paging();

  }

  void getLocation()async{
    var position = await requestPermission();
    log("${position?.latitude} ---  ${position?.longitude}" );
    if(position != null){
      _homeViewModel.getGymDetails(page: pageCount, limit: pageSize, lat:position.latitude ?? 28.6190347, lang:position.longitude ?? 77.0640016);
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Unable to fetch location.Please allow it."),
      ));
    }
  }


  Future<Position?> requestPermission() async {

    final PermissionStatus permissionStatus =
    await Permission.locationWhenInUse.status;
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
@override
  void dispose() {
    _gymScrollController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    _mainHeight = MediaQuery.of(context).size.height;
    _mainWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: getAppBar(context: context),
      body: Consumer<HomeViewModel>(
        builder: (context, value, child) {
          // if (pageCount == 1) {
          //   _homeViewModel.gymDetailsList =
          //   _homeViewModel.gymDetailsList != null &&
          //       _homeViewModel.gymDetailsList!.length > 0
          //
          //       ? _homeViewModel.gymDetailsList
          //       : [];
          // }
          return Container(
                  color: Colors.white,
                  height: _mainHeight,
                  width: _mainWidth,
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      getSearchBar(context: context),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: _mainHeight * 0.03,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            getChips(context: context, title: "All", selected: selectedAll, onClick: () {
                             selectedAll = true;
                             selectedExclusive = false;
                             selectedPowered = false;
                             selectedCoBranded = false;
                              _homeViewModel.filterGym(key: 'All');
                            }),
                            getChips(context: context, title: "WTF Exclusive", selected: selectedExclusive, onClick: () {
                              selectedAll = false;
                              selectedExclusive = true;
                              selectedPowered = false;
                              selectedCoBranded = false;
                              _homeViewModel.filterGym(key: 'Exclusive');

                            }),
                            getChips(context: context, title: "WTF Powered", selected: selectedPowered, onClick: () {
                              selectedAll = false;
                              selectedExclusive = false;
                              selectedPowered = true;
                              selectedCoBranded = false;
                              _homeViewModel.filterGym(key: 'Powered');
                            }),
                            getChips(context: context, title: "WTF Co-Branded", selected: selectedCoBranded, onClick: () {
                              selectedAll = false;
                              selectedExclusive = false;
                              selectedPowered = false;
                              selectedCoBranded = true;
                              _homeViewModel.filterGym(key: 'Co-Branded');
                            }),

                          ],
                        ),
                      ),

                      value.gymDetailsList != null && value.gymDetailsList?.length != 0
                          ?Container(
                        margin: EdgeInsets.only(top: _mainHeight*0.02),
                        color: Colors.black12,
                        padding: EdgeInsets.only(left: _mainWidth*0.03,top: _mainHeight*0.01,right: _mainWidth*0.03),

                        height: _mainHeight * 0.7,
                        child: ListView.builder(
                          controller: selectedAll?_gymScrollController:null,
                         physics: selectedAll?BouncingScrollPhysics():null,
                          itemBuilder: (context, index) {
                            return Container(
                              height: _mainHeight * 0.46,
                              margin: EdgeInsets.only(bottom: _mainHeight*0.01),
                              decoration: BoxDecoration(
                                color: Colors.black12,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                                border: Border.all(color: Colors.black12),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(

                                    width: _mainWidth,
                                    decoration: BoxDecoration(
                                        color:Colors.black12,
                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight:Radius.circular(15) )
                                    ),
                                    padding: EdgeInsets.only(
                                        left: _mainWidth * 0.03, top: _mainHeight * 0.01, bottom: _mainHeight * 0.01),
                                    child: Text(
                                      'WTF ${value.gymDetailsList?[index].categoryName}',
                                      style: TextStyle(
                                        fontSize: 22,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: _mainHeight * 0.21,
                                    width: _mainWidth,
                                    child: Image.network(
                                      value.gymDetailsList?[index].coverImage ??
                                          'https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg?20200913095930',
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: _mainWidth * 0.03, top: _mainHeight * 0.01, bottom: _mainHeight * 0.01),
                                    child: Text(
                                      '${value.gymDetailsList?[index].gymName}',
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: _mainHeight * 0.05,
                                    padding: EdgeInsets.only(left: _mainWidth * 0.03, bottom: _mainHeight * 0.01),
                                    child: Text(
                                      '${value.gymDetailsList?[index].distanceText} * ${value.gymDetailsList?[index].address1}, ${value.gymDetailsList?[index].address2}, ${value.gymDetailsList?[index].city}, ${value.gymDetailsList?[index].country}',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Container(


                                    height: _mainHeight*0.1,
                                    width: _mainWidth,

                                    decoration: BoxDecoration(
                                        color:Colors.black,

                                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight:Radius.circular(15) )
                                    ),

                                    child: Column(
                                      children: [

                                        Container(
                                          padding: EdgeInsets.only(
                                              top: _mainHeight*0.01
                                          ),
                                          child: Text('STARTING AT ${value.gymDetailsList?[index].planPrice ??"" } /month',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: _mainHeight * 0.05,
                                          width: _mainWidth,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Container(
                                                width: _mainWidth*0.38,
                                                child: ElevatedButton(onPressed: (){}, child: Text(
                                                  'FREE FIRST DAY',style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600
                                                ),
                                                ),
                                                  style: ButtonStyle(
                                                      backgroundColor: MaterialStateProperty.all(Colors.red),
                                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                          RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(18.0),

                                                          )
                                                      )

                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: _mainWidth*0.38,
                                                child: ElevatedButton(onPressed: (){}, child: Text(
                                                  'BUY NOW',style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,

                                                  fontWeight: FontWeight.w600,

                                                ),

                                                ),
                                                  style: ButtonStyle(
                                                      backgroundColor: MaterialStateProperty.all(Colors.grey),
                                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                          RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(18.0),

                                                          )
                                                      )

                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          itemCount: value.gymDetailsList != null ? value.gymDetailsList?.length : 0,
                        ),
                      ):value.gymDetailsList != null && value.gymDetailsList?.length == 0
                          ? Container(
                        height: _mainHeight*0.5,
                            child: Center(
                        child: Text("No Gym Found for this Location"),
                      ),
                          )
                          : Container(
                          height: _mainHeight*0.5,
                          child: Center(child: CircularProgressIndicator.adaptive())),
                    ],
                  ),
                )
              ;
        },
      ),
    );
  }
  Future _loadPaginatedGymDetails() async {
    pageCount += 1;
    await Future.delayed(Duration(seconds: 2));
    List<Data>? gymModel = await _homeViewModel.fetchPaginatedGymDetails(
        page: pageCount, limit: pageSize, lat: 28.6190347, lang: 77.0640016);

    if (gymModel != null && gymModel.length > 0) {
      for (var name in gymModel ?? [Data()]){
        log('zzzzz  latest${_homeViewModel.gymDetailsList?.length}--${name.gymName}');
      }
      setState(() {
        _homeViewModel.gymDetailsList?.addAll(gymModel);
      });

      for (var name in _homeViewModel.gymDetailsList ?? [Data()]){
        log('zzzzz  Toatl${_homeViewModel.gymDetailsList?.length}--${name.gymName}');
      }
      tempCount = pageCount;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("No More Gyms Found."),
      ));
      pageCount -= 1;
    }
  }
  void paging() {
    _gymScrollController.addListener(() async {
      if (pageCount - tempCount == 0) {

        if (_gymScrollController.position.pixels ==
            _gymScrollController.position.maxScrollExtent) {
         AlertWidgets.showLoaderDialog(context);
          await _loadPaginatedGymDetails();
         Navigator.of(context).pop();
        }
      }
    });
  }
  Widget getSearchBar({required BuildContext context})  {
    return GestureDetector(
      onTap: ()async{

      final LocationModel? locationModel = await Navigator.of(context).push(MaterialPageRoute(builder: (_) =>LocationSearchScreen() ,));
      if(locationModel != null){
        selectedAll = true;
        selectedExclusive = false;
        selectedPowered = false;
        selectedCoBranded = false;
         pageCount = 1;
        tempCount = 1;
        pageSize = 5;

        await _homeViewModel.getGymDetails(page: pageCount, limit: pageSize, lat: locationModel.lat, lang: locationModel.lang);
        _gymScrollController.jumpTo(10);
      }
      },
      child: Container(
        width: _mainWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(35),
          ),
          border: Border.all(color: Colors.black12),
        ),
        child: Row(
          children: [
            Container(
              width: _mainWidth * 0.81,
              child: TextField(
                enabled: false,
                decoration: InputDecoration(
                    enabledBorder: InputBorder.none,
                    border: InputBorder.none,
                    // suffixIcon: Icon(Icons.search),
                    contentPadding: EdgeInsets.only(right: 10, left: 10),
                    hintStyle: TextStyle(fontSize: 16.0, fontFamily: 'Nunito', color: Colors.grey),
                    hintText: 'Search by gym name'),
              ),
            ),
            CircleAvatar(
              backgroundColor: Colors.red,
              child: Icon(
                Icons.search,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getChips(
      {required BuildContext context, required String title, required bool selected, required Function onClick}) {
    return GestureDetector(
      onTap: () => onClick(),
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
        margin: EdgeInsets.only(right: 5),
        decoration: BoxDecoration(
          color: selected ? Colors.black : Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(35),
          ),
          border: Border.all(color: Colors.black12),
        ),
        child: Text(
          title,
          style: TextStyle(color: selected ? Colors.white : Colors.black),
        ),
      ),
    );
  }


  AppBar getAppBar({required BuildContext context}) {
    return AppBar(
      centerTitle: true,
      leadingWidth: 0,

      leading: Icon(Icons.arrow_back,color: Colors.black,),
      backgroundColor: Colors.white,
      elevation: 0,
      title: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.location_on,
                color: Colors.black,
              ),
              Text(
                'Noida',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ],
          ),
          Text(
            'Sector 62',
            style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w400, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
