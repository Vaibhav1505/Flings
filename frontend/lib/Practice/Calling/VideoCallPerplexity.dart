import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:web_socket_channel/io.dart';

class VideoCallScreen extends StatefulWidget {
  final String remoteUserId; // Pass the remote user ID if needed

  VideoCallScreen({Key? key, required this.remoteUserId}) : super(key: key);

  @override
  _VideoCallScreenState createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
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
        child: Column(
          children: [
            Expanded(child: RTCVideoView(_localRenderer)),
            Expanded(child: RTCVideoView(_remoteRenderer)),
          ],
        ),
      ),
    );
  }
}