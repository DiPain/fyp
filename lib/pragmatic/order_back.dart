import 'package:flutter/material.dart';
import 'package:fyp/res/Txt.dart';
import 'package:fyp/res/dbServer.dart';

class OrderBack with ChangeNotifier{
    List<Widget> tray=[SizedBox()];

    update(){
      if(DbServer.tray.length>0){
        tray=[];
      }
      for (var item in DbServer.tray) {
        tray.add(
          Container(
            decoration: BoxDecoration(
              border:Border.all(
                color: Colors.grey,
                width: 1,
              ),
            ),
            child: Row(
              children: <Widget>[
                Container(
                  height: 40,
                  width: 40,
                  child: Icon(Icons.fastfood)),
                Column(

                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    SizedBox(),
                    SizedBox(),
                    Txt(item[0].toString()),
                    Txt(item[0].toString()),
                    SizedBox(),
                ],)
              ],
            ),

          )
        );
        tray.add(SizedBox(height: 10));
      }
    }

    

}