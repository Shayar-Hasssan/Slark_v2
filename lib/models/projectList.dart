// To parse this JSON data, do
//
//     final projectList = projectListFromJson(jsonString);

import 'dart:convert';

ProjectList projectListFromJson(String str) =>
    ProjectList.fromJson(json.decode(str));

String projectListToJson(ProjectList data) => json.encode(data.toJson());

class ProjectList {
  ProjectList({
    this.data,
    this.message,
    this.code,
  });

  final List<Datum>? data;
  final String? message;
  final int? code;

  factory ProjectList.fromJson(Map<String, dynamic> json) => ProjectList(
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
    this.percentage,
    this.creationDate,
  });

  final String? id;
  final String? name;
  final String? percentage;
  final String? creationDate;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["Name"],
        percentage: json["Percentage"],
        creationDate: json["CreationDate"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "Name": name,
        "Percentage": percentage,
        "CreationDate": creationDate,
      };
}
