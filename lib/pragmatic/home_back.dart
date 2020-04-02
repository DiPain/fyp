import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fyp/components/homeRecButtons.dart';
import 'package:fyp/res/Txt.dart';
import 'package:fyp/res/dbServer.dart';
// import 'package:cached_network_image/cached_network_image.dart';


class HomeBack with ChangeNotifier{
  bool placingOrder = false;
  Widget menu=SizedBox();
  List<Widget> recommended=[SizedBox()];
  update(){
    // DbServer().getFoods().then((val){

    // });
    DbServer().getMenu().then((val){
      if(val!=null){
        if(val.length!=0){
          print("=== ========= ===== home bcak val");
          print(val[0]);
          print("=== ========= ===== home bcak val");

          DbServer.menu = val;
          menu=Container(
            child: ListView.builder(
            itemCount: val.length,
            itemBuilder: (context, index){
              print("=== ========= ===== home bcak val");
              print(index);
              print(val[index]);
              print("=== ========= ===== home bcak val");
              return Container(
              margin: EdgeInsets.only(bottom: 10),
              width: double.infinity,
              height:  60,
              decoration: BoxDecoration(
                border:Border.all(
                  color: Colors.grey,
                  width: 1,
                ),
                borderRadius: BorderRadius.all(Radius.circular(6)), ),
                child: FlatButton(
                  padding: EdgeInsets.all(0),
                  onPressed: (){
                    print(index);
                    print(val);
                    DbServer().addtoTray(val[index]['id'], 1);
                    Fluttertoast.showToast(
                      msg: val[index]['name']+' added',
                      gravity: ToastGravity.CENTER,
                      
                    );
                   },
                  child: Row(
                    children: <Widget>[
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            // image: SizedBox()
                            //  CachedNetworkImageProvider(
                            //   val[index]['image']
                            // ),
                          )
                        ),
                        ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          SizedBox(),
                          SizedBox(),
                          Txt(val[index]['name'].toString()),
                          Txt(val[index]['price'].toString()),
                          SizedBox(),
                      ],)
                    ],
                  ),
                ),
              );
            },
          ));
          for (var each in val){

              recommended.add(RecommendButton(each));
              recommended.add(SizedBox(width: 20,));
            }
          }
        }
        notifyListeners();
    });
  }
}