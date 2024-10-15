import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;


class InterceptedHTTP {

  final storage = const FlutterSecureStorage();

  Map<String, String> headers = {};

  Future<dynamic> postHttp(String baseURL, var data) async {
    var postResponse =
        await http.post(Uri.parse(baseURL), body: jsonEncode(data), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${await storage.read(key: "token")}",
    });
    return postResponse;
  }

  Future<dynamic> getHttp(String baseURL) async {
    var getResponse = await http.get(Uri.parse(baseURL), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${await storage.read(key: "token")}",
    });
    return getResponse;
  }
}
