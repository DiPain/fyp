import 'package:flutter/material.dart';

class Txt extends Text{
  String data;
  Color color;
  double size, ln;
  Txt(this.data,{
    double size = 16, 
    FontWeight fw = FontWeight.w300, 
    String font='OpenSans', 
    Color color = Colors.black, 
    double ln =0, 
    TextDecoration under = TextDecoration.none 
  }):super((data==null?'':data), style: TextStyle(
    color: color,
    fontFamily: font,
    fontSize: size,
    fontWeight: fw,
    letterSpacing: ln,
    decoration: under,
  ));

}

