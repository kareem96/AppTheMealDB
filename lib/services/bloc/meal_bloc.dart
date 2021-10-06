

import 'package:app_the_meal_db/repository/repository_impl.dart';
import 'package:app_the_meal_db/response/meal_response.dart';
import 'package:rxdart/rxdart.dart';

class MealBloc{
  final MealRepositoryImpl? repositoryImpl = MealRepositoryImpl();

  MealBloc();
  final _mealSubject = BehaviorSubject<MealResponse>();
  Stream<MealResponse> get mealResponse => _mealSubject.stream;

  getMealSeafood() async{
    try{
      var response = await repositoryImpl?.getMeal();
      print('Meals ${response?.meal!.length}');
      _mealSubject.sink.add(response!);
    }on Exception catch(e){
      print('Meal errors:${e.toString()}');
    }
  }
  close(){
    _mealSubject.close();
  }
}