import 'package:fyp/src/login.dart';
import 'package:flutter/material.dart';
import 'package:fyp/res/dbServer.dart';

class Logout extends StatefulWidget {

  @override
  _LogoutState createState() => _LogoutState();
}

class _LogoutState extends State<Logout> {
  bool done = false; 

  void initState(){
    super.initState();
    var res =  DbServer().logout();
    res.then((value){
      setState(() {
        done = true;
      });
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body:Center(
          child: Container(
            height: 30,
            width: 30,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color.fromRGBO(33, 145, 106, 1)),
            ),
          ),
        ),
      ),
    );
  }
}