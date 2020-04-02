import 'package:flutter/material.dart';

class TopBar extends PreferredSize {
  int index = 0;
  TopBar(this.index);
  
  @override
  Widget build(BuildContext context) {
    List<AppBar> appBars = [
      
    ];
    return PreferredSize(
      child: Container(
        width: double.infinity,
        height: 100,
        color: Colors.black,
      ),
    );
  }
}