// ignore_for_file: prefer_const_constructors

import 'package:flings_flutter/Practice/Calling/VideoCallViaWebRTC.dart';
import 'package:flings_flutter/Practice/State%20Management/FirstProviderTutorial.dart';
import 'package:flings_flutter/Practice/State%20Management/MulticlassProviderPage.dart';
import 'package:flings_flutter/Practice/StreamBuilderExample/StreamBuilderExample.dart';
import 'package:flings_flutter/Providers/LocationProvider.dart';
import 'package:flings_flutter/Providers/PeopleListProvider.dart';
import 'package:flings_flutter/Providers/ProfileInformationProvider.dart';
import 'package:flings_flutter/Providers/SocketProvider.dart';
import 'package:flings_flutter/Providers/UpdateProfileProviders.dart';
import 'package:flings_flutter/Themes/themes.dart';
import 'package:flings_flutter/components/NavigationBar/BottomNavigationBar.dart';
import 'package:flings_flutter/pages/Main/Chat/ChatPage.dart';
import 'package:flings_flutter/pages/Main/Chat/ChatPeopleListPage.dart';
import 'package:flings_flutter/pages/Main/PeopleList/Filter/FilterPage.dart';
import 'package:flings_flutter/pages/Login/LoginPage.dart';
import 'package:flings_flutter/pages/Login/LoginWithNumber.dart';
import 'package:flings_flutter/pages/Login/OTPFillingPage.dart';
import 'package:flings_flutter/pages/LandingPage.dart';
import 'package:flings_flutter/pages/Main/PeopleList/PeopleList.dart';
import 'package:flings_flutter/pages/Profile/UpdataProfile.dart';
import 'package:flings_flutter/pages/Profile/UpdateMandatoryInfo.dart';
import 'package:flings_flutter/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root ośf your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UpdateProfileProviders()),
        ChangeNotifierProvider(create: (_) => PeopleListProvider()),
        ChangeNotifierProvider(create: (_) => LocationProvider()),
        ChangeNotifierProvider(create: (_) => SocketProviderContext()),
        ChangeNotifierProvider(create: (_) => ProfileInformationProvider())
      ],
      child: MaterialApp(
        theme:
            ThemeData(useMaterial3: true, primaryColor: MyTheme.primaryColor),
        darkTheme: ThemeData.dark(),
        initialRoute: '/',
        routes: {
          '/': (context) => LandingPage(),
          MyRoutes.loginPage: (context) => LoginPage(),
          MyRoutes.loginWithNumberPage: (context) => LoginWithNumberPage(),
          MyRoutes.otpFillingPage: (context) => OTPFillingPage(phone: ''),
          MyRoutes.updateMandatoryInfo: (context) =>
              UpdateMandatoryInfo(token: '', userData: ''),
          MyRoutes.updateProfile: (context) => UpdateProfile(),
          MyRoutes.bottomNavigationBar: (context) => BottomNavigation(),
          MyRoutes.peopleList: (context) => PeopleList(),
          MyRoutes.filterPage: (context) => FilterPage(),
          MyRoutes.ChatPeopleListPage: (context) => ChatPeopleListPage(),
          MyRoutes.ChatPage: (context) => ChatPage(
                targetUserID: '',
                userName: "",
                gender: "",
                matchId: "",
              ),
          MyRoutes.CallingPage: (context) => VideoCallViaWebRTC(
                remoteUserId: '',
              ),

          //PRACTICE

          MyRoutes.providerStateManagementTutorial: (context) =>
              FirstProviderTutorial(),
          MyRoutes.MultiClassProvider: (context) => MultiClassProviderPage(),
          MyRoutes.StreamBulderExample: (context) => CounterPage()
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
