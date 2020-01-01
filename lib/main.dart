import 'package:flutter/material.dart';
import 'package:fyp/pragmatic/main_back.dart';
import 'package:fyp/src/login.dart';
import 'package:fyp/src/splash.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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
