
import 'package:fyp/res/Txt.dart';
import 'package:fyp/res/decor.dart';
import 'package:flutter/material.dart';

class Searched extends StatefulWidget {
  List policies=[];
  Searched(this.policies);
  @override
   _SearchedState createState() =>  _SearchedState(this.policies);
}

class  _SearchedState extends State <Searched> {
  List policies=[];
  _SearchedState(this.policies);
  TextEditingController txe = TextEditingController();
  @override
  Widget build(BuildContext context) {
    List <Widget> widgets = [
      Container(
          child: TextField(
            controller: txe,
            
          ),
      ),
    ];
    for (var item in policies) {
      widgets.add(Txt(item['category'], fw: FontWeight.bold,));
      for (var it in item['details']) {
        widgets.add(Txt(it['details'],)); 
      }
    }
    return Container(
      child: Column(
        children: widgets,
      ),
    );
  }
}

