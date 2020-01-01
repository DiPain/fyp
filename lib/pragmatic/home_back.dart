import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fyp/res/Txt.dart';
import 'package:fyp/res/dbServer.dart';
import 'package:fyp/res/decor.dart';

class HomeBack with ChangeNotifier{
  List<Widget> menu=[SizedBox()];
  List<Widget> recommended=[SizedBox()];
  update(){
    DbServer().getMenu().then((val){
      if(val!=null){
        if(val.length!='failed'){
          menu=[];
          for (var each in val){
            print(each);
            menu.add(Container(
              width: double.infinity,
              height:  60,
              decoration: BoxDecoration(
                border:Border.all(
                  color: Colors.grey,
                  width: 1,
                ),
                borderRadius: BorderRadius.all(Radius.circular(6)), ),
                child: FlatButton(
                  padding: EdgeInsets.all(0),
                  onPressed: (){
                    DbServer().addtoTray(each['foodId'], each['quantity']);
                    Fluttertoast.showToast(
                      msg: 'added foodId',
                      gravity: ToastGravity.CENTER
                    );
                   },
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
                          Txt(each['food_id'].toString()),
                          Txt(each['price'].toString()),
                          SizedBox(),
                      ],)
                    ],
                  ),
                ),
              ));
              menu.add(SizedBox(height: 10,));

              recommended.add(Container(
              width: 120,
              height:  200,
              decoration: BoxDecoration(
                border:Border.all(
                  color: Colors.grey,
                  width: 1,
                ),
                borderRadius: BorderRadius.all(Radius.circular(6)), ),
                child: FlatButton(
                  padding: EdgeInsets.all(0),
                  onPressed: (){
                    DbServer().addtoTray(each['foodId'], each['quantity']);
                    Fluttertoast.showToast(
                      msg: 'added foodId',
                      gravity: ToastGravity.CENTER
                    );
                   },
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 40,
                        child:Container(
                        height: 40,
                        width: 40,
                        child: Icon(Icons.fastfood))),
                      Column(

                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(),
                          SizedBox(),
                          Txt(each['food_id'].toString()),
                          Txt(each['price'].toString()),
                          SizedBox(),
                      ],)
                    ],
                  ),
                ),
              ));
              recommended.add(SizedBox(width: 20,));
            }
          }

        }
        notifyListeners();
    });
  }
}