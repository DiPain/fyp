import 'package:flutter/material.dart';
import 'package:fyp/res/dbServer.dart';

class OrderButton with ChangeNotifier{
  bool loading = false;
  changeLoading(bool l){
    loading = l;
    notifyListeners();
  }
  order(){
    DbServer().order().then((val){
      print('-=-=-=-=-=-');
      loading = false;
      print(val);
      notifyListeners();
    });
  }
}