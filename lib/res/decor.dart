import 'package:flutter/material.dart';
import 'package:fyp/res/Txt.dart';
class InDecor extends InputDecoration{
  InDecor({
    Icon preIcon, 
    Color fill=Colors.white, 
    bool filled = true, String hint='', 
    Color hintColor =  Colors.grey,
    double ls=0,
    String suffix = '',
    double radius = 12}
  ):super(
    prefixIcon: preIcon,
    fillColor: fill,
    filled: true,
    hintText: hint,
    suffix: Txt(suffix),
    hintStyle: TextStyle(color: hintColor, letterSpacing: ls ),
    border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(radius),
    ),
  );
}

class BoxDecor extends BoxDecoration{
  BoxDecor({
    double border:0,
    double radius = 12, 
    Color color= Colors.white, 
    Color borderColor= Colors.white, 
    String img}
  ):super(
    borderRadius: BorderRadius.circular(radius),
    color: color,
    border:Border.all(
      color: borderColor,
      width: border,
    )
    // image: Image.asset(img)
  );
}

class Leading extends IconButton{
  Leading():super(
    icon: Icon(Icons.menu, color: Color.fromRGBO(42, 42, 42, 1),),
    onPressed: (){},
  );
}

class ApBar extends AppBar{
  ApBar({double x=0}):super(
    elevation: 0,
    backgroundColor: Colors.white,
    leading: Leading(),
    title:Circ(),
    actions: <Widget>[
      SizedBox(width: x,),
      IconButton(
        icon: Icon(Icons.search, color: Colors.black,),
        onPressed: (){},
      ),
      SizedBox(width: 15,),
    ],
  );
}

class Circ extends Container{
  Circ({
    double outerSize = 32,
    double innerSize = 30, 
    double innerRad = 15, 
    double outerRad = 16, 
    Color innerColor = Colors.white, 
    Color outerColor =Colors.white
  }):super(
    height: outerSize,
    width: outerSize,
    decoration: BoxDecor(radius: outerRad, color: outerColor),
    child: Center( 
      child: Container(
        height: innerSize,
        width: innerSize,
        decoration: BoxDecor(radius: innerRad,color: innerColor),
      ),
    ),
  );
}

class Roe extends StatelessWidget{
  List <Widget>lis = [];
  Roe(List <String> ls){
    for (var item in ls) {
      this.lis.add(Text(item));
    }
  }
 
  @override
  Widget build(BuildContext context) {
    return Row(children: lis,);
  }
}



