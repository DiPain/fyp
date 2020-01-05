import 'package:fluttertoast/fluttertoast.dart';
import 'package:fyp/pragmatic/home_back.dart';
import 'package:fyp/res/Txt.dart';
import 'package:fyp/res/dbServer.dart';
import 'package:fyp/res/decor.dart';
import 'package:flutter/material.dart';
import 'package:fyp/src/settings.dart';
import 'package:fyp/src/tray.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  Home({Key key,}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool loaded= false;
  int page = 1;
  
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
    print(DbServer.token);
    List pages = [
      ['Home', Icons.add_box, Home(),],
      ['Tray', Icons.add_box, Tray(),],
      ['Settings', Icons.add_box, Settings(),],
    ];

    final GlobalKey<ScaffoldState> _scafKey = new GlobalKey<ScaffoldState>();

    return Scaffold(
      // key: _scafKey,
      // drawer: Drawer(

        
      //   child: Container(
      //     color: Colors.green,
      //     child: ListView.builder(
      //       itemCount: pages.length+1,
      //       itemBuilder: (context, index){
      //         if(index==0){
      //           return Container(
      //             height: 100,
      //             width: 100,
      //             child: SizedBox(),
      //           );
      //         }else{
      //           return Container(
      //             child: FlatButton(
      //               child: Txt(pages[index-1][0]),
      //               onPressed: (){
      //                 setState(() {
      //                   page = index-1;
      //                 });
      //               },
      //             ),
      //           );
      //         }
      //       },
      //     ),
      //   ),
      // ),
      // appBar: AppBar(
        
      //   // leading: Container(
      //   //   width: 30,
      //   //   padding: EdgeInsets.all(0),
      //   //   margin: EdgeInsets.all(0),
      //   //   child: IconButton(
      //   //     padding: EdgeInsets.all(0),
      //   //   icon: Icon(Icons.menu,color: Colors.white,),
      //   // ),),
      //   title: Container(
      //     width: 300,
      //     padding: EdgeInsets.all(0),
      //     margin: EdgeInsets.all(0),
      //     child: Row(
      //       crossAxisAlignment: CrossAxisAlignment.center,
      //       children: <Widget>[
      //       Container(
      //         width: 40,
      //         height: 40,
      //         decoration: BoxDecor(
      //           radius: 22
      //         ),
      //         child: Icon(Icons.person_outline, color: Colors.blue,),),
      //         SizedBox(width: 10,),
      //       Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         children: <Widget>[
      //           Txt(DbServer.name,color: Colors.white,),
      //           Txt(DbServer.email, fw: FontWeight.w300,size: 12,color: Colors.white,),
      //         ],
      //       )
      //     ],),
      //   ),
      //   actions: <Widget>[
      //     Container(
      //       width: 30,
      //       child: FlatButton(
      //         padding: EdgeInsets.all(0),
      //         child: Stack(
      //           children: <Widget>[
      //             Icon(Icons.notifications, color: Colors.white,),
      //             Container(
      //               height: 10,
      //               width: 10,
      //               margin: EdgeInsets.only(left: 15),
      //               decoration: BoxDecor(radius: 5, color: Colors.red, borderColor: Colors.transparent),
      //             ),
      //           ],
      //         ),
      //         onPressed: (){
      //           // Navigator.push(context, 
      //           //   MaterialPageRoute(builder: (context)=>AllEvents()));
      //         },
      //       ),
      //     ),
          
      //     Container(
      //       width: 30,
      //       height: 30,
      //       margin: EdgeInsets.only(right: 15,left: 10),
      //       child: FlatButton(
      //         padding: EdgeInsets.all(0),
      //         child: Icon(Icons.add_box, color: Colors.white,),
      //         onPressed: (){
      //           // Navigator.push(context, 
      //           //    MaterialPageRoute(builder: (context)=>Tray()));
      //           _scafKey.currentState.openEndDrawer();
      //         },
      //       ),
      //     )
      //   ],
      // ),

      // endDrawer: Drawer(
        
      //    child: Container(
      //      height: 20,
      //      width: 20,
      //      color: Colors.blue,
      //      child: SizedBox(),
      //    ),
      // ),
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
                        height: MediaQuery.of(context).size.height-390,
                        child: homeBack.menu,
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
