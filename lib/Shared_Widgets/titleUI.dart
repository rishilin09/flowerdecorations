import 'package:flutter/material.dart';

///Text will be shown with a stroke as provided
Widget titleUI(l, t, fontS, strokeW, titleString) {
  return Padding(
    padding: EdgeInsets.only(top: t, left: l),
    child: Stack(children: [
      Text(
        titleString,
        style: TextStyle(
            fontSize: fontS,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = strokeW
              ..color = Colors.black),
      ),
      Text(
        titleString,
        style: TextStyle(fontSize: fontS, color: Colors.white),
      ),
    ]),
  );
}
