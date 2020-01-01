import 'package:fluttertoast/fluttertoast.dart';
import 'package:fyp/pragmatic/home_back.dart';
import 'package:fyp/res/Txt.dart';
import 'package:fyp/res/dbServer.dart';
import 'package:fyp/res/decor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  Home({Key key,}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool loaded= false;
  
  @override
  Widget build(BuildContext context) {
    DbServer().getProfile().then((value){
      if(value==null){
        Fluttertoast.showToast(
          msg: "No Internet Connection",
          gravity: ToastGravity.BOTTOM,
        );
      }
    }); 

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Container(
            child: FlatButton(
              child: Stack(
                children: <Widget>[
                  Icon(Icons.notifications, color: Colors.white,),
                  Container(
                    height: 10,
                    width: 10,
                    margin: EdgeInsets.only(left: 15),
                    decoration: BoxDecor(radius: 5, color: Colors.red, borderColor: Colors.transparent),
                  )
                ],
              ),
              onPressed: (){
                // Navigator.push(context, 
                //   MaterialPageRoute(builder: (context)=>AllEvents()));
              },
            ),
          
          )
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Column(
          children: <Widget>[
            ChangeNotifierProvider(
              builder: (_)=>HomeBack(),
              child: Consumer<HomeBack>(
                builder: (context, logBack,_){
                  final homeBack = Provider.of<HomeBack>(context);
                  if(!loaded){
                    loaded=true;
                    homeBack.update();
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:<Widget>[
                      SizedBox(height: 10,),
                      Txt('Recommended', size: 20,),
                      SizedBox(height: 10,),

                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: homeBack.recommended,
                        ),
                      ),
                    
                      SizedBox(height: 10,),
                      Txt('MENU', size: 20),
                      SizedBox(height: 10,),

                      Container(
                        height: MediaQuery.of(context).size.height-444,

                        child: SingleChildScrollView(
                          child: Column(
                            children: homeBack.menu,
                          ),
                        ),
                      )
                    ] 
                  );
                }
              )
            ),
          ],
        ),
      ),
    );
  }
  
}
