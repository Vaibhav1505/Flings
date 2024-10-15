import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FullWidthButton extends StatelessWidget {
  String buttonName;
  Color buttonColor;
  VoidCallback onTap;
  double? borderRadius;

  
  FullWidthButton(
      {super.key,
      required this.buttonName,
      this.borderRadius,
      required this.buttonColor,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(color: buttonColor ,borderRadius: BorderRadius.all(Radius.circular(borderRadius!))),
        width: MediaQuery.of(context).size.width,
        height: 20,
        child: Center(child: Text(buttonName)),
      ),
    );
  }
}
