

import 'package:app_the_meal_db/repository/repository.dart';
import 'package:app_the_meal_db/response/meal_response.dart';
import 'package:app_the_meal_db/utils/constants.dart';
import 'package:dio/dio.dart';

class MealRepositoryImpl implements MealRepository{
  final Dio _dio = Dio();
  static String mainUrl = "https://www.themealdb.com/api/json/v1/1/";
  var seafood = Constants.seafood;
  // var getMealSeafood = '$mainUrl/filter.php';
  var getMealSeafood = '$mainUrl/search.php';



  @override
  Future<MealResponse> getMeal() async{
    var params = {"s":""};
    try{
      Response response = await _dio.get(getMealSeafood, queryParameters: params);
      print('Value of response: ${response.data}');
      return MealResponse.fromJson(response.data);
    }catch(error, stacktrace){
      print("Exception occured: $error stackTrace: $stacktrace");
      return MealResponse.withError("Exception: $error stacktrace: $stacktrace");
    }
  }


}