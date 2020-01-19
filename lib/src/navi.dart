import 'package:fluttertoast/fluttertoast.dart';
import 'package:fyp/pragmatic/navi_back.dart';
import 'package:fyp/pragmatic/tray_back.dart';
import 'package:fyp/res/Txt.dart';
import 'package:fyp/res/dbServer.dart';
import 'package:fyp/res/decor.dart';
import 'package:fyp/src/home.dart';
import 'package:fyp/src/orders.dart';
import 'package:fyp/src/transactions.dart';
import 'package:fyp/src/tray.dart';
import 'package:fyp/src/settings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Navi extends StatefulWidget {
  Navi({Key key, this.title, this.index=1}) : super(key: key);
  final String title;
  int index;

  @override
  _NaviState createState() => _NaviState( this.index);
}

class _NaviState extends State<Navi> {
  int index;
  _NaviState(this.index){
    print('=====Navi====='); 
    print(DbServer.token);
  }

  // BottomNavigationBar bottomNavBar(_naviBack){
    
    // List icons = [
    //   Icon(Icons.table_chart),
    //   Icon(Icons.fastfood,),
    //   Icon(Icons.person_outline,),
    // ];

  //   List <BottomNavigationBarItem> items = [];
  //     for(int i=0; i<3; ++i){
  //       items.add(BottomNavigationBarItem(
  //         icon: icons[i],
  //         title: Text(''),
  //     ));
  //   }

  //   return BottomNavigationBar(
  //     selectedItemColor: Colors.black,
  //     unselectedItemColor: Colors.grey,
  //     items: items,
  //     iconSize: 25,
  //     selectedFontSize: 0,
  //     unselectedFontSize: 0,
  //     type: BottomNavigationBarType.fixed,
  //     backgroundColor: Colors.white,
  //     elevation: 20,
  //     currentIndex: _naviBack.index,
  //     onTap: (int inn){
  //       _naviBack.changeTab(inn);
  //     },
  //   );
  // }

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
    List pages = [
      ['Home', Icons.home, Home(),],
      ['Tray', Icons.add_box, Tray(),],
      ['Orders', Icons.add_box, Orders(),],
      ['Payments', Icons.add_box, Transactions(),],
      ['Settings', Icons.settings, Settings(),],
    ];

    final GlobalKey<ScaffoldState> _scafKey = new GlobalKey<ScaffoldState>();

