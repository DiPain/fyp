import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fyp/components/homeMenuButton.dart';
import 'package:fyp/res/Txt.dart';
import 'package:fyp/res/dbServer.dart';

StreamController<double> controller = StreamController.broadcast();

class Recommendations extends StatefulWidget{
  List<Widget> recommended;
  Widget menu;
  Recommendations( this.recommended, this.menu){
    print("constr===========");
    print(recommended);
    print(menu);
  }

  @override
  _RecommendationsState createState() => _RecommendationsState(this.recommended, this.menu);
}

class _RecommendationsState extends State<Recommendations>  {
  _RecommendationsState(this.recommended, this.menu){
    print("in state menu======");
    print(recommended);
    print(menu);

  }
  
  List<Widget> recommended;
  Widget menu;
  double position;
  @override
  Widget build(BuildContext context) {
    double height= 200;
    double prevPosi= 0;
    print("inrec======");
    print(recommended);
    print(DbServer.menu);


    return StreamBuilder(
      stream: controller.stream,
      builder:(context,snapshot) => GestureDetector(
        onVerticalDragUpdate: (DragUpdateDetails details){

          position = MediaQuery.of(context).size.height- details.globalPosition.dy;
          controller.add(position);
          if(prevPosi!=0){
            height = height+(prevPosi-position);
          }
          prevPosi = position;
          height= height>70?height:70;
          height= height<200?height:200;
        },
        behavior: HitTestBehavior.translucent,
          child:
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                SizedBox(height: 10,),
                Txt('Recommended', size: 20,),
                SizedBox(height: 10,),

                Container(
                  height: height,
                  width: double.infinity,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: recommended,
                    ),
                  ),
                ),

                Container(
                  height: MediaQuery.of(context).size.height-250-height,
                  child:  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 20,),
                        Txt('Menu', size: 20),
                        SingleChildScrollView(
                          
                        child:
                          Container(
                            height: MediaQuery.of(context).size.height-300-height,
                            padding: EdgeInsets.all(20),
                            child: DbServer.menu.length>0?HomeMenuButton(DbServer.menu):SizedBox(),
                          ))
                      ],
                    ),
                )
              ],
            ),
          ),
    );
  }
}