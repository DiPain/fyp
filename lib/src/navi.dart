import 'package:fluttertoast/fluttertoast.dart';
import 'package:fyp/components/customNav.dart';
import 'package:fyp/components/top_bar.dart';
import 'package:fyp/pragmatic/navi_back.dart';
import 'package:fyp/pragmatic/tray_back.dart';
import 'package:fyp/res/Txt.dart';
import 'package:fyp/res/dbServer.dart';
import 'package:fyp/res/decor.dart';
import 'package:fyp/src/TestPage.dart';
import 'package:fyp/src/home.dart';
import 'package:fyp/src/orders.dart';
import 'package:fyp/src/transactions.dart';
import 'package:fyp/src/tray.dart';
import 'package:fyp/src/settings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Navi extends StatefulWidget {
  Navi({Key key, this.title, this.index=0}) : super(key: key);
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
    final GlobalKey<ScaffoldState> _scafKey = new GlobalKey<ScaffoldState>();

    List appBars = [
      PreferredSize(
        preferredSize: Size.fromHeight(130),
        child: Container(
          height: 200,
          width: 200,
          color: Colors.blue,
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
            PreferredSize(
              preferredSize: Size.fromHeight(20),
              child:AppBar(
                title: Text(""),
                elevation: 0,
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 20),
              child:  Txt("You Hungry?", size: 22, color: Colors.white,),
            ),
            Container(
              height: 40,
              decoration: BoxDecor(
                color: Colors.white,
                radius: 20
              ),
            )
          ],)
        ),
      ),

      PreferredSize(
      preferredSize: Size.fromHeight(150),
      child: 
      LabelNav("TRAY"),),
      LabelNav("Orders"),
      LabelNav("Payments"),
      LabelNav("Settings"),
      LabelNav("TestPage"),
      
    ];

    List pages = [
      ['Home', Icons.home, Home(),],
      ['Tray', Icons.add_box, Tray(),],
      ['Orders', Icons.add_box, Orders(),],
      ['Payments', Icons.add_box, Transactions(),],
      ['Settings', Icons.settings, Settings(),],
      ['TestPage', Icons.settings, TestPage(),],
    ];


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
                            Navigator.popAndPushNamed(context, '/home');
                          },
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
            appBar: appBars[naviBack.index],

            endDrawer: Drawer(
              
              child: Container(
                child: ChangeNotifierProvider(
                  builder: (_)=>TrayBack(),
                  child: Consumer<TrayBack>(
                    builder: (context, trayBack,_){
                      final trayBack = Provider.of<TrayBack>(context);
                      trayBack.getTotal();
                      print("in navi tray=============== =====");
                      print(DbServer.tray);
                      print("in navi tray=============== =====");
                      return Container(
                        child: Stack(
                          children: <Widget>[
                            ListView.builder(
                              itemCount: DbServer.tray.length+1,
                              itemBuilder: (context, intex){
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
                                          Txt((trayBack.food(DbServer.tray[intex-1][0]) ['name']),fw: FontWeight.w300, size: 20,),
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

