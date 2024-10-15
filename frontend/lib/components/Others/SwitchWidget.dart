import 'package:flings_flutter/Themes/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SwtichWidget extends StatefulWidget {
  const SwtichWidget({super.key});

  @override
  State<SwtichWidget> createState() => _SwtichWidgetState();
}

class _SwtichWidgetState extends State<SwtichWidget> {
  bool startingValue = true;
  @override
  Widget build(BuildContext context) {
    return Switch(
        value: startingValue,
        activeColor: MyTheme.primaryColor,
        onChanged: (bool value) {
          setState(() {
            startingValue = value;
            
          });
        });
  }
}