import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  TextEditingController? controller;
  String hintText;
  Icon? icon;
  String? labelText;
  String? Function(String?)? validator;
  Color? backgroundColor, hintTextColor, labelTextColor;
  Color borderColor;
  double borderRadius;
  ValueChanged<String>? onChanged;
 Function(String)? onFieldSubmit;
  VoidCallback? onTap;

  CustomInputField(
      {super.key,
      this.controller,
      required this.hintText,
      required this.borderRadius,
      this.onFieldSubmit,
      this.onChanged,
      this.icon,
      this.validator,
      required this.labelText,
      this.backgroundColor,
      this.hintTextColor,
      this.labelTextColor,
      required this.borderColor,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      onChanged: onChanged,
      controller: controller,
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor, width: 2),
              borderRadius: BorderRadius.circular(borderRadius)),
          filled: true,
          focusColor: borderColor,
          fillColor: backgroundColor,
          hintText: hintText,
          hintStyle: TextStyle(color: hintTextColor),
          prefixIcon: icon,
          labelText: labelText ?? '',
          labelStyle: TextStyle(color: hintTextColor)),
      onTap: onTap,
      onFieldSubmitted: onFieldSubmit,
      
    );

  }
}
