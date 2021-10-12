import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:slark_v2/models/GetTeams.dart';
import 'package:slark_v2/models/HomeModel.dart';
import 'package:slark_v2/models/genrealresp.dart';
import 'package:slark_v2/models/loginModel.dart';
import 'package:slark_v2/models/registerModel.dart';
import 'package:slark_v2/models/workSpaceList.dart';

enum RequestType { POST, GET }

class ApiProvider {
  static String BASE_URL = 'http://anaskannass1995-001-site1.itempurl.com';
  static String RegisterURL = '${BASE_URL}/api/register';
  static String LoginURl = '${BASE_URL}/api/login';
  static String showallworkspaceURL = '${BASE_URL}/api/GetWorkSpace?id=';
  static String HomeURL = '${BASE_URL}/api/GetHome?id=';
  static String PostSpaceURL = '${BASE_URL}/api/PostSpace';
  static String PostworkSpaceURL = '${BASE_URL}/api/PostworkSpace';
  static String PostProjectURL = '${BASE_URL}/api/PostProject';
  static String GetTeamListURL = '${BASE_URL}/api/GetTeamList?workspaceid=';
  var _headers = {
    'Accept': 'application/json',
  };

  Future<RegisterModel> Register(
      context, String Email, String password, String Name) async {
    Map body = {"Email": Email, "password": password, "Name": Name};
    var response =
        await _removeSSL(RequestType.POST, RegisterURL, body, context);
    print(response);
    var res = RegisterModel.fromJson(json.decode(response));
    return res;
  }

  Future<LoginModel> Login(context, String Email, String password) async {
    Map body = {"Email": Email, "password": password};
    var response = await _removeSSL(RequestType.POST, LoginURl, body, context);
    print(response);
    var res = LoginModel.fromJson(json.decode(response));
    return res;
  }

  Future<Successresp> PostSpace(context, String wsid, String spacename) async {
    Map body = {};
    var response = await _removeSSL(
        RequestType.POST,
        PostSpaceURL + "?wsid=" + wsid + "&spacename=" + spacename,
        body,
        context);
    print(response);
    var res = Successresp.fromJson(json.decode(response));
    return res;
  }

  Future<Successresp> PostworkSpace(
      context, String userid, String spacename) async {
    Map body = {};
    var response = await _removeSSL(
        RequestType.POST,
        PostworkSpaceURL + "?userid=" + userid + "&spacename=" + spacename,
        body,
        context);
    print(response);
    var res = Successresp.fromJson(json.decode(response));
    return res;
  }

  Future<Successresp> PostProject(context, String spaceid, String projectname,
      String teamid, String datee) async {
    Map body = {};
    var response = await _removeSSL(
        RequestType.POST,
        PostProjectURL +
            "?spaceid=" +
            spaceid +
            "&projectname=" +
            projectname +
            "&teamid=" +
            teamid +
            "&datee=" +
            datee,
        body,
        context);
    print(response);
    var res = Successresp.fromJson(json.decode(response));
    return res;
  }

  Future<WorkSpaceList> showallworkspaces(context, String userid) async {
    dynamic body = {};

    var response = await _removeSSL(
        RequestType.POST, showallworkspaceURL + userid, body, context);

    print(response);
    return WorkSpaceList.fromJson(json.decode(response));
  }

  Future<GetTeamList> getteam(context, String workspaceid) async {
    Map body = {};
    var response = await _removeSSL(
        RequestType.POST, GetTeamListURL + workspaceid, body, context);
    print(response);
    var res = GetTeamList.fromJson(json.decode(response));
    return res;
  }

  Future<HomeModel> showHome(
      context, String userid, String wkid, String spaceid) async {
    dynamic body = {};

    var response = await _removeSSL(
        RequestType.POST,
        HomeURL + wkid + "&userid=" + userid + "&spaceid=" + spaceid,
        body,
        context);

    print(response);
    return HomeModel.fromJson(json.decode(response));
  }

  _removeSSL(
    RequestType requestType,
    String url,
    Map body,
    context,
  ) async {
    print(url);
    String reply = "";
    print("im first");
    http.Response response;
    if (requestType == RequestType.POST) {
      print("body: ${json.encode(body).toString()}");
      print('header: ${json.encode(_headers)}');
      response = await _loadRequestPost(url, body);
      print("second");
    } else {
      response = await _loadRequestGet(url);
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
  ) async {
    print('body: -_loadRequestPost ${json.encode(body)}');
    final response =
        await http.post(Uri.parse(url), headers: _headers, body: body);
    print('response:-- ${response.body}');
    return response;
  }

  _loadRequestGet(String url) async {
    final request = await http.get(Uri.parse(url), headers: _headers);
    return request;
  }
}

final apiProvider = ApiProvider();
