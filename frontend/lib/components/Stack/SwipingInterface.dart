// import 'dart:convert';

// import 'package:flings_flutter/components/Card/NewSwipingCard.dart';
// import 'package:flings_flutter/components/Card/SwipingCard.dart';
// import 'package:flings_flutter/models/NewProfile.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';



// class SwipeInterface extends StatefulWidget {
//   const SwipeInterface({super.key});

//   @override
//   State<StatefulWidget> createState() => _SwipeInterfaceState();
// }

// class _SwipeInterfaceState extends State<SwipeInterface> {
//   List<Profile> profiles = [
//     Profile(
//         imageAsset:
//             "https://imgs.search.brave.com/hmpVxeNBRr7-witPzLbsmSGXK_PLGAd8N1QDZRGcNuQ/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9zdGF0/NS5ib2xseXdvb2Ro/dW5nYW1hLmluL3dw/LWNvbnRlbnQvdXBs/b2Fkcy8yMDE2LzAz/L05vcmEtRmF0ZWhp/LTEtMzQuanBn",
//         distance: "30",
//         userName: "Nora Fatehi"),
//     Profile(
//         imageAsset:
//             "https://imgs.search.brave.com/nAgYPWrd8jIe-YIO1AI_hXZgAAYtzT_DMAEg6FMTcgE/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly93d3cu/YmV5b3VuZy5pbi9i/ZXlvdW5naXN0YW4v/d3AtY29udGVudC91/cGxvYWRzLzIwMjMv/MDQvUHJpeWFua2Et/Q2hvcHJhLTcwOXgx/MDI0LmpwZw",
//         distance: "30",
//         userName: "Priyanka Chopra"),
//     Profile(
//         imageAsset:
//             "https://imgs.search.brave.com/9EqauNpc5b54ez41eM4X8Bk2rswLn1SUbe9AzW4IqMY/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly93d3cu/YmV5b3VuZy5pbi9i/ZXlvdW5naXN0YW4v/d3AtY29udGVudC91/cGxvYWRzLzIwMjMv/MDQvYmV5b3VuZ2lz/dGFuLWJsb2ctdG9w/LTUwLWFjdHJlc3Mt/NzA5eDEwMjQuanBn",
//         distance: "30",
//         userName: "Katrina Kaif"),
//     Profile(
//         imageAsset:
//             "https://imgs.search.brave.com/kAQv0Q_NLBmXDrMBtVr1c0kiPaSg_P2okkD58NGU0KU/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly95MjBp/bmRpYS5pbi93cC1j/b250ZW50L3VwbG9h/ZHMvMjAyNC8wNS9T/aHJhZGRoYS1LYXBv/b3IuYXZpZg",
//         distance: "30",
//         userName: "Shradhha Kapoor"),
//     Profile(
//         imageAsset:
//             "https://imgs.search.brave.com/NfRV-J2irA4JK1djwPAdd1cPCsBRoxKl_B3SozvAYwY/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly91cGxv/YWQud2lraW1lZGlh/Lm9yZy93aWtpcGVk/aWEvY29tbW9ucy9m/L2Y1L01ydW5hbF9U/aGFrdXJfYXRfU2l0/YV9SYW1hbV90cmFp/bGVyX2xhdW5jaF8o/MSkuanBn",
//         distance: "30",
//         userName: "Mrunal Thakur"),
//   ];

//   int stackCounter = 0;
//   double swipeThreshold = 100.0;

//   // loadJsonData() async {
//   //   String jsonData = await rootBundle.loadString('assets/json/profiles.json');
//   //   setState(() {
//   //     profiles = json
//   //         .decode(jsonData)
//   //         .map<NewProfile>((dataPoint) => NewProfile.fromJson(dataPoint))
//   //         .toList();
//   //   });
//   // }

//   _SwipeInterfaceState() {
//     // loadJsonData();
//   }

//   void evaluateSwipe(dx) {            
//     if (dx > swipeThreshold) {
//       likeProfile();
//     } else if (dx < -swipeThreshold) {
//       doNotLikeProfile();
//     }
//   }

//   void likeProfile() {
//     // do some magic
//     increaseStackCounter();
//   }

//   void doNotLikeProfile() {
//     // do some other magic
//     increaseStackCounter();
//   }

//   void increaseStackCounter() {
//     setState(() {
//       stackCounter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: LayoutBuilder(
//         builder: (context, constraints) => Draggable(
//           onDragEnd: (details) => evaluateSwipe(details.offset.dx),
//           feedback: SizedBox(
//             width: constraints.maxWidth,
//             height: constraints.maxHeight,
//             child: NewSwipingCard(
//               id: profiles[stackCounter].id,
//               userName: profiles[stackCounter].userName,
//               userAge: profiles[stackCounter].userAge,
//               userDescription: profiles[stackCounter].userDescription,
//               profileImageSrc: profiles[stackCounter].ProfileImageSrc,
//             ),
//           ),
//           childWhenDragging: NewSwipingCard(
//             id: profiles[stackCounter + 1].id,
//             userName: profiles[stackCounter + 1].userName,
//             userAge: profiles[stackCounter + 1].userAge,
//             userDescription: profiles[stackCounter + 1].userDescription,
//             profileImageSrc: profiles[stackCounter + 1].ProfileImageSrc,
//           ),
//           child: NewSwipingCard(
//             id: profiles[stackCounter].id,
//             userName: profiles[stackCounter].userName,
//             userAge: profiles[stackCounter].userAge,
//             userDescription: profiles[stackCounter].userDescription,
//             profileImageSrc: profiles[stackCounter].ProfileImageSrc,
//           ),
//         ),
//       ),
//     );
//   }
// }