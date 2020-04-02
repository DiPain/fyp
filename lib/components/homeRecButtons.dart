import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fyp/res/Txt.dart';
import 'package:fyp/res/dbServer.dart';

class RecommendButton extends StatelessWidget {
  var each;
  RecommendButton(this.each);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      decoration: BoxDecoration(
        border:Border.all(
          color: Colors.grey,
          width: 1,
        ),
        borderRadius: BorderRadius.all(Radius.circular(6)), ),
        child:LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return  FlatButton(
              padding: EdgeInsets.all(0),
              onPressed: (){
                DbServer().addtoTray(each['id'], 1);
                Fluttertoast.showToast(
                  msg: 'added foodId',
                  gravity: ToastGravity.CENTER
                );
              },
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: constraints.minHeight<150?10:40,
                    child:Container(
                    height: 40,
                    width: 40,
                    child: Icon(Icons.fastfood))
                  ),
                
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(),
                      SizedBox(),
                      Txt(each['name'].toString()),
                      Txt(each['price'].toString()),
                      SizedBox(),
                  ],)
                ],
              ),
            );
          }),
      );
  }
}