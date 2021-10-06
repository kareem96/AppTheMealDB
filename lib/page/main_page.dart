

import 'package:app_the_meal_db/page/favorite.dart';
import 'package:app_the_meal_db/services/component/bottom_tabs.dart';
import 'package:flutter/material.dart';

import 'home_meal.dart';

class MainPage extends StatefulWidget{
  const MainPage({Key? key}):super(key: key);

  @override
  _MainPageState createState() => _MainPageState();

}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  PageController? _pageController;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController!.animateToPage(index,
          duration: const Duration(milliseconds: 500), curve: Curves.easeOut);
    });
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController!.dispose();
  }

  double radius = 24.0;
  final Color _bottomTabColor = const Color.fromRGBO(68, 65, 78, 1);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        SafeArea(
          child: PageView(
            allowImplicitScrolling: true,
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            children: <Widget>[HomeMeal(), Favorites()],
          ),
        ),
        Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(8.0),
              height: kToolbarHeight,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(radius),
                    topRight: Radius.circular(radius),
                  ),
                  color: _bottomTabColor.withOpacity(.8),
                  // color: Colors.red,
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black12, spreadRadius: 1, blurRadius: 1)
                  ]),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: BottomTabs(
                      icon: Icons.food_bank_outlined,
                      text: "Feed",
                      isSelected: _selectedIndex == 0,
                      onPressed: () {
                        _onItemTapped(0);
                      },
                    ),
                  ),
                  Expanded(
                    child: BottomTabs(
                      icon: Icons.favorite_border,
                      text: "Favorite",
                      isSelected: _selectedIndex == 1,
                      onPressed: () => _onItemTapped(1),
                    ),
                  ),
                ],
              ),
            ))
      ]),
    );
  }

}