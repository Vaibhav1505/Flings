import 'package:flings_flutter/styles/text.dart';
import 'package:flutter/material.dart';

class CallingOptionDropDown extends StatefulWidget {
  const CallingOptionDropDown({super.key});

  @override
  State<CallingOptionDropDown> createState() => _CallingOptionDropDownState();
}

class _CallingOptionDropDownState extends State<CallingOptionDropDown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250.0,
      height: 200.0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading:const Icon(
              Icons.call,
              color: Colors.white,
            ),
            title: Text(
              "Voice Call",
              style: whiteNoramlText,
            ),
            onTap: () {
              // Handle tap
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            leading:const Icon(
              Icons.block,
              color: Colors.white,
            ),
            title: Text(
              "Block and Report",
              style: whiteNoramlText,
            ),
            onTap: () {
              // Handle tap
              Navigator.of(context).pop(); // Close the dialog
            },
          ),
          ListTile(
            leading:const Icon(
              Icons.person_add_disabled_outlined,
              color: Colors.white,
            ),
            title: Text(
              "Unfollow",
              style: whiteNoramlText,
            ),
            onTap: () {
              // Handle tap
              Navigator.of(context).pop(); 
            },
          ),
          ListTile(
            leading:const Icon(
              Icons.facebook,
              color: Colors.white,
            ),
            title: Text(
              "Connect on Facebook",
              style: whiteNoramlText,
            ),
            onTap: () {
              // Handle tap
              Navigator.of(context).pop(); // Close the dialog
            },
          ),
        ],
      ),
    );
  }
}
