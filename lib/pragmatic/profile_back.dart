import 'package:flutter/material.dart';
import 'package:fyp/res/dbServer.dart';

class ProfileBack with ChangeNotifier{
  update(){
    DbServer().getProfile().then((val){
      if(val!=null){
        if(val['success']=='true'){
          DbServer.name=val['name'];
          DbServer.email=val['email'];
        }
      }
      notifyListeners();
    });
  }
}