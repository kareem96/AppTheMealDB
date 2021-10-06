

import 'package:floor/floor.dart';

@Entity(
    tableName: 'MealFavorites',
    indices:[
      Index(value: ['id'], unique: true)
    ],
)

class MealFavorites{
  @primaryKey
  final int? id;
  final String? title;
  final String? homepage;

  MealFavorites(this.id, this.title, this.homepage);

}