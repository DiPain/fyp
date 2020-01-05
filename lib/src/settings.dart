import 'package:fyp/pragmatic/profile_back.dart';
import 'package:fyp/res/Txt.dart';
import 'package:fyp/res/dbServer.dart';
import 'package:fyp/res/decor.dart';
import 'package:fyp/src/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Settings extends StatelessWidget {
  bool updated=false;
  
  Widget btn(int i, BuildContext context){
    String btnText = '';
    MaterialPageRoute nextPage;
    switch (i) {
      case 0:
        btnText = 'upload';
        // nextPage = MaterialPageRoute(builder: (context)=>ImageUpload());
        break;
      case 1:
        btnText = 'update info';
        // nextPage = MaterialPageRoute(builder: (context)=>Update());
        break;
      case 2:
        btnText = 'History';
        // nextPage = MaterialPageRoute(builder: (context)=>Profile());
        break;
      case 3:
        btnText = 'logout';
        nextPage = MaterialPageRoute(builder: (context)=>Login());
        break;
       
      default:
        nextPage = MaterialPageRoute(builder: (context)=>Settings());
    }

    return Container(
      height: 60,
      width: 300,
      decoration: BoxDecor(color: Colors.blue, radius: 12),
      child: FlatButton(
      child: Txt(btnText,color: Colors.white,),
      onPressed: (){
        if(i==3){
          var res =  DbServer().logout();
          res.then((value){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));
          });
        }else{
          Navigator.push(context, nextPage);
        }
      },
    ),);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[

                ChangeNotifierProvider(
                  builder: (_)=>ProfileBack(),
                  child: Consumer<ProfileBack>(
                  builder: (context, logBack,_){
                    final profileBack = Provider.of<ProfileBack>(context);
                    if(!updated){
                      profileBack.update();
                      updated=true;
                    }
                    return Row(
                      children: <Widget>[
                      SizedBox(width: 50,),
                      Container(width: 40,
                      height: 40,child: Icon(Icons.person_outline),),
                      SizedBox(width: 20,),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Txt(DbServer.name),
                          Txt(DbServer.email),
                        ],
                      )
                    ],);
                  }
                )),
                
                SizedBox(height: 30,),
                SizedBox(height: 20,),
                btn(1,context),
                SizedBox(height: 20,),
                btn(2,context),
                SizedBox(height: 20,),
                btn(3,context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}