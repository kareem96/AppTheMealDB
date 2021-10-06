


import 'package:app_the_meal_db/response/meal_response.dart';

abstract class MealRepository{
  Future<MealResponse> getMeal();
  // Future<MealResponse> getMealS();
}