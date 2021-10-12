// To parse this JSON data, do
//
//     final projecttaskmodel = projecttaskmodelFromJson(jsonString);

import 'dart:convert';

Projecttaskmodel projecttaskmodelFromJson(String str) =>
    Projecttaskmodel.fromJson(json.decode(str));

String projecttaskmodelToJson(Projecttaskmodel data) =>
    json.encode(data.toJson());

class Projecttaskmodel {
  Projecttaskmodel({
    this.data,
    this.message,
    this.code,
  });

  final List<Datum>? data;
  final String? message;
  final int? code;

  factory Projecttaskmodel.fromJson(Map<String, dynamic> json) =>
      Projecttaskmodel(
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
  });

  final String? id;
  final String? name;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["Name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "Name": name,
      };
}
