// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:flings_flutter/Providers/ProfileInformationProvider.dart';
import 'package:flings_flutter/routes/apiStrings.dart';
import 'package:flings_flutter/services/InterceptedHTTP.dart';
import 'package:flings_flutter/styles/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:flings_flutter/components/Container/BackgroundContainer.dart';
import 'package:flings_flutter/components/DropDown/DropDown.dart';
import 'package:flings_flutter/components/TextInputField/TextInputField.dart';
import 'package:flings_flutter/pages/Profile/UpdataProfile.dart';
import 'package:provider/provider.dart';

class UpdateMandatoryInfo extends StatefulWidget {
  var token;
  var userData;
  UpdateMandatoryInfo({super.key, required this.token, required this.userData});

  @override
  State<UpdateMandatoryInfo> createState() => _UpdateMandatoryInfoState();
}

class _UpdateMandatoryInfoState extends State<UpdateMandatoryInfo> {
  String? selectedGender;
  String? selectedOrientation;
  String? formattedDate;
  int age = 18;

  TextEditingController nameController = TextEditingController();
  TextEditingController dobController = TextEditingController();

  final storage = FlutterSecureStorage();

  var interceptedHTTPRequest = InterceptedHTTP();
  List<String> userGender = ['Male', 'Female', 'Prefer not to say'];
  List<String> oreintationGender = ['Male', 'Female', 'Prefer not to say'];

  Future<void> updateMendatoryInformation() async {
    if (nameController.text.isNotEmpty && dobController.text.isNotEmpty) {
      var data = {
        "name": nameController.text,
        "dob": dobController.text,
        "gender": selectedGender,
        "orientation": selectedOrientation
      };

      var recievedResponse =
          await interceptedHTTPRequest.postHttp(UPDATE_MANDATORY_FIELD, data);

      if (recievedResponse.statusCode == 200) {
        storage.write(key: 'name', value: nameController.text);
        storage.write(key: 'userGender', value: selectedGender);
        storage.write(key: 'userDesiredGender', value: selectedOrientation);

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => UpdateProfile()));
      } else {
        debugPrint('There is an Error in Sending Data');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var profileInformationProvider =
        Provider.of<ProfileInformationProvider>(context, listen: false);

    return Scaffold(
      body: BackGroundContainer(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Get Started With Flings",
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      "Let's setup your Profile",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                CustomInputField(
                  borderColor: Colors.white,
                  hintTextColor: Colors.white,
                  controller: nameController,
                  backgroundColor: Color.fromARGB(71, 0, 0, 0),
                  hintText: "Enter Your Name",
                  borderRadius: 50,
                  labelText: "Name",
                ),
                SizedBox(
                  height: 25,
                ),
                CustomInputField(
                  controller: dobController,
                  backgroundColor: Colors.transparent,
                  icon: Icon(
                    CupertinoIcons.calendar,
                    color: Colors.white,
                  ),
                  hintText: "Select your Date of Birth",
                  hintTextColor: Colors.white,
                  borderRadius: 50,
                  labelText: "Date of Birth",
                  labelTextColor: Colors.white,
                  borderColor: Colors.white,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1950),
                        //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime.now());

                    if (pickedDate != null) {
                      //pickedDate output format => 2021-03-10 00:00:00.000
                      formattedDate =
                          DateFormat("dd/MM/yyyy").format(pickedDate);
                      debugPrint(
                          "Formated Date:$formattedDate"); //formatted date output using intl package =>  2021-03-16
                      setState(() {
                        dobController.text = formattedDate!;
                        age = DateTime.now().year - pickedDate.year;
                        debugPrint("Age:$age");
                      });
                      if (age < 18) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("You must be at least 18 years old."),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      } else {
                        // Format and set the date if age is valid
                        formattedDate =
                            DateFormat("dd/MM/yyyy").format(pickedDate);
                        debugPrint("Formatted Date: $formattedDate");
                        setState(() {
                          dobController.text = formattedDate!;
                        });
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              backgroundColor: Colors.white,
                              elevation: 15,
                              child: Container(
                                  padding: EdgeInsets.all(10),
                                  child: Text("You are $age years old")),
                            );
                          },
                        );
                      }
                    }
                  },
                ),
                SizedBox(
                  height: 25,
                ),
                CustomDropDown(
                  dropDownOptions: userGender,
                  hintText: "What's your Gender?",
                  dropDownValue: userGender.contains(selectedGender)
                      ? selectedGender
                      : null,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedGender = newValue;

                      // print(selectedGender);
                    });
                  },
                ),
                SizedBox(
                  height: 25,
                ),
                CustomDropDown(
                  dropDownValue: oreintationGender.contains(selectedOrientation)
                      ? selectedOrientation
                      : null,
                  dropDownOptions: oreintationGender,
                  hintText: "Whom do you want to meet?",
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedOrientation = newValue;

                      // print(selectedOrientation);
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 10)),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.black)),
                        onPressed: () async {
                          updateMendatoryInformation();
                        },
                        child: Text(
                          "Next",
                          style: whiteBoldText,
                        )),
                  ],
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
