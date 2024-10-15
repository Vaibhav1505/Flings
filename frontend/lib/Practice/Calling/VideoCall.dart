// ignore_for_file: prefer_const_constructors
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../Providers/StreamSocket.dart';

class VideoCallPage extends StatefulWidget {
  final String targetUserId;

  VideoCallPage({required this.targetUserId});

  @override
  _VideoCallPageState createState() => _VideoCallPageState();
}

class _VideoCallPageState extends State<VideoCallPage> {
  late RTCVideoRenderer _localRenderer;
  late RTCVideoRenderer _remoteRenderer;
  late StreamSocket _streamSocket;
  late RTCPeerConnection _peerConnection;

  @override
  void initState() {
    super.initState();
    _initializeRenderers();
    _streamSocket = StreamSocket();
    _streamSocket.connectAndListen();
    _setupSocketListeners();
    _checkAndRequestPermissions(); // Request necessary permissions
  }

  Future<void> _initializeRenderers() async {
    _localRenderer = RTCVideoRenderer();
    _remoteRenderer = RTCVideoRenderer();
    await _localRenderer.initialize();
    await _remoteRenderer.initialize();
  }

  Future<void> _checkAndRequestPermissions() async {
    if (Platform.isAndroid || Platform.isIOS) {
      final status = await [
        Permission.camera,
        Permission.microphone,
      ].request();

      if (status[Permission.camera]!.isGranted &&
          status[Permission.microphone]!.isGranted) {
        _initializeMedia();
      } else {
        print("Camera and microphone permissions are required.");
      }
    } else {
      _initializeMedia(); // No permissions needed for other platforms
    }
  }

  Future<void> _initializeMedia() async {
    try {
      final mediaConstraints = _getMediaConstraints();
      MediaStream localStream =
          await navigator.mediaDevices.getUserMedia(mediaConstraints);

      _localRenderer.srcObject = localStream;

      // Initialize peer connection and add stream
      _peerConnection = await _createPeerConnection();
      _peerConnection.addStream(localStream);

      // Create offer and send to the target user
      String offerSdp = await _createOffer();
      _streamSocket.sendOffer(offerSdp, widget.targetUserId);
    } catch (e) {
      print('Error accessing media devices: $e');
    }
  }

  Map<String, dynamic> _getMediaConstraints() {
    if (Platform.isAndroid) {
      return {
        'audio': true,
        'video': {'facingMode': 'user'},
      };
    } else if (Platform.isIOS) {
      return {
        'audio': true,
        'video': {
          'facingMode': 'user',
          'width': {'ideal': 640},
          'height': {'ideal': 480},
        },
      };
    } else {
      return {'audio': true, 'video': true}; // Defaults for other platforms
    }
  }

  Future<RTCPeerConnection> _createPeerConnection() async {
    final configuration = {
      'iceServers': [
        {'urls': 'stun:stun.l.google.com:19302'}, // STUN server
      ],
    };

    final constraints = {
      'mandatory': {},
      'optional': [{'DtlsSrtpKeyAgreement': true}],
    };

    return await createPeerConnection(configuration, constraints);
  }

  Future<String> _createOffer() async {
    RTCSessionDescription offer = await _peerConnection.createOffer();
    await _peerConnection.setLocalDescription(offer);
    return offer.sdp!;
  }

  void _setupSocketListeners() {
    _streamSocket.getVideoResponse.listen((data) {
      _handleVideoSignal(data);
    });
  }

  void _handleVideoSignal(Map<String, dynamic> data) {
    if (data['offer'] != null) {
      _handleOffer(data['offer']);
    } else if (data['answer'] != null) {
      _handleAnswer(data['answer']);
    } else if (data['candidate'] != null) {
      _handleCandidate(data['candidate']);
    }
  }

  void _handleOffer(String offer) async {
    await _peerConnection.setRemoteDescription(
        RTCSessionDescription(offer, 'offer'));

    RTCSessionDescription answer = await _peerConnection.createAnswer();
    await _peerConnection.setLocalDescription(answer);

    _streamSocket.sendAnswer(answer.sdp!, widget.targetUserId);
  }

  void _handleAnswer(String answer) async {
    await _peerConnection.setRemoteDescription(
        RTCSessionDescription(answer, 'answer'));
  }

  void _handleCandidate(Map<String, dynamic> candidate) async {
    final iceCandidate = RTCIceCandidate(
      candidate['candidate'],
      candidate['sdpMid'],
      candidate['sdpMLineIndex'],
    );

    try {
      await _peerConnection.addCandidate(iceCandidate);
    } catch (e) {
      print("Error adding ICE candidate: $e");
    }
  }

  @override
  void dispose() {
    _localRenderer.dispose();
    _remoteRenderer.dispose();
    _streamSocket.dispose();
    _peerConnection.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Call'),
        actions: [
          IconButton(
            icon: Icon(Icons.call_end),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              child: RTCVideoView(_remoteRenderer),
              color: Colors.black,
            ),
          ),
          Positioned(
            top: 20,
            right: 20,
            width: 120,
            height: 160,
            child: RTCVideoView(_localRenderer, mirror: true),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _initializeMedia();
        },
        child: Icon(Icons.videocam),
      ),
    );
  }
}
