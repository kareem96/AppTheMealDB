


import 'package:app_the_meal_db/response/meal_response.dart';
import 'package:equatable/equatable.dart';

abstract class MealState extends Equatable{
  const MealState();
  @override
  List<Object> get props => [];
}

class MealInitial extends MealState{}
class MealLoading extends MealState{
  const MealLoading();
}
class MealLoaded extends MealState{
  final MealResponse? mealResponse;
  const MealLoaded({this.mealResponse});
  @override
  List<Object> get props => [mealResponse!];
}

class MealLoadError extends MealState{
  final String? error;
  const MealLoadError({this.error});
  @override
  List<Object> get props => [error!];
}