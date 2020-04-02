import 'package:flutter/material.dart';
import 'package:fyp/res/dbServer.dart';

class TrayBack with ChangeNotifier{
  double total = 0;
  addQty(int index, bool add){
    add?
      DbServer.tray[index][1]+=1:
      DbServer.tray[index][1]-=1;
    notifyListeners();
    getTotal();
  }

  getTotal(){
    total = 0;
    for (var m in DbServer.menu){
      for (var item in DbServer.tray){
        if(m['id']==item[0]){
          total +=  m['price']*item[1];
        }
      }
    }
  }
  food(int food_id){
    for(var m in DbServer.menu){
      if(m['id']==food_id){
        return m; 
      }
    }
    return 'false food';
  }
}