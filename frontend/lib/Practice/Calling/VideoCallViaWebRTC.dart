import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:web_socket_channel/io.dart';

class VideoCallViaWebRTC extends StatefulWidget {
  final String remoteUserId;

  VideoCallViaWebRTC({Key? key, required this.remoteUserId}) : super(key: key);

  @override
  _VideoCallViaWebRTCState createState() => _VideoCallViaWebRTCState();
}

class _VideoCallViaWebRTCState extends State<VideoCallViaWebRTC> {
  late RTCPeerConnection _peerConnection;
  late MediaStream _localStream;
  late MediaStream _remoteStream;
  late RTCVideoRenderer _localRenderer;
  late RTCVideoRenderer _remoteRenderer;
  late IOWebSocketChannel _channel;

  @override
  void initState() {
    super.initState();
    _initRenderers();
    _initWebRTC();
    _initSignaling();
  }

  Future<void> _initRenderers() async {
    _localRenderer = RTCVideoRenderer();
    _remoteRenderer = RTCVideoRenderer();
    await _localRenderer.initialize();
    await _remoteRenderer.initialize();
  }

  Future<void> _initWebRTC() async {
    // Get user media
    _localStream = await navigator.mediaDevices.getUserMedia({
      'audio': true,
      'video': {
        'facingMode': 'user',
      },
    });

    // Create peer connection
    _peerConnection = await createPeerConnection({
      'iceServers': [
        {'urls': 'stun:stun.l.google.com:19302'},
      ],
    });

    // Add local stream to peer connection
    _peerConnection.addStream(_localStream);

    // Handle remote stream
    _peerConnection.onAddStream = (MediaStream stream) {
      setState(() {
        _remoteStream = stream;
        _remoteRenderer.srcObject = _remoteStream;
      });
    };

    // Set local renderer
    _localRenderer.srcObject = _localStream;

    // Create an offer and send it to the remote peer
    RTCSessionDescription description = await _peerConnection.createOffer();
    await _peerConnection.setLocalDescription(description);
    _sendMessage({
      'type': 'offer',
      'offer': description.toMap(),
      'to': widget.remoteUserId, // Specify the remote user ID
    });
  }

  void _sendMessage(Map<String, dynamic> message) {
    _channel.sink.add(jsonEncode(message));
  }

  Future<void> _initSignaling() async {
    _channel = IOWebSocketChannel.connect('ws://your-signaling-server.com');

    // Handle incoming messages from the signaling server
    _channel.stream.listen((message) {
      Map<String, dynamic> json = jsonDecode(message);
      switch (json['type']) {
        case 'offer':
          _handleOffer(json['offer']);
          break;
        case 'answer':
          _handleAnswer(json['answer']);
          break;
        case 'candidate':
          _handleCandidate(json['candidate']);
          break;
      }
    });
  }

  Future<void> _handleOffer(Map<String, dynamic> offer) async {
    await _peerConnection.setRemoteDescription(RTCSessionDescription(
      offer['sdp'],
      offer['type'],
    ));

    RTCSessionDescription description = await _peerConnection.createAnswer();
    await _peerConnection.setLocalDescription(description);
    _sendMessage({
      'type': 'answer',
      'answer': description.toMap(),
      'to': widget.remoteUserId, // Specify the remote user ID
    });
  }

  Future<void> _handleAnswer(Map<String, dynamic> answer) async {
    await _peerConnection.setRemoteDescription(RTCSessionDescription(
      answer['sdp'],
      answer['type'],
    ));
  }

  void _handleCandidate(Map<String, dynamic> candidate) {
    _peerConnection.addCandidate(RTCIceCandidate(
      candidate['candidate'],
      candidate['sdpMid'],
      candidate['sdpMLineIndex'],
    ));
  }

  void _endCall() async {
    _localStream?.getTracks().forEach((track) {
      track.stop();
    });
  }

  @override
  void dispose() {
    _localRenderer.dispose();
    _remoteRenderer.dispose();
    _localStream.dispose();
    _peerConnection.close();
    _channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Video Call')),
      body: Center(
        child: Stack(
          children: [
            Stack(children: [
              RTCVideoView(_localRenderer,
                  objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                  filterQuality: FilterQuality.high),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () {
                        debugPrint("Mute The user");
                      },
                      icon: const Icon(
                        CupertinoIcons.mic_slash_fill,
                        color: Colors.white,
                        size: 35,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        _endCall();
                      },
                      icon: const Icon(
                        CupertinoIcons.phone_down_circle_fill,
                        color: Colors.red,
                        size: 35,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        debugPrint("flip the camera");
                      },
                      icon: const Icon(
                        CupertinoIcons.camera_rotate_fill,
                        color: Colors.white,
                        size: 35,
                      ),
                    ),
                  ],
                ),
              )
            ]),
            Container(
                decoration: BoxDecoration(color: Colors.green),
                height: 100,
                width: 100,
                child: RTCVideoView(_remoteRenderer)),
          ],
        ),
      ),
    );
  }
}
