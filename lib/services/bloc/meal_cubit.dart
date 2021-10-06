


import 'package:app_the_meal_db/repository/repository.dart';
import 'package:app_the_meal_db/response/meal_response.dart';
import 'package:app_the_meal_db/services/bloc/meal_state.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

class MealCubit extends Cubit<MealState>{
  final MealRepository? mealRepository;

  MealCubit({this.mealRepository}) : super(MealInitial());

  void getMeal() async{
    try{
      var response = await mealRepository?.getMeal();
      emit(MealLoaded(mealResponse: response));
    }on DioError catch(e){
      emit(MealLoadError(error: 'Meal error load ${e.toString()}'));
    }
  }
}