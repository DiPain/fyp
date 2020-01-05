import 'package:flutter/material.dart';
import 'package:fyp/res/dbServer.dart';

class OrderBack with ChangeNotifier{
  List allOrders = [];
  update(){
    DbServer().getOrders().then((val){
      if(val!=null){
        print(val);
      }

    });
  }
}