


import 'package:app_the_meal_db/db/meal_entity.dart';
import 'package:app_the_meal_db/model/meal.dart';
import 'package:app_the_meal_db/services/bloc/data_bloc.dart';
import 'package:app_the_meal_db/services/bloc/meal_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookPage extends StatefulWidget {
  final Meal? meal;

  const BookPage({this.meal, Key? key}) : super(key: key);

  @override
  _BookPageState createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {

  // double
  double padding = 16.0;
  double radius = 24.0;
  List<Meal> mealList = [];
  DataBloc? dataBloc;

  // scroll
  double positionY = 350.0;

  // full scroll state signal
  bool isFullScrolled = false;
  MealCubit? mealCubit;
  bool isFavorites = false;

  @override
  void initState() {
    super.initState();
    mealCubit = BlocProvider.of<MealCubit>(context);
    dataBloc = BlocProvider.of<DataBloc>(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    double maxPositionY = screenHeight - 80.0;
    double minPositionY = screenHeight * .6;
    return Scaffold(
      body: SafeArea(
          child: Stack(
            children: <Widget>[
              _buildPositionedImage(screenHeight),
              _buildTopBar(context),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: buildGestureDetector(maxPositionY, minPositionY, screenWidth, context),
              ),
            ],
          )),
    );
  }

  GestureDetector buildGestureDetector(double maxPositionY, double minPositionY, double screenWidth, BuildContext context) {
    return GestureDetector(
      onVerticalDragStart: (DragStartDetails detail) {},
      onVerticalDragUpdate: (DragUpdateDetails detailUpdate) {
        setState(() {
          positionY -= detailUpdate.delta.dy;
          if (positionY > maxPositionY) positionY = maxPositionY;
          if (positionY < minPositionY) positionY = minPositionY;
          print("Value :$positionY");
          print("ID meal :${widget.meal!.id}");
          if (positionY == maxPositionY)
            isFullScrolled = true;
          else
            isFullScrolled = false;
        });
      },
      onVerticalDragEnd: (DragEndDetails detailEnd) {
        setState(() {
          if (positionY >= minPositionY + (maxPositionY - minPositionY) / 2)
            positionY = maxPositionY;
          else
            positionY = minPositionY;
          if (positionY == maxPositionY)
            isFullScrolled = true;
          else
            isFullScrolled = false;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(seconds: 1),
        curve: Curves.fastLinearToSlowEaseIn,
        height: positionY,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 32.0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.only(
                  top: padding * 2,
                  left: padding,
                  bottom: padding * 2,
                ),
                height: maxPositionY + 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(radius),
                      topRight: Radius.circular(radius),
                    ),
                    color: Colors.orange,
                    boxShadow: const [BoxShadow(color: Colors.black12, spreadRadius: 1, blurRadius: 1)]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    isFullScrolled ? Container() : _buildMovieInfo(),
                    Flexible(
                        // padding: EdgeInsets.only(right: padding * 2),
                        // height: 150.0,
                        child: SingleChildScrollView(
                          child: Text(
                            widget.meal!.desc!,
                            style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 20),
                          ),
                        )
                    ),
                  ],
                ),
              ),
            ),
            isFullScrolled
                ? Positioned(
              // top: 42.0,
              left: screenWidth / 2 - 24.0,
              right: screenWidth / 2 - 24.0,
              child: Container(
                height: 4.0,
                decoration: ShapeDecoration(shape: const StadiumBorder(), color: Colors.grey[300]),
              ),
            ) : AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              curve: Curves.fastOutSlowIn,
              top: 0,
              left: screenWidth / 2 - 32.0,
              right: screenWidth / 2 - 32.0,
              child: Container(
                height: isFullScrolled ? 0 : 64.0,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.orange,
                    boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 1, spreadRadius: 1)]
                ),
                child: isFullScrolled
                    ? Row()
                    : IconButton(
                    icon: _favoritesStream(),
                    onPressed: () {

                      // _favoritesStream();
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }

  Positioned _buildTopBar(BuildContext context) {
    return Positioned(
      top: 0,
      left: padding / 2,
      right: padding / 2,
      child: SafeArea(top: true, right: true, left: true,
        child: Row(
          children: [
            IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: 28.0,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                }), isFullScrolled ? Flexible(
              fit: FlexFit.tight,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildTitle(),
                ],
              ),
            ) : const Spacer(),
            // _favoritesStream(),
          ],
        ),
      ),
    );
  }



  Widget _favoritesStream() {
    var meal = MealFavorites(widget.meal!.ids, widget.meal!.name, widget.meal!.homepage);
    return StreamBuilder<bool?>(
        builder: (context, snapshot) {
          return IconButton(
            onPressed: () => {
            dataBloc!.addMeal(meal),
            ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text("Berhasil di tambahkan ke Favorite"),
              duration: Duration(seconds: 1),
            ))
            },
            icon: const Icon(Icons.favorite_border, size: 30.0, color: Colors.red),
          );
        });
  }

  Flexible _buildTitle() {
    return Flexible(
      fit: FlexFit.tight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(widget.meal!.name!,
              style: const TextStyle(
                fontSize: 28,
                color: Colors.white,
                fontWeight: FontWeight.normal,
              )),
        ],
      ),
    );
  }

  Positioned _buildPositionedImage(double screenHeight) {
    return Positioned(
      top: 0,
      right: 0,
      left: 0,
      bottom: screenHeight * .35,
      child: Hero(
        tag: "movie ${widget.meal!.id!}",
        child: Image.network(
          widget.meal!.image!,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Container _buildMovieInfo() {
    return Container(
      margin: EdgeInsets.only(left: padding),
      height: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            widget.meal!.name!,
            style: const TextStyle(fontSize: 30.0, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  _pupUpDialog(BuildContext? context, Widget? widget) {
    Navigator.push(
      context!,
      MaterialPageRoute(builder: (context) => widget!),
    );
  }

  @override
  void dispose() {
    super.dispose();
    mealCubit!.close();
    dataBloc!.close();
  }
}