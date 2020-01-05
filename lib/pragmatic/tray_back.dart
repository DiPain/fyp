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
    for (var item in DbServer.tray){
      total +=  DbServer.menu[item[0]]['price']*item[1];
      notifyListeners();
    }
  }
}