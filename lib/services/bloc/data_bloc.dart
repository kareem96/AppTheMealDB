

import 'package:app_the_meal_db/db/meal_dao.dart';
import 'package:app_the_meal_db/db/meal_entity.dart';
import 'package:bloc/bloc.dart';

class DataBloc extends BlocBase{
  final MealDao? mealDao;

  DataBloc({this.mealDao}):super(null);

  getAllMeal(){
    return mealDao!.findAllFavoritesStream();
  }
  Future<bool?>checkAlready(int ids){
    return mealDao!.isFavoriteById(ids);
  }
  removeMeal(MealFavorites meal){
    return mealDao!.removeToFavorites(meal);
  }
  addMeal(MealFavorites meal){
    return mealDao!.addToFavorites(meal);
  }
}