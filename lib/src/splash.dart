import 'dart:async';

import 'package:fyp/res/Txt.dart';
import 'package:fyp/res/dbServer.dart';
import 'package:fyp/res/logout.dart';
import 'package:fyp/src/home.dart';
import 'package:fyp/src/login.dart';
import 'package:fyp/src/navi.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splas extends StatefulWidget{
  _SplasState createState() => _SplasState();
}
class _SplasState extends State<Splas>{
  bool connecting = true;
  bool pushed = false;
  @override
  void initState(){
    super.initState();
    remembered();
    slowNet();
  }

  slowNet() async{
    Timer(Duration(seconds: 20),(){
      if(!pushed){
        Fluttertoast.showToast(
          msg: 'Check internet connection',
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_LONG,
        );
      }
    });
  }

  remembered() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString('token');
    if(token != null && token!=''){
      DbServer.token= token;
      print('remembered');
      DbServer().getProfile().then((val){
        print(val);
        if(val==null){
          print('null');

          setState(() {
            connecting = false;
          });
        }else if(val['success']=='true'){
          print(val);

          pushed = true;
          DbServer.name=val['name'];
          DbServer.email=val['email'];
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Navi()));
        }else if(val['success']=='false'){
          print('false');

          pushed = true;
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));
        }
      }).catchError((e){
        print('=============');
        print(e);
        setState(() {
          connecting=false;
        });
      });
    }else{
      pushed = true;
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));
    }
  }

  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Container(
            height: 30,
            width: 30,
            child:connecting? CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color.fromRGBO(33, 145, 106, 1)),
            ): Column(
              children: <Widget>[
                Txt('Failed to connect to server'),
                Container(
                  width: 200,
                  height: 44,
                  child: FlatButton(
                    padding: EdgeInsets.all(0),
                    child: Txt('Try Again'),
                    onPressed: (){
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Splas()));
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
