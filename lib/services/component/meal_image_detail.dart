

import 'package:app_the_meal_db/model/meal.dart';

import 'package:flutter/material.dart';

class MealImageDetail extends StatefulWidget{
  final Meal? meal;
  final Function? function;
  const MealImageDetail({this.meal, this.function, Key? key}):super (key:key);

  @override
  _MealImageDetailState createState() => _MealImageDetailState();
}

class _MealImageDetailState extends State<MealImageDetail> {
  @override
  Widget build(BuildContext context) {
    double sizeW = MediaQuery.of(context).size.width;
    return SizedBox(
      height: 160,
      child: InkWell(
        onTap: widget.function as void Function()?,
        child: Card(
          elevation: 5.5,
          borderOnForeground: true,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x0f707070),
                          offset: Offset(0, 1),
                        )
                      ],
                      image: DecorationImage(image: NetworkImage(widget.meal!.image!), fit: BoxFit.fill)),
                      // image: DecorationImage(image: NetworkImage(posterPoster + widget.meal!.image!), fit: BoxFit.fill)),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  margin: const EdgeInsets.only(top: 10),
                  decoration: const BoxDecoration(
                      borderRadius:
                      BorderRadius.only(topRight: Radius.circular(8.0), bottomRight: Radius.circular(8.0)),
                      boxShadow: [
                        BoxShadow(
                          // offset: Offset(0, 1),
                          blurRadius: 2,
                          color: Color(0x0f707070),
                        )
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, bottom: 10.0, right: 4.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: Text(
                            widget.meal!.name!,
                            style: const TextStyle(fontSize: 25, color: Color(0xff333333), fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                            child: Text(
                              widget.meal!.desc!,
                              style: const TextStyle(fontSize: 15, color: Color(0xff333333), fontWeight: FontWeight.normal),
                            ),
                        ),
                        Text(
                          "ID :" + widget.meal!.id.toString(),
                          style: const TextStyle(fontSize: 13, color: Color(0xff666666)),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );

  }
}