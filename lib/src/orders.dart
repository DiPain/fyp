import 'package:flutter/material.dart';
import 'package:fyp/pragmatic/orders_back.dart';
import 'package:fyp/res/Txt.dart';
import 'package:provider/provider.dart';

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
              return Container(
                child: Txt('Orders', size: 20,),
              );
            }
          )
        ),
      ),
    );
  }
}