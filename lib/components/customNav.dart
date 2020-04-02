import 'package:flutter/material.dart';
import 'package:fyp/res/Txt.dart';
import 'package:fyp/res/decor.dart';
class LabelNav extends StatelessWidget {
  LabelNav(this.title);
  String title = "";
  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              PreferredSize(
                preferredSize: Size.fromHeight(20),
                child:AppBar(
                  title: Text(""),
                  elevation: 0,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 70),
                decoration: BoxDecor(
                  color: Colors.white,
                  radius: 16
                ),
                height: 80,
              ),
              Positioned(
                top: 45,
                width: MediaQuery.of(context).size.width,
                child:Center(
                  child: Container(
                    width: 180,
                    height: 40,
                    decoration: BoxDecor(
                      radius: 8,
                      color: Colors.white,
                      borderColor: Colors.transparent
                    ),
                    child:Center(child: Txt(title, size: 22,)),
                  ),
                ),
              )
            ],
          )
        ],);
  }
}