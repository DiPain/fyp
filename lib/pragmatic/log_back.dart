import 'package:flutter/material.dart';
import 'package:fyp/res/dbServer.dart';

class LogBack with ChangeNotifier{
  bool logged = false;
  bool loading = false;

  changeStatus(bool s){
    loading  = s;
    notifyListeners();
  }
  changeLogged(bool s){
    logged  = s;
    notifyListeners();
  }
  login(){
    DbServer().login().then((val){
      if(val!=null){
        if(val['result']=="success"){
          DbServer.token=val['token'];
        }
      }
    });
  }
}