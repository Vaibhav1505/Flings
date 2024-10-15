//THIS CARD IS CURRENTLY NOT IN USE


// import 'package:flings_flutter/Themes/themes.dart';
// import 'package:flings_flutter/models/ProfileModel.dart';
// import 'package:flings_flutter/styles/text.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class DraggingCard extends StatelessWidget {
//   final ProfileModel profile;

//   const DraggingCard({super.key, required this.profile});

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 500,
//       width: 300,
//       child: Card(
//         elevation: 5,
//         color: Colors.white,
//         child: Stack(
          
//           children: [
//             Container(
//               height: 500,
//               decoration: const BoxDecoration(
//                 borderRadius: BorderRadius.all(Radius.circular(15)),
//                   image: DecorationImage(
//                       image: NetworkImage(
//                           'https://imgs.search.brave.com/PxrQ1cbkaL6EvyTIeY_dAasyjWZFSTldhIGg66wjt2A/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly91cGxv/YWQud2lraW1lZGlh/Lm9yZy93aWtpcGVk/aWEvY29tbW9ucy90/aHVtYi8zLzNhL0Fp/c2h3YXJ5YV9SYWlf/Q2FubmVzXzIwMTcu/anBnLzUxMnB4LUFp/c2h3YXJ5YV9SYWlf/Q2FubmVzXzIwMTcu/anBn',),fit: BoxFit.cover)),
//             ),
//             SizedBox(height: 15,),
//             Text(profile.name!,style: whiteBoldText.copyWith(fontSize: 25),),
//             // Text(profile.filterPref.basic!.distance.toString())
//           ],
//         ),
//       ),
//     );
//   }
// }
