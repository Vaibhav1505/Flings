import 'package:flings_flutter/pages/Main/PeopleList/Filter/FilterPage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BackgroundDesignCurve extends StatelessWidget {
  const BackgroundDesignCurve({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: double.infinity,
      decoration: 
      const ShapeDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              Color(0xff870160),
              Color(0xffac255e),
              Color(0xffca485c),
              Color(0xffe16b5c),
              Color(0xfff39060),
              Color(0xffffb56b),
            ],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30)),
          )),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Discover",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.white),
            ),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder:(context)=>FilterPage()));
              },
              child:const FaIcon(FontAwesomeIcons.sliders,color: Colors.white,)
            )
          ],
        ),
      ),
    );
  }
}
