

import 'package:app_the_meal_db/db/meal_entity.dart';
import 'package:floor/floor.dart';

@dao
abstract class MealDao{
  @Query('SELECT * FROM MalFavorites')
  Stream<List<MealFavorites>?> findAllFavoritesStream();

  @insert
  Future<void>removeToFavorites(MealFavorites mealFavorites);

  @Query("SELECT * FROM MealFavorites WHERE id= :id")
  Future<bool?> isFavoriteById(int id);

  @insert
  Future<void>addToFavorites(MealFavorites meal);
}