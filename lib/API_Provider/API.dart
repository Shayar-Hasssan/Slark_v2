import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

enum RequestType { POST, GET }
enum IsAuthorized { True, False }

class ApiProvider {
  static String BASE_URL = 'http://algheres.net/public';
  static String LoginUrl = '${BASE_URL}/api/login';
  var _headers = {
    'Accept': 'application/json',
  };

  Future<LoginModel> Login(context, String username, String password) async {
    Map body = {"username": username, "password": password};
    var response = await _removeSSL(
        RequestType.POST, LoginUrl, body, context, IsAuthorized.False);
    print(response);

    var res = LoginModel.fromJson(json.decode(response));
    return res;
  }

  _removeSSL(RequestType requestType, String url, Map body, context,
      IsAuthorized isAuthorized) async {
    print(url);
    String reply = "";
    print("im first");
    http.Response response;
    if (requestType == RequestType.POST) {
      print("body: ${json.encode(body).toString()}");
      print('header: ${json.encode(_headers)}');
      response = await _loadRequestPost(url, body, isAuthorized);
      print("second");
    } else {
      response = await _loadRequestGet(url, isAuthorized);
      print("second");
    }

    print("response: ${response.toString()}");
    print("third");
    print(response);
    if (response.statusCode == 200) {
//      reply = await response.transform(utf8.decoder).join();
      print('response is body: ${response.body}');
      return response.body;
    } else
      print(response.statusCode);
    print('response is non: $reply');
  }

  _loadRequestPost(
    String url,
    Map body,
    IsAuthorized isAuthorized,
  ) async {
    if (isAuthorized.index == 0) {
      print('body: -_loadRequestPost ${json.encode(body)}');
      print('_authorizHeader: $_authorizHeader');
      final response =
          await http.post(Uri.parse(url), headers: _authorizHeader, body: body);
      print('response:-- ${response.body}');
      return response;
    } else {
      print('body: -_loadRequestPost ${json.encode(body)}');
      final response =
          await http.post(Uri.parse(url), headers: _headers, body: body);
      print('response:-- ${response.body}');
      return response;
    }
  }

  _loadRequestGet(String url, IsAuthorized isAuthorized) async {
    if (isAuthorized.index == 0) {
      print(_authorizHeader);
      final request = await http.get(Uri.parse(url), headers: _authorizHeader);
      return request;
    } else {
      final request = await http.get(Uri.parse(url), headers: _headers);
      return request;
    }
  }
}

final apiProvider = ApiProvider();
