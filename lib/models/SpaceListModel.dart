// To parse this JSON data, do
//
//     final spaceListModel = spaceListModelFromJson(jsonString);

import 'dart:convert';

SpaceListModel spaceListModelFromJson(String str) =>
    SpaceListModel.fromJson(json.decode(str));

String spaceListModelToJson(SpaceListModel data) => json.encode(data.toJson());

class SpaceListModel {
  SpaceListModel({
    this.data,
    this.message,
    this.code,
  });

  final List<Datum>? data;
  final String? message;
  final int? code;

  factory SpaceListModel.fromJson(Map<String, dynamic> json) => SpaceListModel(
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
        id: json["Id"],
        name: json["Name"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
      };
}
