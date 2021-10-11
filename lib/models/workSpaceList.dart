// To parse this JSON data, do
//
//     final workSpaceList = workSpaceListFromJson(jsonString);

import 'dart:convert';

WorkSpaceList workSpaceListFromJson(String str) =>
    WorkSpaceList.fromJson(json.decode(str));

String workSpaceListToJson(WorkSpaceList data) => json.encode(data.toJson());

class WorkSpaceList {
  WorkSpaceList({
    this.data,
    this.message,
    this.code,
  });

  final List<Datum>? data;
  final String? message;
  final int? code;

  factory WorkSpaceList.fromJson(Map<String, dynamic> json) => WorkSpaceList(
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
    this.id,
    this.wsName,
    this.ismine,
    this.spaces,
  });

  final String? id;
  final String? wsName;
  final bool? ismine;
  final List<Space>? spaces;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
