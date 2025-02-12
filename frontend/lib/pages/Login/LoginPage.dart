// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flings_flutter/components/Container/BackgroundContainer.dart';
import 'package:flings_flutter/components/Buttons/loginButtons.dart';
import 'package:flings_flutter/routes/imageURL.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackGroundContainer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 60),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    APP_LOGO_TRANSPARENT,
                    height: 50,
                    width: 50,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Flings",
                    style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                CustomLoginButtons(
                  icon: Icon(
                    Icons.facebook_outlined,
                    color: Colors.white,
                  ),
                  onpressed: () {},
                  cardTitle: "Signin with Facebook",
                ),
                SizedBox(
                  height: 15,
                ),
                CustomLoginButtons(
                    onpressed: () {},
                    icon: Icon(
                      Icons.email,
                      color: Colors.white,
                    ),
                    cardTitle: "Signin with Email"),
                SizedBox(
                  height: 20,
                ),
                CustomLoginButtons(
                    onpressed: () {
                      Navigator.pushNamed(context, '/loginWithNumberPage');
                    },
                    icon: Icon(
                      Icons.phone,
                      color: Colors.white,
                    ),
                    cardTitle: "Signin With Number"),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "New User? Create an Account",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w600
                          // decoration: TextDecoration.underline,
                          ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      CupertinoIcons.paperplane_fill,
                      color: Colors.white,
                      size: 15,
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
