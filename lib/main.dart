import 'package:app_the_meal_db/db/database.dart';
import 'package:app_the_meal_db/db/meal_dao.dart';
import 'package:app_the_meal_db/page/main_page.dart';
import 'package:app_the_meal_db/repository/repository_impl.dart';
import 'package:app_the_meal_db/services/bloc/data_bloc.dart';
import 'package:app_the_meal_db/services/bloc/meal_cubit.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


Future<void>main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final database = await $FloorAppDatabase.databaseBuilder("appdata.db").build();
  final mealDao = database.mealDao;
  runApp(MyApp(mealDao));

}

class MyApp extends StatelessWidget {
  final MealDao mealDao;
  final mealrepository = MealRepositoryImpl();

  MyApp(this.mealDao);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<MealCubit>(create: (BuildContext context) => MealCubit(mealRepository: mealrepository)..getMeal()),
          BlocProvider<DataBloc>(
              create: (BuildContext context) => DataBloc(mealDao: mealDao))
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(backgroundColor: const Color(0xff1b343d)),
          home: MainPage(),
        ),);
  }
}



/*void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  Bloc.observer = MyBlocServer();
  Widget widget;


  runApp(MyApp(
    startWidget: widget = HomeLayout(),
  ));
}*/

/*class MyApp extends StatelessWidget{
  final bool shown;
  final Widget startWidget;

  MyApp({
    this.shown,
    this.startWidget,
});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()
          ..getSeafoodData(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state){},
        builder: (context, state){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.light,
            home: startWidget,
          );
        },
      ),
    );
  }
}*/

