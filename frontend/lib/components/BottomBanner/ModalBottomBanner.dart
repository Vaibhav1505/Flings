// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flings_flutter/Themes/themes.dart';
import 'package:flings_flutter/components/Others/SwitchWidget.dart';
import 'package:flings_flutter/styles/text.dart';
import 'package:flutter/material.dart';

class GenderModalContainer extends StatefulWidget {
  const GenderModalContainer({super.key});

  @override
  State<GenderModalContainer> createState() => _GenderModalContainerState();
}

class _GenderModalContainerState extends State<GenderModalContainer> {
  List<String> gender = ['Men', 'Women', 'Non Binary People'];
  List<bool> selectedGender = [false, false, false];
  bool choosedGender = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      
        decoration: const 
        BoxDecoration(color: Colors.black,),
        height: 300,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              Text(
                "Who would you like to Date?",
                style: whiteBoldText.copyWith(fontSize: 20),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "I'm open to dating Everyone",
                    style: whiteNoramlText,
                  ),
                  const SwtichWidget()
                ],
              ),
              Expanded(
                  child: ListView.builder(
                itemCount: gender.length,
                itemBuilder: (context, index) {
                  return CheckboxListTile(
                      title: Text(
                        gender[index],
                        style: whiteNoramlText,
                      ),
                      activeColor: MyTheme.primaryColor,
                      value: selectedGender[index],
                      onChanged: (value) {
                        setState(() {
                          selectedGender[index] = value!;
                          print(selectedGender[index]);
                        });
                      });
                },
              ))
            ],
          ),
        ));
  }
}


