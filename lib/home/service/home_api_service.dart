import 'package:wtf_gym/Utils/consts/app_urls.dart';

import '../../Utils/Services/wtf_gym_api_service.dart';
import '../model/gym_details_model.dart';

class HomeApiService{
  final apiService = WtfGymApiService();

  Future<List<Data>?> fetchGymDetails({required int page,required int limit,required double lat,required double lang })async{
   var url = '${AppUrls.gymDetails}?page=$page&limit=$limit&lat=$lat&long=$lang';
    final data = await apiService.getApiServiceResponse(url) as Map<String,dynamic>;
    if(data['data'] != null && data['data'] != []){
      final Iterable json = data['data'];
      return json.map((gymModel) => Data.fromJson(gymModel)).toList();
    }else if(data['data'] != null && data['data'] == []){
      return [];
    }
    else{
      return null;
    }

  }
}