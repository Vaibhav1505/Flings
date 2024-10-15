// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:flings_flutter/Providers/UpdateProfileProviders.dart';
import 'package:flings_flutter/Themes/themes.dart';
import 'package:flings_flutter/components/Buttons/onPressedButton.dart';
import 'package:flings_flutter/pages/Profile/BasicInformationSection.dart';
import 'package:flings_flutter/pages/Profile/YourHabitsSection.dart';
import 'package:flings_flutter/routes/apiStrings.dart';
import 'package:flings_flutter/routes/routes.dart';
import 'package:flings_flutter/services/InterceptedHTTP.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateProfile extends StatefulWidget {
  UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  var interceptedHttpRequest = InterceptedHTTP();

  Future<void> sendUpdateData(UpdateProfileProviders updateProfileProvider) async {
    try {
      var extra = {
        "about": updateProfileProvider.aboutUser,
        "job": updateProfileProvider.userJob,
        "company": updateProfileProvider.userCompany,
        "education": updateProfileProvider.selectedEduation,
        "religion": updateProfileProvider.selectedReligion,
        "drinking": updateProfileProvider.selectedDrink,
        "smoking": updateProfileProvider.selectedSmoking,
        "workout": updateProfileProvider.selectedWorkout,
        "diet": updateProfileProvider.selectedDiet,
        "socialMedia": updateProfileProvider.selectedSocialMedia
      };

      var response =
          await interceptedHttpRequest.postHttp(UPDATE_PROFILE, extra);
      if (response.statusCode == 200) {
        print("Response Body:${response.body}");
      } else {
        print("Error in {SEND_UPDATED_DATA} function");
      }
    } catch (e) {
      debugPrint("Error:${e.toString()}");
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  @override
  Widget build(BuildContext context) {
    var updateProfileProvider = Provider.of<UpdateProfileProviders>(context);

    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          actions: [
            OnPressedButton(
                horizontalPadding: 10,
                verticalPadding: 10,
                buttonTextColor: Colors.black,
                buttonText: "Done",
                onpressed: () async {
                  await sendUpdateData(updateProfileProvider);
                  
                  Navigator.pushNamed(context, MyRoutes.bottomNavigationBar);
                },
                buttonColor: Colors.white,
                buttonBorderRadius: 50,
                buttonIcon: Icon(
                  CupertinoIcons.check_mark_circled,
                  color: Colors.black,
                )),
            SizedBox(
              width: 20,
            ),
          ],
          title: Text(
            "Edit Profile",
            style: TextStyle(
                color: MyTheme.appBarMainHeading, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.black),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),

              //{BASIC INFORMAITON SECTION}

              BasicInfoSection(
                education: updateProfileProvider.selectedEduation,
                religion: updateProfileProvider.selectedReligion,
              ),

              SizedBox(
                height: 25,
              ),
              //{YOUR HABITS SECTION}

              YourHabitsSection(
                  drinking: updateProfileProvider.selectedDrink,
                  smoking: updateProfileProvider.selectedSmoking,
                  workout: updateProfileProvider.selectedWorkout,
                  diet: updateProfileProvider.selectedDiet,
                  socialMedia: updateProfileProvider.selectedSocialMedia)
            ],
          ),
        ),
      ),
    );
  }
}
