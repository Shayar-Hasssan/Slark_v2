// To parse this JSON data, do
//
//     final projectmembermodel = projectmembermodelFromJson(jsonString);

import 'dart:convert';

Projectmembermodel projectmembermodelFromJson(String str) =>
    Projectmembermodel.fromJson(json.decode(str));

String projectmembermodelToJson(Projectmembermodel data) =>
    json.encode(data.toJson());

class Projectmembermodel {
  Projectmembermodel({
    this.data,
    this.message,
    this.code,
  });

  final List<Datum>? data;
  final String? message;
  final int? code;

  factory Projectmembermodel.fromJson(Map<String, dynamic> json) =>
      Projectmembermodel(
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
