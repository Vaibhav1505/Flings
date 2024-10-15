// CHECK LINE 95

// ignore_for_file: use_build_context_synchronously, duplicate_import

import 'dart:convert';
import 'package:flings_flutter/Providers/LocationProvider.dart';
import 'package:flings_flutter/Providers/ProfileInformationProvider.dart';
import 'package:flings_flutter/components/Container/BackgroundContainer.dart';
import 'package:flings_flutter/pages/Login/otpFillingPage.dart';
import 'package:flings_flutter/routes/apiStrings.dart';
import 'package:flings_flutter/routes/imageURL.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class LoginWithNumberPage extends StatelessWidget {
  const LoginWithNumberPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    TextEditingController phoneNumber = TextEditingController();
    var profileInformationProvider =
        Provider.of<ProfileInformationProvider>(context, listen: false);

    var locationProvider =
        Provider.of<LocationProvider>(context, listen: false);

    Future<void> submitPhoneNumber(String phoneNumber) async {
      if (locationProvider.currentLatitude == null ||
          locationProvider.currentLongitude == null) {
        print("Location is not available.");
        return;
      }

      final double? latitude = locationProvider.currentLatitude;
      final double? longitude = locationProvider.currentLongitude;

      final data = {
        'phone': phoneNumber,
        'userLocation': [longitude, latitude]
      };

      if (phoneNumber.isNotEmpty) {
        print('Current Location:[$latitude,$longitude]');
        var response = await http.post(Uri.parse(LOGIN_WITH_NUMBER),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode(data));

        if (response.statusCode == 200) {
          var decodedResponseBody = jsonDecode(response.body);
          var currentUserId = decodedResponseBody['userData']['_id'];

          storage.write(key: 'phoneNumber', value: phoneNumber);
          storage.write(key: 'currentUserId', value: currentUserId);

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => OTPFillingPage(phone: phoneNumber)));
        }
        else{
          print("Unable to generate OTP");
        }
      }
    }

    return SafeArea(
      child: Scaffold(
        body: BackGroundContainer(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          CupertinoIcons.arrow_left_circle,
                          color: Colors.white,
                          size: 30,

                          // weight: ,
                        ),
                      ),
                    ),
                  ],
                ),
                SvgPicture.asset(
                  LOGIN_PAGE_IMAGE,
                  semanticsLabel: 'login image',
                  fit: BoxFit.contain,
                  height: 250,
                  width: double.infinity,
                  alignment: Alignment.center,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                  child: Text(
                    "Get Started With Flings",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 40),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                  child: TextFormField(
                    //DO NOT FORGET TO ADD VALIDATION IN LAST SO...NO PERSON CAN MOVE TO NEXT PAGE BEFORE FILLING THE PHONE NUMBER

                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        suffixIcon: const Icon(
                          CupertinoIcons.phone,
                          color: Colors.black,
                        ),
                        iconColor: Colors.white,
                        hintText: "Enter 10 digit Mobile Number",
                        label: const Text(
                          "Mobile Number",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                        )),
                    controller: phoneNumber,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                SizedBox(
                  width: 200,
                  height: 45,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black)),
                    child: const Text(
                      "Generate OTP",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      submitPhoneNumber(phoneNumber.text);
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
