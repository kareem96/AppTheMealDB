

import 'package:flutter/material.dart';

class BottomTabs extends StatelessWidget{
  final IconData? icon;
  final String? text;
  final bool? isSelected;
  final Function? onPressed;

  const BottomTabs({this.icon, this.text, this.isSelected, this.onPressed, Key? key}):super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color _bottomTabColor = Color.fromRGBO(68, 65, 78,1);
    return GestureDetector(
      onTap: onPressed as void Function()?,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.fastOutSlowIn,
        height: 40.0,
        width: isSelected! ? 90.0 : 60.0,
        decoration: ShapeDecoration(
          shape: StadiumBorder(
            side: BorderSide(
              color: isSelected! ? Colors.white : Colors.transparent,
              width: 1.0
            )
          )
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Icon(
              icon,
              size: 24.0,
              color: Colors.black,
            ),
            isSelected! ? Text(
              text!,
              style: TextStyle(
                fontSize: 16.0,
                color: isSelected! ? Colors.white : _bottomTabColor,
                fontWeight: FontWeight.w600),
            ) :Container()
          ],
        ),
      ),
    );
  }
}