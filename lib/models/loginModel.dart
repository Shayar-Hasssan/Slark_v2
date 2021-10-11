// To parse this JSON data, do
//
//     final registerModel = registerModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    this.data,
    this.message,
    this.code,
  });

  final List<Datum>? data;
  final String? message;
  final int? code;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        message: json["message"],
        code: json["Code"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
        "Code": code,
      };
}

class Datum {
  Datum({
    this.userid,
    this.email,
    this.username,
    this.workSpaces,
  });

  final String? userid;
  final String? email;
  final String? username;
  final List<WorkSpace>? workSpaces;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        userid: json["userid"],
        email: json["Email"],
        username: json["username"],
        workSpaces: List<WorkSpace>.from(
            json["WorkSpaces"].map((x) => WorkSpace.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "userid": userid,
        "Email": email,
        "username": username,
        "WorkSpaces": List<dynamic>.from(workSpaces!.map((x) => x.toJson())),
      };
}

class WorkSpace {
  WorkSpace({
    this.id,
    this.wsName,
    this.ismine,
    this.spaces,
  });

  final String? id;
  final String? wsName;
  final bool? ismine;
  final List<Space>? spaces;

  factory WorkSpace.fromJson(Map<String, dynamic> json) => WorkSpace(
        id: json["Id"],
        wsName: json["WsName"],
        ismine: json["Ismine"],
        spaces: List<Space>.from(json["spaces"].map((x) => Space.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "WsName": wsName,
        "Ismine": ismine,
        "spaces": List<dynamic>.from(spaces!.map((x) => x.toJson())),
      };
}

class Space {
  Space({
    this.id,
    this.name,
  });

  final String? id;
  final String? name;

  factory Space.fromJson(Map<String, dynamic> json) => Space(
        id: json["Id"],
        name: json["Name"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
      };
}
