// To parse this JSON data, do
//
//     final teammemberModel = teammemberModelFromJson(jsonString);

import 'dart:convert';

TeammemberModel teammemberModelFromJson(String str) =>
    TeammemberModel.fromJson(json.decode(str));

String teammemberModelToJson(TeammemberModel data) =>
    json.encode(data.toJson());

class TeammemberModel {
  TeammemberModel({
    this.data,
    this.message,
    this.code,
  });

  final List<Datum>? data;
  final String? message;
  final int? code;

  factory TeammemberModel.fromJson(Map<String, dynamic> json) =>
      TeammemberModel(
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
    this.name,
  });

  final String? userid;
  final String? name;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        userid: json["userid"],
        name: json["Name"],
      );

  Map<String, dynamic> toJson() => {
        "userid": userid,
        "Name": name,
      };
}
