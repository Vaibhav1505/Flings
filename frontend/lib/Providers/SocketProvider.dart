import 'dart:async';

import 'package:flings_flutter/Providers/StreamSocket.dart';
import 'package:flings_flutter/routes/apiStrings.dart';
import 'package:flings_flutter/services/getToken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketProviderContext with ChangeNotifier {
  late IO.Socket socket;

  final StreamController<String> _recievedMessageController =
      StreamController<String>.broadcast(sync: true);
  Stream<String> get messageStream => _recievedMessageController.stream;

  final storage = const FlutterSecureStorage();

  StreamSocket streamSocket =StreamSocket();

  var token = Token();

  // void initSocket() async {
  //   socket = await initWebsocket();
  //   // connectAndListen();
  //   ChangeNotifier();
  // }

  void initWebsocket() async {
    try {
      var tokenFromStorage = await token.getToken();
      var urlWithToken = '$BASE_URL?token=$tokenFromStorage';

      socket = IO.io(urlWithToken, <String, dynamic>{
        // 'autoConnect': false,
        'transports': ['websocket'],
        'auth': {"Authorization": 'Bearer $tokenFromStorage'},
        'extraHeaders': {'Authorization': 'Bearer $tokenFromStorage'},
      });

      socket.on('msg', (data) {
        print("Socket on");

        _recievedMessageController.sink.add(data);
        notifyListeners();
      });
      socket.onConnect((_) {
        print("Connection established with Socket.io");
      });
      socket.onDisconnect((_) {
        print("Connection Disconnected with Socket.io initWebSocket");
      });
      socket.onConnectError((err) => print("onConnectError:" + err.toString()));
      socket.onError((err) => print("onError:" + err.toString()));
      ChangeNotifier();
    } catch (e) {
      debugPrint("Error:" + e.toString());
      // Handle error, e.g., retry or notify user
    }
  }

  void sendMessage(String message) {
    print("msg emit");
    socket.emit("msg", [message]);
    notifyListeners();
  }

  @override
  void dispose() {
    _recievedMessageController.close();
    socket.disconnect();
    super.dispose();
  }
}
