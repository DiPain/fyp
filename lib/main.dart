import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fyp/pragmatic/main_back.dart';
import 'package:fyp/res/dbServer.dart';
import 'package:fyp/src/login.dart';
import 'package:fyp/src/splash.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final FirebaseMessaging _messaging = FirebaseMessaging();
  String app_id = '51b6c3f9-62b1-4251-922f-7aae4f06f883';

  @override
  void initState() {
    print("==init================");
    OneSignal.shared.init(app_id);
    OneSignal.shared.getPermissionSubscriptionState().then((onValue){
      String playerId = onValue.subscriptionStatus.userId;
      DbServer.playerId = playerId;
      print("=============serverid");
      print(DbServer.playerId);

    });

    _messaging.configure(
      onLaunch: (Map<String, dynamic> message)async{
        print('launched $message');
      },
      onMessage: (Map<String, dynamic> message)async{
        // showNotification(message);
        print('messaged $message');
      },
      onResume: (Map<String, dynamic> message)async{
        // showNotification(message);
        print('resumed $message');
      }
    );

    _messaging.getToken().then(( token) {
      print("messaging token");
      print(token);
    });

  }

  @override
  Widget build(BuildContext context) {
    print("==init================");
    OneSignal.shared.init(app_id);
    OneSignal.shared.getPermissionSubscriptionState().then((onValue){
      String playerId = onValue.subscriptionStatus.userId;
      DbServer.playerId = playerId;
      print("=============serverid");
      print(DbServer.playerId);

    });

    _messaging.configure(
      onLaunch: (Map<String, dynamic> message)async{
        print('launched $message');
      },
      onMessage: (Map<String, dynamic> message)async{
        // showNotification(message);
        print('messaged $message');
      },
      onResume: (Map<String, dynamic> message)async{
        // showNotification(message);
        print('resumed $message');
      }
    );

    _messaging.getToken().then(( token) {
      print("messaging token");
      print(token);
    });
    
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider(
        builder: (_)=>MainBack(),
        child: Consumer<MainBack>(
          builder: (context, logBack,_){
            final mainBack = Provider.of<MainBack>(context);
            return Splas();
          }
        )
      )
    );
  }
}
