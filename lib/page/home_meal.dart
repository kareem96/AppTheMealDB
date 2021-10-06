

import 'package:app_the_meal_db/model/meal.dart';
import 'package:app_the_meal_db/page/book_page.dart';
import 'package:app_the_meal_db/response/meal_response.dart';
import 'package:app_the_meal_db/services/bloc/meal_bloc.dart';
import 'package:app_the_meal_db/services/bloc/meal_cubit.dart';
import 'package:app_the_meal_db/services/bloc/meal_state.dart';
import 'package:app_the_meal_db/services/component/meal_image_detail.dart';
import 'package:app_the_meal_db/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeMeal extends StatefulWidget{

  @override
  _HomeMealState createState() => _HomeMealState();

}

class _HomeMealState extends State<HomeMeal> with AutomaticKeepAliveClientMixin{
  double radius = 24.0;
  double padding = 16.0;

  String title = 'App TheMealDB';
  // String subTitle = 'Meals';

  //
  int _currentIndex = 0;
  PageController? _pageController;
  late List<Widget> listPage;

  List<Meal> mealList = [];
  int _selectedIndex = 0;
  MealCubit? mealCubit;
  MealBloc mealBloc = MealBloc();

  double sizeHConfig = 1920;
  double sizeWConfig = 1080;


  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex, viewportFraction: 0.70);
    mealCubit = BlocProvider.of<MealCubit>(context);
    mealBloc.getMealSeafood();
  }


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {
    final Color _bottomTabColor = Color.fromRGBO(68, 65, 78, 1);

    _definePage(context);

    print('Value of Size device : ${MediaQuery.of(context).size.height}/ ${MediaQuery.of(context).size.width}');
    return Scaffold(
      backgroundColor: Colors.white,
      body: listPage[_currentIndex],
    );
  }

  final ScrollController _controller = ScrollController();

  void _definePage(BuildContext context) {
    double sizeH = MediaQuery.of(context).size.height;
    listPage = [
      SafeArea(
        left: true,
        top: true,
        right: true,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildAppBar(),
              Padding(
                padding: EdgeInsets.only(left: padding),
              ),
              BlocConsumer<MealCubit, MealState>(
                buildWhen: (prevState, state) {
                  return state is! MealLoading;
                },
                listener: (context, state) {
                  if (state is MealLoadError) return;
                },
                builder: (BuildContext context, state) {
                  if (state is MealLoaded) {
                    return Container(
                      child: _mealSeafood(),
                      height: _configSize(sizeH),
                    );
                  }
                  return _buildLoading(context);
                },
              ),
            ],
          ),
        ),
      )
    ];
  }

  //appBar
  Container _buildAppBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: padding),
      margin: EdgeInsets.only(bottom: padding / 2),
      height: kToolbarHeight - 10,
      child: Row(
        children: [
          const Icon(
            Icons.fastfood,
            size: 32.0,
            color: Colors.black,
          ),
          const SizedBox(width: 8.0),
          Text(
            title,
            style: const TextStyle(fontSize: 24.0, color: Colors.red, fontWeight: FontWeight.bold),
          ),
          Spacer(),
        ],
      ),
    );
  }

  void _mealPageProvider(BuildContext context, Widget widget) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: BlocProvider.of<MealCubit>(context),
          child: widget,
        )));
  }


  //response meal
  StreamBuilder<MealResponse> _mealSeafood() {
    return StreamBuilder<MealResponse>(
      stream: mealBloc.mealResponse.take(10),
      initialData: null,
      builder: (BuildContext context, AsyncSnapshot<MealResponse> snapshot){
        if(!snapshot.hasData){
          print('Error response data : ${snapshot.data}/ ${snapshot.error}');
          return _buildLoading(context);
        }
        if(snapshot.hasData && snapshot.data!.meal!.isNotEmpty ){
          List<Meal> meal = snapshot.data!.meal!;
          return _buildListMeal(meal);
        }
        return Center(child: Container(),);
      },
    );
  }


  //List Meal
  Widget _buildListMeal(List<Meal> data) {
    return ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.all(8.0),
        scrollDirection: Axis.vertical,
        itemCount: data.length,
        itemBuilder: (_, int index) => Container(
          margin: const EdgeInsets.only(left: 10, top: 10, right: 10,),
          child: MealImageDetail(
            meal: data[index],
            function: () => _mealPageProvider(
              context,
              BookPage(
                meal: data[index],
              ),
            ),
          ),
        )
    );
  }


  double _configSize(double sizeH) {
    if(sizeH < sizeHConfig){
      print('Value SizeH: ${sizeH * .3}');
      return sizeH * .8;
    }
    return 320;
  }

  Widget _buildLoading(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        backgroundColor: Colors.blueAccent,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

}