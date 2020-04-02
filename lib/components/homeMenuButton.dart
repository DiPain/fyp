import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fyp/res/Txt.dart';
import 'package:fyp/res/dbServer.dart';

class HomeMenuButton extends StatelessWidget {
  HomeMenuButton(this.val);
  var val;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
      itemCount: val.length,
      itemBuilder: (context, index){
        return Container(
          margin: EdgeInsets.only(bottom: 10),
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
                print('============');
                print(index);
                DbServer().addtoTray(val[index]['food_id'], 1);
                Fluttertoast.showToast(
                  msg: val[index]['food']['name']+' added',
                  gravity: ToastGravity.CENTER,
                  
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
                      Txt(val[index]['name'].toString()),
                      Txt(val[index]['price'].toString()),
                      SizedBox(),
                  ],)
                ],
              ),
            ),
          );}));
  }
}