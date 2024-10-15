import 'dart:async';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../routes/apiStrings.dart';

class StreamSocket {
  StreamSocket() {
    connectAndListen(); // Automatically connect when StreamSocket is initialized
  }

  late IO.Socket socket;

  // Stream for chat messages
  final _chatStreamController = StreamController<Map<String, String>>.broadcast();
  Stream<Map<String, String>> get chatStream => _chatStreamController.stream;

  // Stream for WebRTC signaling events
  final _videoStreamController = StreamController<Map<String, dynamic>>.broadcast();
  Stream<Map<String, dynamic>> get getVideoResponse => _videoStreamController.stream;

  void connectAndListen() async {
    socket = await buildSocket();

    // Connection and error handling
    socket.onConnect((_) => print('Connected to Socket.io'));
    socket.onDisconnect((_) => print('Socket disconnected'));
    socket.onConnectError((error) => print('Connection Error: $error'));
    socket.onReconnect((attempt) => print('Reconnected on attempt: $attempt'));

    // Listen for chat messages
    socket.on('getResponse', _handleChatMessage);

    // Listen for WebRTC signaling events
    socket.on('offer', (data) => _handleVideoEvent(data, 'offer'));
    socket.on('answer', (data) => _handleVideoEvent(data, 'answer'));
    socket.on('candidate', (data) => _handleVideoEvent(data, 'candidate'));
  }

  void _handleChatMessage(dynamic data) {
    if (data == null || data['message'] == null || data['from'] == null) {
      print("Invalid chat message data");
      return;
    }

    String messageText = data['message'];
    String fromUserId = data['from'];
    String messageId = data['id'] ?? DateTime.now().millisecondsSinceEpoch.toString();

    _chatStreamController.add({
      'message': messageText,
      'from': fromUserId,
      'id': messageId,
    });
  }

  void _handleVideoEvent(Map<String, dynamic> data, String type) {
    print('Received $type: $data');
    _videoStreamController.add({'type': type, 'data': data});
  }

  // Emit WebRTC signaling events
  void sendOffer(String sdp, String targetUserID) {
    socket.emit('offer', {'offer': sdp, 'targetUserID': targetUserID});
    print('Sent offer to $targetUserID');
  }

  void sendAnswer(String sdp, String targetUserID) {
    socket.emit('answer', {'answer': sdp, 'targetUserID': targetUserID});
    print('Sent answer to $targetUserID');
  }

  void sendCandidate(Map<String, dynamic> candidate, String targetUserID) {
    socket.emit('candidate', {'candidate': candidate, 'targetUserID': targetUserID});
    print('Sent ICE candidate to $targetUserID');
  }

  void sendMessage(String message, String userID) {
    String messageData = jsonEncode({'message': message, 'to': userID});
    socket.emit('sendMessage', messageData);
    print("Sent message: $messageData");
  }

  void dispose() {
    _chatStreamController.close();
    _videoStreamController.close();
    socket.disconnect();
  }

  Future<String> getToken() async {
    const storage = FlutterSecureStorage();
    return await storage.read(key: "token") ?? "No Token Received from Storage";
  }

  Future<IO.Socket> buildSocket() async {
    String token = await getToken();
    
    if (token == 'No Token Received from Storage') {
      print("No Token found, cannot connect to Socket");
      return Future.error("No Token");
    }

    String urlWithToken = '$BASE_URL?token=$token'; 
    return IO.io(urlWithToken, <String, dynamic>{
      'transports': ['websocket'],
      'auth': {'Authorization': 'Bearer $token'},
      'extraHeaders': {'Authorization': 'Bearer $token'},
      'reconnection': true,
      'reconnectionAttempts': 5,
      // Add a timeout for connection attempts
      'timeout': 5000,
      // Optionally add a ping interval
      'pingInterval': 25000,
      'pingTimeout': 60000,
    });
  }
}