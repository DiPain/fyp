import 'dart:convert';
import 'package:http/http.dart';
import 'package:fyp/res/Txt.dart';
import 'package:fyp/src/navi.dart';
import 'package:fyp/res/decor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fyp/src/forgot.dart';
import 'package:fyp/res/dbServer.dart';
import 'package:fyp/pragmatic/log_back.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  Login({Key key, this.title, this.err}) : super(key: key);
  final String title;
  String err='';
  @override
  _LoginState createState() => _LoginState(err = this.err);
}

class _LoginState extends State<Login> {
  String err='';
  _LoginState(this.err);

  String condition = '';

  TextEditingController cont_user = TextEditingController();
  TextEditingController cont_pass = TextEditingController();

  void initState(){
    super.initState();
  }
  
  remember(String token) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('token', token);
  }

  @override
  Widget build(BuildContext context) {
    return loginPage();
  }

  Widget loginPage(){
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(25),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 40,),
                TextField(
                  controller: cont_user,
                  decoration: InDecor(hint: 'user', suffix: '@islingtoncollege.edu.np'),
                ),
                SizedBox(height: 20,),
                TextField(
                  controller: cont_pass,
                  decoration: InDecor(hint: 'password'),
                  obscureText: true,
                ),
                SizedBox(height: 40,),
                Container(
                  child: Txt(err, color: Colors.grey),
                ),
                SizedBox(height: 20,),
                ChangeNotifierProvider(
                  builder: (_)=>LogBack(),
                  child: Consumer<LogBack>(
                    builder: (context, logBack,_){
                      final logBack = Provider.of<LogBack>(context);
                      return Container(
                        height: 44,
                        width: MediaQuery.of(context).size.width-100,
                        decoration: BoxDecor(
                          color: Colors.blue,
                          radius: 22,
                        ),
                        child: FlatButton(
                          padding: EdgeInsets.all(0),
                          child: logBack.loading?Container(child: Container(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 4,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),)),) :Txt('Login', size: 20,color: Colors.white),
                          onPressed: (){
                            logBack.changeStatus(true);
                            check(cont_user.text, cont_pass.text).then((var value){
                              print(value);
                              if(value==null){
                                logBack.changeStatus(false);
                                setState(() {
                                err='Could not connect to server'; 
                                });
                              }else if(value['result']=='success'){
                                remember(value['token']);
                                DbServer.token=value['token'];
                                DbServer().pushPlayId(DbServer.playerId);
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Navi()));
                              }else {
                                logBack.changeStatus(false);
                                setState(() {
                                err='the Credential does not match the database'; 
                                });
                              }
                            });
                          },
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  child: FlatButton(
                    padding: EdgeInsets.all(0),
                    child: Text('Forgot Password'),
                    onPressed: (){
                      condition = 'pushed';
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Forgot(email: cont_user.text,)));
                    },
                  ),
                ),
                Txt(DbServer().getServer(), color: Colors.grey,)
              ],
            ),
          ),
        ),
      ),
    );
  }

  validate(String email, String pass){
    if(email!='' || pass!=''){
      return check(email, pass);    
    }else{
      return false;
    }
  }

  check(String email, String pass) async{
    String bod = '{"email":"'+email+'@islingtoncollege.edu.np","password":"'+pass+'" }';
    // String bod = '{"email":"deepan@islingtoncollege.edu.np","password":"secret" }';
    print(bod);
    Response response = await post(DbServer().getServer()+'/api/login', headers: DbServer().getHeader(), body: bod);
    var res =  json.decode(response.body); 
    return res;
  }
}
