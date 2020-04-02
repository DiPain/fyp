import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fyp/components/recommendations.dart';
import 'package:fyp/res/Txt.dart';

class TestPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      body: Recommendations([SizedBox() ], SizedBox())
    );
  }
}


