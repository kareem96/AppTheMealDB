

import 'dart:async';

import 'package:app_the_meal_db/db/meal_dao.dart';
import 'package:app_the_meal_db/db/meal_entity.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart';


@Database(version: 1, entities: [MealFavorites])
abstract class AppDatabase extends FloorDatabase{
  MealDao get mealDao;
}