    return ChangeNotifierProvider(
      builder: (_)=>NaviBack(),
      child: Consumer<NaviBack>(
        builder: (context, naviBack,_){
        final naviBack = Provider.of<NaviBack>(context);

          return Scaffold(
            key: _scafKey,
            drawer: Drawer(
              child: Container(
                child: ListView.builder(
                  itemCount: pages.length+1,
                  itemBuilder: (context, i){
                    if(i==0){
                      return Container(
                        height: 150,
                        width: 100,
                        child: SizedBox(),
                      );
                    }else{
                      return Container(
                        margin: EdgeInsets.only(left: 0),
                        child: FlatButton(
                          child: Row(children: <Widget>[
                            Icon(pages[i-1][1], color: Colors.grey,),
                            Txt(pages[i-1][0]),
                            Expanded(
                              child: SizedBox(),
                            )
                            ]),
                          onPressed: (){
                            naviBack.changeTab(i-1);
                            print('should change');
                            Navigator.popAndPushNamed(context, '/home');
                          },
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
            appBar: AppBar(
              
              // leading: Container(
              //   width: 30,
              //   padding: EdgeInsets.all(0),
              //   margin: EdgeInsets.all(0),
              //   child: IconButton(
              //     padding: EdgeInsets.all(0),
              //   icon: Icon(Icons.menu,color: Colors.white,),
              // ),),
              title: Container(
                width: 300,
                padding: EdgeInsets.all(0),
                margin: EdgeInsets.all(0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecor(
                      radius: 22
                    ),
                    child: Icon(Icons.person_outline, color: Colors.blue,),),
                    SizedBox(width: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Txt(DbServer.name,color: Colors.white,),
                      Txt(DbServer.email, fw: FontWeight.w300,size: 12,color: Colors.white,),
                    ],
                  )
                ],),
              ),
              actions: <Widget>[
                Container(
                  width: 30,
                  child: FlatButton(
                    padding: EdgeInsets.all(0),
                    child: Stack(
                      children: <Widget>[
                        Icon(Icons.notifications, color: Colors.white,),
                        Container(
                          height: 10,
                          width: 10,
                          margin: EdgeInsets.only(left: 15),
                          decoration: BoxDecor(radius: 5, color: Colors.red, borderColor: Colors.transparent),
                        ),
                      ],
                    ),
                    onPressed: (){
                      // Navigator.push(context, 
                      //   MaterialPageRoute(builder: (context)=>AllEvents()));
                    },
                  ),
                ),
                
                Container(
                  width: 30,
                  height: 30,
                  margin: EdgeInsets.only(right: 15,left: 10),
                  child: FlatButton(
                    padding: EdgeInsets.all(0),
                    child: Icon(Icons.add_box, color: Colors.white,),
                    onPressed: (){
                      // Navigator.push(context, 
                      //    MaterialPageRoute(builder: (context)=>Tray()));
                      _scafKey.currentState.openEndDrawer();
                    },
                  ),
                )
              ],
            ),

            endDrawer: Drawer(
              
              child: Container(
                child: ChangeNotifierProvider(
                  builder: (_)=>TrayBack(),
                  child: Consumer<TrayBack>(
                    builder: (context, trayBack,_){
                      final trayBack = Provider.of<TrayBack>(context);
                      print("DbServer.tray");
                      print(DbServer.tray);
                      trayBack.getTotal();
                      return Container(
                        child: Stack(
                          children: <Widget>[
                            ListView.builder(
                              itemCount: DbServer.tray.length+1,
                              itemBuilder: (context, intex){
                                  print(intex);print('intex');

                                if(intex==0){
                                  return Container(
                                    height: 70,
                                    child: FlatButton(
                                      onPressed: (){
                                        naviBack.changeTab(1);
                                        Navigator.popAndPushNamed(context, '/newroute');
                                      },
                                      child: Txt('Tray', size: 20),
                                    ),
                                  );
                                }else{
                                  print(trayBack.food(DbServer.tray[intex-1][0]) );
                                  print(trayBack.food(DbServer.tray[intex-1][0]) ['food']['name']);
                                  return Container(
                                    padding: EdgeInsets.only(right:20, left: 10),
                                    decoration: BoxDecor(radius: 0),
                                    child: FlatButton(
                                      onPressed: (){
                                        naviBack.changeTab(naviBack.index);
                                        trayBack.addQty(intex-1, true);},
                                      child: Row(children: <Widget>[
                                        Icon(Icons.fastfood),
                                        Txt('x',fw: FontWeight.w300),
                                        Txt(DbServer.tray[intex-1][1].toString(), size: 30,fw: FontWeight.w300,),
                                        SizedBox(width: 10,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Txt((trayBack.food(DbServer.tray[intex-1][0]) ['food']['name']),fw: FontWeight.w300, size: 20,),
                                          Txt((trayBack.food(DbServer.tray[intex-1][0]) ['price']).toString() )
                                        ],),
                                        Expanded(child: SizedBox(),),
                                        Txt('Rs.', fw:FontWeight.w300),
                                        Txt(((trayBack.food(DbServer.tray[intex-1][0]) ['price'])*DbServer.tray[intex-1][1]).toString(), size: 20,fw:FontWeight.w300 ),
                                        
                                      ],),
                                    )
                                  );
                                }
                              },
                            ),
                            Positioned(
                              bottom: 10,
                              left: 10,
                              child: Column(
                                children: [
                                  Row(
                                    children: <Widget>[
                                      Txt('Total:', fw: FontWeight.w300,size: 20,),  
                                      SizedBox(width: MediaQuery.of(context).size.width-300,),
                                      Txt(trayBack.total.toString(),fw: FontWeight.w300,size: 20,)
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  Container(
                                    height: 44,
                                    width: MediaQuery.of(context).size.width-125>300?300:MediaQuery.of(context).size.width-125,
                                    decoration: BoxDecor(color: Colors.blue,
                                    radius: 22),
                                      child: Center(child: Txt('ORDER', fw: FontWeight.w300,))),
                                ]
                              ),
                            )
                          ]
                        ),
                      );
                    }
                  )
                )
              ),
            ),
            body: pages[naviBack.index][2]);
              // bottomNavigationBar: bottomNavBar(naviBack),
          }
        )
    );
  }
}

