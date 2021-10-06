import 'package:flutter/material.dart';


class ShowMoreText extends StatefulWidget {
  final String? text;

  const ShowMoreText({this.text, Key? key}) : super(key: key);

  @override
  _ShowMoreTextState createState() => _ShowMoreTextState();
}

class _ShowMoreTextState extends State<ShowMoreText> {
  String? firstHalf, secondHalf;
  bool flag = true;
  TextStyle style = const TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w600, height: 1.5);

  @override
  void initState() {
    super.initState();
    if (widget.text!.length > 100) {
      firstHalf = widget.text!.substring(0, 100);
      secondHalf = widget.text!.substring(100);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf!.isEmpty
          ? Text(firstHalf!,style: style,)
          : Column(
        children: [
          Text(flag ? (firstHalf! + "...") : (firstHalf! + secondHalf!),style: style,),
          InkWell(
            onTap: () {
              setState(() {
                flag = !flag;
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  flag ? "show more" : "show less",
                  style: const TextStyle(color: Colors.blue),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
