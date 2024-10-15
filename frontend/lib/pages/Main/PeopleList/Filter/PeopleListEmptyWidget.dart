import 'package:flings_flutter/components/Buttons/onPressedButton.dart';
import 'package:flings_flutter/pages/Main/PeopleList/Filter/FilterPage.dart';
import 'package:flings_flutter/styles/text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PeopleListEmpty extends StatelessWidget {
  const PeopleListEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      Text(
        "Why not Adjust those Filters?",
        style:
            whiteBoldText.copyWith(fontSize: 40, fontWeight: FontWeight.w900,),
      ),
      const SizedBox(
        height: 5,
      ),
       Text(
          "You've seen everyone nearby. But, never fear, someone great could be just outside your filters",style: whiteNoramlText,),
      const SizedBox(
        height: 50,
      ),
      InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>const FilterPage()));
        },
        child: Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
              color: Colors.black, borderRadius: BorderRadius.circular(50)),
          child: Center(child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(FontAwesomeIcons.sliders,color: Colors.white,),
              SizedBox(width: 15,),
              Text("Adjust your filters",style: whiteBoldText.copyWith(fontSize: 15),),

            ],
          )),
        ),
      )
    ]);
  }
}
