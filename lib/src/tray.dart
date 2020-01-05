import 'package:flutter/material.dart';
import 'package:fyp/pragmatic/tray_back.dart';
import 'package:fyp/pragmatic/order_button.dart';
import 'package:fyp/res/Txt.dart';
import 'package:fyp/res/dbServer.dart';
import 'package:fyp/res/decor.dart';
import 'package:provider/provider.dart';

class Tray extends StatefulWidget {
  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Tray> {
  bool updated = false;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (_)=>TrayBack(),
      child: Consumer<TrayBack>(
        builder: (context, trayBack,_){
          final trayBack = Provider.of<TrayBack>(context);
          trayBack.getTotal();
          List<Widget> tray=[SizedBox()];
          if(DbServer.tray.length>0){
            tray=[];
            for (int i=0; i<DbServer.tray.length; i++) {
              var item = DbServer.tray[i];
              print('-------------');
              var food = DbServer().foodDetails( item[0]);
              print(food);
              tray.add(
                Container(
                  decoration: BoxDecoration(
                    border:Border.all(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(
                        height: 40,
                        width: 40,
                        child: Icon(Icons.fastfood)),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(),
                          SizedBox(),
                          Txt(food['food']['name'], size: 20, fw: FontWeight.w300,),
                          Row(
                            children: <Widget>[
                              Txt('Rs.'+(food['price']*item[1]).toString(), fw: FontWeight.w300,),
                              SizedBox(width: 20,),
                              Txt('(Rs. '+food['price'].toString()+' each)', size: 12, fw: FontWeight.w300,),
                            ],
                          ),
                          SizedBox(),
                      ],),
                      Expanded(
                        child: SizedBox(),
                      ),
                      Container(
                        child: IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: (){
                            setState(() {
                              trayBack.addQty(i, false);
                            });
                          },
                        ),
                      ),
                      Container(
                        width: 18,
                        child: Txt(item[1].toString()),),
                      Container(
                        child: IconButton(
                          icon: Icon(Icons.add),
                          onPressed: (){
                            setState(() {
                              trayBack.addQty(i, true);
                            });
                          },
                        )
                      )

                    ],
                  ),

                )
              );
              tray.add(SizedBox(height: 10));
              print('-------------');
            }
          }
          return Scaffold(
            body: Container(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 30,),
                  Txt('Tray', size:20),
                  Container(
                    child: Column(
                      children: tray,
                    )  
                  ),
                ],
              )
            ),
            floatingActionButton: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children:<Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(width: 40,),
                      Txt('Total:', fw: FontWeight.w300,size: 20,),  
                      Expanded(child: SizedBox()),
                      Txt(trayBack.total.toString(),fw: FontWeight.w300,size: 20,),
                      SizedBox(width: 10,),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Container(
                  height: 44,
                  width: double.infinity,
                  decoration: BoxDecor(
                    color: Colors.blue[300],
                    radius: 40
                  ),
                  margin: EdgeInsets.only(left:30),
                  child: ChangeNotifierProvider(
                  builder: (_)=>OrderButton(),
                        child: Consumer<OrderButton>(
                          builder: (context, orderButton,_){
                            final orderButton = Provider.of<OrderButton>(context);
                            return FlatButton(
                              child: orderButton.loading?Container(
                                width: 25,
                                height: 25,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                ),
                              ): Txt('Order'),
                              onPressed: (){
                                orderButton.changeLoading(true);
                                print(DbServer.tray);
                                DbServer().order().then((val){
                                  orderButton.changeLoading(false);

                                  print(val);
                                });
                              },
                            );
                          }
                        )
                  )
                ),
              ]
            ),
          ));
        }
      )
    );
  }
}