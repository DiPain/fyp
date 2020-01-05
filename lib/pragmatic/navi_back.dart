import 'package:flutter/material.dart';

class NaviBack with ChangeNotifier{
  int index = 0;
  changeTab(int ind){
    index= ind;
    notifyListeners();
  }
}