import 'package:flutter/material.dart';
import 'package:fyp/pragmatic/order_back.dart';
import 'package:fyp/res/Txt.dart';
import 'package:fyp/res/decor.dart';
import 'package:provider/provider.dart';

class Orders extends StatefulWidget {
  Orders();
  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  bool updated = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            SizedBox(height: 30,),
            Txt('Orders', size:20),
            Container(
              child: ChangeNotifierProvider(
                builder: (_)=>OrderBack(),
                child: Consumer<OrderBack>(
                  builder: (context, orderBack,_){
                    final orderBack = Provider.of<OrderBack>(context);
                    if(!updated){
                      updated=true;
                      orderBack.update();
                    }

                    return Column(
                      children: orderBack.tray,
                    );
                    

                  }
                )
              )
            ),
            
          ],
        )
      ),
      floatingActionButton: Container(
        height: 44,
        width: double.infinity,
        decoration: BoxDecor(
          color: Colors.blue[300],
          radius: 40
        ),
        margin: EdgeInsets.only(left:30),
        child: Center(
          child: FlatButton(
            child: Txt('Order'),
            onPressed: (){},
          ),
        ),
      ),
    );
  }
}