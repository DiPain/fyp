import 'package:flutter/material.dart';
import 'package:fyp/res/dbServer.dart';

class PayBack with ChangeNotifier{
  List allOrders = [];
  update(){
    DbServer().getPayments().then((val){
      if(val!=null){
        allOrders=[];
        print("val");
        print(val);
        int order_id = 0;
        List each = [];
        int status = 0;
        int i = 0;
        for (var item in val){
          i++;
          print("item");
          print(item);
          if(order_id != item['order_id']){
            print('object');
            print(each.length);
            if(each.length>0){
              print('here');
              allOrders.add([each, status, ]);
            }
            order_id==item['order_id'];
            each=[];
          }
          each.add([
            item['created_at'],
            item['food']['name'],
            item['quantity'],
            item['price'],
            item['status'],
          ]);
          if(status< item['status']){
            status = item['status'];
          }
          print("i");
          print(i);
          if(i==val.length){
          print("in herer");

            allOrders.add([each, status, ]);
          }
        }
        print('object-----------');
        print(allOrders);
        
      }
      notifyListeners();
    });
  }
}