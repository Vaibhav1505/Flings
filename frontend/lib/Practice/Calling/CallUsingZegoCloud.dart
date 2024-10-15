// import 'package:flings_flutter/utils/Utils.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
// import 'dart:math' as math;

// String userID = math.Random().nextInt(10000).toString();

// class VideoCallingUsingZegoCloud extends StatefulWidget {
//   const VideoCallingUsingZegoCloud({super.key});

//   @override
//   State<VideoCallingUsingZegoCloud> createState() =>
//       _VideoCallingUsingZegoCloudState();
// }

// class _VideoCallingUsingZegoCloudState
//     extends State<VideoCallingUsingZegoCloud> {
//   TextEditingController callingIDController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Call")),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: TextFormField(
//               controller: callingIDController,
//               decoration: const InputDecoration(
//                   hintText: "Enter Caller ID", border: OutlineInputBorder()),
//             ),
//           ),
//           const SizedBox(
//             height: 15,
//           ),
//           ElevatedButton(
//               onPressed: () {
//                 Navigator.push(context, MaterialPageRoute(
//                   builder: (context) {
//                     return LiveCallingPreview(
//                       callID: callingIDController.text.toString(),
//                     );
//                   },
//                 ));
//               },
//               child: const Text("Join"))
//         ],
//       ),
//     );
//   }
// }

// class LiveCallingPreview extends StatefulWidget {
//   final String callID;
//   LiveCallingPreview({super.key, required this.callID});

//   @override
//   State<LiveCallingPreview> createState() => _LiveCallingPreviewState();
// }

// class _LiveCallingPreviewState extends State<LiveCallingPreview> {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: ZegoUIKitPrebuiltCall(
//       appID: MyUtils.zegoCloudAppID,
//       appSign: MyUtils.zegoCloudAppSign,
//       callID: widget.callID,
//       userID: userID,
//       userName: 'User_$userID',
//       config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall(),
//     ));
//   }
// }
