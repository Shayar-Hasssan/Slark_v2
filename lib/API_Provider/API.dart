import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:slark_v2/models/GetTeams.dart';
import 'package:slark_v2/models/HomeModel.dart';
import 'package:slark_v2/models/ProjectDetailsModel.dart';
import 'package:slark_v2/models/genrealresp.dart';
import 'package:slark_v2/models/loginModel.dart';
import 'package:slark_v2/models/projectList.dart';
import 'package:slark_v2/models/registerModel.dart';
import 'package:slark_v2/models/teamlist.dart';
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
  static String wsmemURL = '${BASE_URL}/api/wsmem?wksid=';
  static String PostTeamURL = '${BASE_URL}/api/PostTeam';
  static String allprojectsURL = '${BASE_URL}/api/allprojects?spid=';
  static String activeprojectsUrl = '${BASE_URL}/api/activeprojects?spid=';
  static String completedprojectsUrl =
      '${BASE_URL}/api/completedprojects?spid=';
  static String projectdetailsURL = '${BASE_URL}/api/projectdetails?projtid=';
  static String projmemUrl = '${BASE_URL}/api/projectmember?projtid=';

  static String posttaskurl = '${BASE_URL}/api/PostTask';

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

  Future<Successresp> postTeam(context, String wksid, String teamname,
      List<String> membid, String leadid) async {
    Map body = {
      "wksid": wksid,
      "teamname": teamname,
      "membid": membid,
      "leadid": leadid
    };
    var response =
        await _removeSSL(RequestType.POST, PostTeamURL, body, context);
    print(response);
    var res = Successresp.fromJson(json.decode(response));
    return res;
  }

  Future<Successresp> postTask(context, String projectid, String name,
      String userid, String date, String prio, String dep) async {
    Map body = {};
    var response = await _removeSSL(
        RequestType.POST,
        posttaskurl +
            "?projectid=" +
            projectid +
            "&name=" +
            name +
            "&userid=" +
            userid +
            "&date=" +
            date +
            "&prio=" +
            prio +
            "&prio=" +
            prio +
            "&dep=" +
            dep,
        body,
        context);
    print(response);
    var res = Successresp.fromJson(json.decode(response));
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

  Future<ProjectList> allprojects(context, String spid) async {
    dynamic body = {};

    var response = await _removeSSL(
        RequestType.POST, allprojectsURL + spid, body, context);

    print(response);
    return ProjectList.fromJson(json.decode(response));
  }

  Future<ProjectList> activeprojects(context, String spid) async {
    dynamic body = {};

    var response = await _removeSSL(
        RequestType.POST, activeprojectsUrl + spid, body, context);

    print(response);
    return ProjectList.fromJson(json.decode(response));
  }

  Future<ProjectList> completedprojects(context, String spid) async {
    dynamic body = {};

    var response = await _removeSSL(
        RequestType.POST, completedprojectsUrl + spid, body, context);

    print(response);
    return ProjectList.fromJson(json.decode(response));
  }

  Future<GetTeamList> getteam(context, String workspaceid) async {
    Map body = {};
    var response = await _removeSSL(
        RequestType.POST, GetTeamListURL + workspaceid, body, context);
    print(response);
    var res = GetTeamList.fromJson(json.decode(response));
    return res;
  }

  Future<Teamlist> getteamlist(context, String workspaceid) async {
    Map body = {};
    var response = await _removeSSL(
        RequestType.POST, wsmemURL + workspaceid, body, context);
    print(response);
    var res = Teamlist.fromJson(json.decode(response));
    return res;
  }

  Future<GetTeamList> getteampro(context, String proid) async {
    Map body = {};
    var response =
        await _removeSSL(RequestType.POST, projmemUrl + proid, body, context);
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

  Future<ProjectdetailsModel> prdetails(context, String pid) async {
    dynamic body = {};

    var response = await _removeSSL(
        RequestType.POST, projectdetailsURL + pid, body, context);

    print(response);
    return ProjectdetailsModel.fromJson(json.decode(response));
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
