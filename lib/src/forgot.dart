import 'package:fyp/res/Txt.dart';
import 'package:fyp/res/decor.dart';
import 'package:fyp/src/login.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Forgot extends StatefulWidget {
  final String title;
  String err='';
  String email='';
  Forgot({Key key, this.title, this.err, this.email}) : super(key: key);
  
  @override
  _ForgotState createState() => _ForgotState(err = this.err, this.email);
}

class _ForgotState extends State<Forgot> {
  String err;
  String email;
  TextEditingController cont_email = TextEditingController();

  _ForgotState(this.err, this.email){
    cont_email.text = email;
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(25),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: cont_email,
                decoration: InDecor(hint: 'email'),
              ),
              SizedBox(height: 20,),
              Container(
                child: Txt(err, color: Colors.grey),
              ),
              SizedBox(height: 20,),
              Container(
                height: 60,
                width: 200,
                decoration: BoxDecor(
                  color: Color.fromRGBO(19, 97, 78, 1)
                ),
                child: FlatButton(
                  padding: EdgeInsets.all(0),
                  child: Txt('Send email', size: 20, color: Colors.white),
                  onPressed: (){
                    if(check(cont_email.text)){
                      Fluttertoast.showToast(
                        msg: "password has been sent to your email",
                        gravity: ToastGravity.BOTTOM
                      );
                      Navigator.pop(context);
                    }else{
                      setState(() {
                        err = 'the email is not registered to the company'; 
                      });
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  check(String email){
    if(email!=''){
      return true;
    }else{
      return false;
    }
  }
}