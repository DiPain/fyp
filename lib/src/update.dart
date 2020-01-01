import 'package:fyp/res/Txt.dart';
import 'package:fyp/res/dbServer.dart';
import 'package:fyp/res/decor.dart';
import 'package:fyp/src/login.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Update extends StatefulWidget{
  Update();
  _UpdateState createState() => _UpdateState();
}
class _UpdateState extends State<Update>{
  _UpdateState();
  double spaceBetween = 20;

  TextEditingController old = TextEditingController();
  TextEditingController nuu = TextEditingController();
  TextEditingController confirm = TextEditingController();
@override
  Widget build(BuildContext context) {
  DbServer().checkExists().then((value){
    if(value)
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));
  });
    return MaterialApp(
      home: Scaffold(
        body: Container(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                
                SizedBox(height: 20,),
                Container(
                  child: FlatButton(
                    child: Txt('back'),
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                
                SizedBox(height: 200,),
                Txt('Change Pass', fw: FontWeight.bold, size: 20,),
                SizedBox(height: 50,),
                TextField(
                  controller: old,
                  decoration: InDecor(
                    hint: 'old password'
                  ),
                ),
                SizedBox(height: spaceBetween,),
                TextField(
                  controller: nuu,
                  decoration: InDecor(
                    hint: 'new password'
                  ),
                ),
                SizedBox(height: spaceBetween,),
                TextField(
                  controller: confirm,
                  decoration: InDecor(
                    hint: 'confirm password'
                  ),
                ),
                SizedBox(height: spaceBetween,),
                Container(
                  child: FlatButton(
                    child: Text('submit'),
                    onPressed: (){
                      if(confirm.text==nuu.text){
                        var resu = DbServer().changePass(old.text, nuu.text);
                        resu.then((value){
                          if(value['success']=='true'){
                            Fluttertoast.showToast(
                              msg: "Successfully changed",
                              gravity: ToastGravity.BOTTOM
                            );
                          }else{
                            Fluttertoast.showToast(
                              msg: "change falied",
                              gravity: ToastGravity.BOTTOM
                            );
                          }
                        });
                      }
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
