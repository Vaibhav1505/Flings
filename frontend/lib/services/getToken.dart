import 'package:flutter_secure_storage/flutter_secure_storage.dart';

//For Retrieving Token from Storage

class Token {
  var storage = const FlutterSecureStorage();
  Future<String> getToken() async {
    return await storage.read(key: 'token') ?? "No Token";
  }
}
