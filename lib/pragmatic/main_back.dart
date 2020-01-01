import 'package:flutter/cupertino.dart';

class MainBack with ChangeNotifier{
  String token = "";
  bool connection = false;

  setToken(String token){
    this.token = token;
    notifyListeners();
  }
  connState(bool stat){
    this.connection = stat;
    notifyListeners();
  }
}