// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, must_be_immutable

import 'package:flings_flutter/Providers/UpdateProfileProviders.dart';
import 'package:flings_flutter/Themes/themes.dart';
import 'package:flings_flutter/components/DialogBox/CustomDiallogBox.dart';
import 'package:flings_flutter/components/List%20Tile/CustomListTile.dart';
import 'package:flings_flutter/components/TextInputField/TextInputField.dart';
import 'package:flings_flutter/components/Buttons/onPressedButton.dart';
import 'package:flings_flutter/data/options.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

class BasicInfoSection extends StatefulWidget {
  String? education, religion, about, jobTitle, company;

  BasicInfoSection(
      {super.key,
      this.education,
      this.religion,
      this.about,
      this.company,
      this.jobTitle});

  @override
  State<BasicInfoSection> createState() => _BasicInfoSectionState();
}

class _BasicInfoSectionState extends State<BasicInfoSection> {
  String? education, religion;
  TextEditingController aboutController = TextEditingController();
  TextEditingController jobTitileController = TextEditingController();
  TextEditingController companyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize controllers with existing values if necessary
    aboutController.text = widget.about ?? '';
    jobTitileController.text = widget.jobTitle ?? '';
    companyController.text = widget.company ?? '';
  }

  @override
  Widget build(BuildContext context) {
    var storage = FlutterSecureStorage();

    var provider = Provider.of<UpdateProfileProviders>(context);

    return Column(
      // direction: Axis.vertical,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Basic Info",
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              foreground: Paint()..shader = MyTheme.linearGradientColor),
        ),
        SizedBox(
          height: 20,
        ),
        Text("About"),
        CustomInputField(
            hintText: "tell us about yourself",
            borderRadius: 50,
            controller: aboutController,
            labelText: "About",
            borderColor: Colors.transparent),
        SizedBox(
          height: 15,
        ),
        Text("Job Title"),
        CustomInputField(
            hintText: "tell us about Job",
            controller: jobTitileController,
            borderRadius: 50,
            labelText: "JOb Title",
            onChanged: (value) {
              provider.setUserJob(jobTitileController.text);
              storage.write(key: "Job", value: value);
            },
            borderColor: Colors.transparent),
        SizedBox(
          height: 15,
        ),
        Text("Company"),
        CustomInputField(
            hintText: "tell us about Company",
            controller: companyController,
            borderRadius: 50,
            labelText: "Company",
            onChanged: (value) {
              provider.setUserCompany(companyController.text);
              storage.write(key: "Company", value: value);
            },
            borderColor: Colors.transparent),
        SizedBox(
          height: 20,
        ),
        CustomListTile(
          leadingWidget: Icon(
            Icons.school,
            color: Colors.white,
          ),
          leadingText: "Educational Level",
          backgroundColor: Colors.black,
          titleColor: Colors.white,
          trailingWidget: widget.education != null
              ? Text(
                  widget.education!,
                  style: TextStyle(
                      color: MyTheme.whiteColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                )
              : IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return CustomDialogBox(
                            options: educationOptions,
                            onOptionSelected: (option) {
                              provider.setEducation(option);
                              storage.write(key: "Education", value: option);

                              print(
                                  "Widget.Education: ${provider.selectedEduation}");

                              Navigator.pop(context);
                            },
                            titleColor: Colors.white,
                            actionTextColor: Colors.white,
                            title: "Select your maximum education level",
                          );
                        });
                  },
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
                  )),
          borderRadius: 50,
        ),
        SizedBox(
          height: 10,
        ),
        CustomListTile(
          leadingWidget: Icon(
            CupertinoIcons.captions_bubble,
            color: Colors.white,
          ),
          leadingText: "Religion",
          backgroundColor: Colors.black,
          titleColor: Colors.white,
          trailingWidget: widget.religion != null
              ? Text(
                  widget.religion!,
                  style: TextStyle(
                      color: MyTheme.whiteColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                )
              : IconButton(onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return CustomDialogBox(
                            options: religionOptions,
                            onOptionSelected: (option) {
                              provider.setReligion(option);
                              storage.write(key: "Religion", value: option);
                              Navigator.pop(context);
                            },
                            titleColor: Colors.white,
                            actionTextColor: Colors.white,
                            title: "Select your Reliogion",
                          );
                        });
                  }, icon: Icon(Icons.add,color: Colors.white,)),
          borderRadius: 50,
        ),
      ],
    );
  }
}
