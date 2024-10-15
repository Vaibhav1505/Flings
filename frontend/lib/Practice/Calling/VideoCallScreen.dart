import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

class VideoCallScreen extends StatefulWidget {
  VideoCallScreen({super.key});

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  final _remoteVideoRenderer = RTCVideoRenderer();
  final _localVideoRenderer = RTCVideoRenderer();
  RTCPeerConnection? _peerConnection;
  MediaStream? _localStream;

  @override
  void initState() {
    initRenderers();
    _getUserMedia();
    super.initState();
  }

  void initRenderers() async {
    await _localVideoRenderer.initialize();
  }

  _getUserMedia() async {
    _localStream = await _getUserMedia();
    RTCPeerConnection pc = await createPeerConnection(configurations,offerSdpConstraints);
    pc.addStream(_localStream!);
    pc.onIceCandidate = (e) {
      if (e.candidate != null) {
        print(json.encode({
          'candidate': e.candidate,
          'sdpMid': e.sdpMid,
          'sdpMlineIndex': e.sdpMLineIndex
        }));
      }
    };
    final Map<String, dynamic> mediaConstraints = {
      'audio': true,
      'video': {
        'facingMode': 'user',
      },

    
    };

    MediaStream stream =
        await navigator.mediaDevices.getUserMedia(mediaConstraints);
    _localVideoRenderer.srcObject = stream;
  }

  

  Map<String, dynamic> configurations = {
    "iceServers": [
      {"url": "stun:stun.l.google.com:19302"},
    ]
  };

  Map<String, dynamic> offerSdpConstraints = {
    "mendatory": {"OfferToReceiveAudio": true, "OfferToReceiveVideo": true},
    "optional": []
  };

  @override
  void dispose() async {
    _localVideoRenderer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Video Call"),
      ),
      body: Column(
        children: [videoRenderer()],
      ),
    );
  }

  SizedBox videoRenderer() => SizedBox(
        height: 210,
        child: Row(children: [
          Flexible(
            child: Container(
              key: const Key('local'),
              margin: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
              decoration: const BoxDecoration(color: Colors.black),
              child: RTCVideoView(_localVideoRenderer),
            ),
          ),
          Flexible(
            child: Container(
              key: const Key('remote'),
              margin: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
              decoration: const BoxDecoration(color: Colors.black),
              child: RTCVideoView(_remoteVideoRenderer),
            ),
          ),
        ]),
      );
}
