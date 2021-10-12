// To parse this JSON data, do
//
//     final successresp = successrespFromJson(jsonString);

import 'dart:convert';

Teamlist teamlistFromJson(String str) => Teamlist.fromJson(json.decode(str));

String teamlistToJson(Teamlist data) => json.encode(data.toJson());

class Teamlist {
  Teamlist({
    this.data,
    this.message,
    this.code,
  });

  final List<Datum>? data;
  final String? message;
  final int? code;

  factory Teamlist.fromJson(Map<String, dynamic> json) => Teamlist(
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
