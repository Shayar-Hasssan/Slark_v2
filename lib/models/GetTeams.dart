// To parse this JSON data, do
//
//     final getTeamList = getTeamListFromJson(jsonString);

import 'dart:convert';

GetTeamList getTeamListFromJson(String str) =>
    GetTeamList.fromJson(json.decode(str));

String getTeamListToJson(GetTeamList data) => json.encode(data.toJson());

class GetTeamList {
  GetTeamList({
    this.data,
    this.message,
    this.code,
  });

  final List<Datum>? data;
  final String? message;
  final int? code;

  factory GetTeamList.fromJson(Map<String, dynamic> json) => GetTeamList(
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
    this.name,
    this.members,
  });

  final String? id;
  final String? name;
  final List<Member>? members;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["Name"],
        members:
            List<Member>.from(json["members"].map((x) => Member.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "Name": name,
        "members": List<dynamic>.from(members!.map((x) => x.toJson())),
      };
}

class Member {
  Member({
    this.id,
    this.userid,
    this.name,
    this.isTeamLeader,
  });

  final String? id;
  final String? userid;
  final String? name;
  final String? isTeamLeader;

  factory Member.fromJson(Map<String, dynamic> json) => Member(
        id: json["id"],
        userid: json["userid"],
        name: json["Name"],
        isTeamLeader: json["isTeamLeader"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userid": userid,
        "Name": name,
        "isTeamLeader": isTeamLeader,
      };
}
