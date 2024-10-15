// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'package:flings_flutter/Themes/themes.dart';
import 'package:flings_flutter/pages/Main/Chat/ChatPeopleListPage.dart';
import 'package:flings_flutter/pages/Main/User/UserProfilePage.dart';
import 'package:flings_flutter/pages/Main/Matching/Matching.dart';
import 'package:flings_flutter/pages/Main/PeopleList/PeopleList.dart';
import 'package:flings_flutter/routes/imageURL.dart';
import 'package:flings_flutter/services/getToken.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 2;

  var storage = FlutterSecureStorage();

  var token = Token();

  Future<String?> getToken() async {
    return await storage.read(key: "token");
  }

  static final List<Widget> _widgetOptions = <Widget>[
    PeopleList(),
    MatchingPage(),
    ChatPeopleListPage(),
    UserProfile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  //Function for connecting Websocket

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      
      bottomNavigationBar: BottomNavigationBar(
        
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
elevation: 10,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              APP_LOGO_TRANSPARENT,
              height: 20,
              width: 20,
            ),
            label: 'People',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.heart_circle,
              color: Colors.white,
            ),
            label: 'Matching',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.chat,
              color: Colors.white,
            ),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.profile_circled,
              color: Colors.white,
            ),
            label: 'Profile',
          ),
          // BottomNavigationBarItem(icon: Icon(CupertinoIcons.add), label: 'Add')
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: MyTheme.primaryColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
