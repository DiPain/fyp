import 'package:flutter/material.dart';
import 'package:fyp/pragmatic/orders_back.dart';
import 'package:fyp/pragmatic/pay_back.dart';
import 'package:fyp/res/Txt.dart';
import 'package:provider/provider.dart';
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';

class Transactions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool updated = false;
    return Scaffold(
      body: Container(
        child: ChangeNotifierProvider(
          builder: (_)=>PayBack(),
          child: Consumer<PayBack>(
            builder: (context, payBack,_){
              final payBack = Provider.of<PayBack>(context);
              if(!updated){
                updated=true;
                payBack.update();
              }
              List icns = [
                Icon(Icons.local_dining),
                Icon(Icons.local_dining),
                Icon(Icons.local_dining),
                Icon(Icons.local_dining),
                Icon(Icons.local_dining),
                Icon(Icons.local_dining),
              ];
              List<TimelineModel> tm = [];
              for (var item in payBack.allOrders){
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
                    Txt('Payments', size: 20,),
                    Container(
                      height: MediaQuery.of(context).size.height-200,
                      child: tm.length>0? Timeline(
                      position: TimelinePosition.Left,
                      children: tm,
                    ):Center(child: Txt('No Transations Yet', fw: FontWeight.w300,),)
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