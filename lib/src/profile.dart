import 'package:cached_network_image/cached_network_image.dart';
import 'package:fyp/res/dbServer.dart';
import 'package:fyp/res/decor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Profile extends StatefulWidget{
  Profile();
  _ProfileState createState()=> _ProfileState();
  

}
class _ProfileState extends State<Profile>{
  // _ProfileState(this.token);
   String token  = DbServer.token;

  
  @override
  Widget build(BuildContext context) {
    
    DbServer().checkExists().then((value){
      // print(value);
      // if(!value){
      //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));
      // }
    }); 
    var future = DbServer().getProfile();
    return Scaffold(
      body: Container(
        child: FutureBuilder(
          future: future,
          builder: (context, snap){
            switch (snap.connectionState){
              case ConnectionState.none:
              return Center(
                child: Text('Connection failure'),
              );
              break; 
              case ConnectionState.waiting:
                return Center(
                  child: Text('Loading'),
                );
              break;
              case ConnectionState.done:
              if(snap.data['success']=='false'){
                return Center(child: Text(snap.data['error']));
              }
              print(snap.data);
              String img = '';
              snap.data['image']!=null?
                 img = DbServer().getImagePath()+snap.data['image']:
                 img = 'https://lh3.googleusercontent.com/dMvWUAMjDiO8BGYlJAAh1J3My2N1moslSPcPIVa8vKmss6avOA20KAFWjoMhTtk2CdCM400-6T7yBekoyJt7jA=s400';
                return Container(
                  padding: EdgeInsets.all(30),
                  child: SingleChildScrollView(
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(height: 30,),
                          Container(
                            height: 200,
                            width: double.infinity,
                            color: Colors.blue,
                            child: 
                            CachedNetworkImage(
                              imageUrl: img,
                              placeholder:(contet, String s)=> Container(
                                height: 40,
                                width: 40,
                                child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white),)),
                              errorWidget:(context, String s, a)=> new Icon(Icons.error),
                            ),
                            //  Image.network(img,height: 100, width: 100,),
                          ),
                          Roe(['id ',snap.data['id'].toString()]),
                          Roe(['name ',snap.data['f_name']+' '+snap.data['l_name']]),
                          Roe(['email ',snap.data['email'].toString()]),
                          Roe(['address ',snap.data['address'].toString()]),
                          Roe(['dob ',snap.data['dob'].toString()]),
                          Roe(['joined_date ',snap.data['joined_date'].toString()]),
                          Roe(['dept',snap.data['dept'].toString()]),
                          Roe(['salary ',snap.data['salary'].toString()]),
                          
                        ],
                      ),
                    ),
                  ),
                );
              break;
              default: 
                return Center(
                  child: Text('it crasher'),
                );
              break;
            }
          },
        ),
      ),
    );
  }
}