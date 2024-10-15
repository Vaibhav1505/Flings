import 'package:flings_flutter/Themes/themes.dart';
import 'package:flutter/material.dart';

class texts {
  Color flotingActionButtonTextColor = Colors.white;
}

// {**WHITE**}
TextStyle whiteBoldText =
    const TextStyle(color: Colors.white, fontWeight: FontWeight.bold);

TextStyle whiteNoramlText =
    const TextStyle(color: Colors.white, fontWeight: FontWeight.normal);

// {**GREY**}
TextStyle greyNormalText =
    const TextStyle(color: Colors.grey, fontWeight: FontWeight.normal);

// {**BLACK**}
TextStyle blackBoldText =
    const TextStyle(color: Colors.black, fontWeight: FontWeight.bold);

TextStyle blackNormalText =
    const TextStyle(color: Colors.black, fontWeight: FontWeight.normal);


//GREEN
TextStyle  greenNoramlText= const TextStyle(color: Colors.green,fontWeight: FontWeight.normal);
TextStyle  greenBoldText= const TextStyle(color: Colors.green,fontWeight: FontWeight.bold);

//RED
TextStyle  redNormalText= const TextStyle(color: Colors.red,fontWeight: FontWeight.normal);
TextStyle  redBoldText= const TextStyle(color: Colors.red,fontWeight: FontWeight.bold);

//APP GRADIENT COLOR
TextStyle boldGradientText=  TextStyle(foreground: Paint()..shader = MyTheme.linearGradientColor,fontWeight: FontWeight.bold);
TextStyle normalGradientText=  TextStyle(foreground: Paint()..shader = MyTheme.linearGradientColor,fontWeight: FontWeight.normal);

