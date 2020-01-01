import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DbServer{
  // String ip = '192.168.1.141';
  // String ip = '192.168.31.203';
  String ip = '10.0.2.2';
  String port = '8000';
  String imagePath='/profiles/';

  static String token = '';
  static String playerId = '';
  static String name = '';
  static String email = '';
  static List tray = [];

  getHeader(){
    Map<String, String> headers = {"Content-type":"application/json"};
    return headers;
  }

  String getImagePath(){
    return 'http://'+ip+':'+port+imagePath;
  }

  String getServer(){
    return 'http://'+ip+':'+port;
  }

  addtoTray(int foodId, int quantity){
    bool added= false;
    print(foodId);
    for(int i=0; i<tray.length;i++){
      if(tray[i][0]==foodId){
        tray[i][0]+=quantity;
        added=true;
      }
    }
    if(!added){
      tray.add([foodId, quantity]);
    }
    print(tray);
  }

  pushPlayId(String playerId)async{
    String bod = '{"api_token":"'+token+'","playerId":"'+playerId+'"}';
    Response response = await post(getServer()+'/api/pushPlayId', headers: getHeader(), body: bod);
    var res =  json.decode(response.body); 
    return res;
  }

  login() async{
    String bod = '{"api_token":"'+token+'"}';
    Response response = await post(DbServer().getServer()+'/api/login', headers: DbServer().getHeader(), body: bod);
    var res =  json.decode(response.body); 
    return res;
  }

  logout()async{
    String bod = '{"api_token":"'+token+'"}';
    SharedPreferences pref = await SharedPreferences.getInstance().then((onValue){
      onValue.remove('token');
      print('removed');
    });
   
    Response response = await post(DbServer().getServer()+'/api/logout', headers: DbServer().getHeader(), body: bod);
    var res =  json.decode(response.body); 
    return res;
  }

  getOrders() async{
    String bod = '{"api_token":"'+token+'"}';
    Response response = await post(DbServer().getServer()+'/api/orders', headers: DbServer().getHeader(), body: bod);
    var res =  json.decode(response.body); 
    return res;
  }
  getMenu() async{
    String bod = '{"api_token":"'+token+'"}';
    Response response = await post(DbServer().getServer()+'/api/menu', headers: DbServer().getHeader(), body: bod);
    var res =  json.decode(response.body); 
    return res;
  }

  changePass(String old, String nuu) async{
    String bod = '{"api_token":"'+token+'","old":"'+old+'","nuu":"'+nuu+'"}';
    Response response = await post(DbServer().getServer()+'/api/changePass', headers: DbServer().getHeader(), body: bod);
    var res =  json.decode(response.body); 
    return res;
  }

  getProfile()async{
    String bod = '{"api_token":"'+token+'"}';
    Response response = await post(DbServer().getServer()+'/api/profile', headers: DbServer().getHeader(), body: bod);
    var res =  json.decode(response.body); 
    return res;
  }

  checkExists()async{
    String bod = '{"api_token":"'+token+'"}';
    print(bod);
    Response response = await post(DbServer().getServer()+'/api/checkExists', headers: DbServer().getHeader(), body: bod);
    var res =  json.decode(response.body); 
    return res;    
  }

 

  // used in profile image update
  sendImage(String token, var image) async{
    List<int> imageBytes = image.readAsBytesSync();
    String base64Image = base64Encode(imageBytes);
    String bod = '{"api_token":"'+token+'","image":"'+base64Image+'"}';
    Response response = await post(DbServer().getServer()+'/api/uploadImage', headers: DbServer().getHeader(), body: bod);
    // var res =  json.decode(response.body); 
    print(response);
    return false;
  }


  
}