import 'package:flutter/material.dart';
import 'package:fyp/pragmatic/orders_back.dart';
import 'package:fyp/res/Txt.dart';
import 'package:fyp/res/decor.dart';
import 'package:provider/provider.dart';
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';

class Orders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool updated = false;
    return Scaffold(
      body: Container(
        child: ChangeNotifierProvider(
          builder: (_)=>OrderBack(),
          child: Consumer<OrderBack>(
            builder: (context, orderBack,_){
              final orderBack = Provider.of<OrderBack>(context);
              if(!updated){
                updated=true;
                orderBack.update();
              }
              List icns = [
                Icon(Icons.local_dining),
                Icon(Icons.local_dining),
                Icon(Icons.local_dining),
                Icon(Icons.local_dining),
                Icon(Icons.local_dining),
                Icon(Icons.local_dining),
              ];
              List<TimelineModel> tm = [              ];
              for (var item in orderBack.allOrders){
                List<Widget> r = [];
                r.add(SizedBox(height: 30,));
                r.add(Txt(item[0][0][0]));
                for (var itm in item[0]) {
                  r.add(Txt(itm[1]+" x "+itm[2].toString()+" Rs. "+ (itm[2]*itm[3]).toString()  ));
                }
                r.add(SizedBox(height: 10,));
                tm.add(TimelineModel(
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: r,
                  ),
                  position: TimelineItemPosition.left,
                  icon: icns[item[0][0][2]],
                ));
              }
              return Container(
                child: Column(
                  children: <Widget>[
                    Txt('Orders', size: 20,),
                    SizedBox(height: 20,),
                    Container(
                      height: 35,
                      width: 200,
                      decoration: BoxDecor(color: Colors.blue,radius: 22),
                      child: FlatButton(
                        child: Txt("+ New Order?", color: Colors.white,),
                        onPressed: (){},
                      ),

                    ),
                    SizedBox(height: 20,),

                    Container(
                      height: MediaQuery.of(context).size.height-200,
                      child: tm.length>0? Timeline(
                        position: TimelinePosition.Left,
                        children: tm,
                      ):Center(child: Txt('Nothing ordered yet'),)
                    ),
                    Expanded(
                      child: SizedBox(),
                    )

                  ],
                )
                
              );
            }
          )
        ),
      ),
    );
  }
}