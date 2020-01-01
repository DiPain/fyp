import 'package:fyp/res/dbServer.dart';
import 'package:fyp/src/home.dart';
import 'package:fyp/src/orders.dart';
import 'package:fyp/src/settings.dart';
import 'package:flutter/material.dart';

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

  BottomNavigationBar bottomNavBar(int currentPage){
    
    List icons = [
      Icon(Icons.table_chart),
      Icon(Icons.fastfood,),
      Icon(Icons.person_outline,),
    ];

    List <BottomNavigationBarItem> items = [];
      for(int i=0; i<3; ++i){
        items.add(BottomNavigationBarItem(
          icon: icons[i],
          title: Text(''),
      ));
    }

    return BottomNavigationBar(
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey,
      items: items,
      iconSize: 25,
      selectedFontSize: 0,
      unselectedFontSize: 0,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      elevation: 20,
      currentIndex: currentPage,
      onTap: (int inn){
        setState(() {
         index = inn; 
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
  int currentPage = index;

    List pages = [
      Orders(),
      Home(),
      Settings(),
    ];
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: Scaffold(
        body: pages[currentPage],
        bottomNavigationBar: bottomNavBar(currentPage),
        
      ),
    );
  }
}

