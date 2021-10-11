// To parse this JSON data, do
//
//     final homeModel = homeModelFromJson(jsonString);

import 'dart:convert';

HomeModel homeModelFromJson(String str) => HomeModel.fromJson(json.decode(str));

String homeModelToJson(HomeModel data) => json.encode(data.toJson());

class HomeModel {
  HomeModel({
    this.data,
    this.message,
    this.code,
  });

  final List<Datum>? data;
  final String? message;
  final int? code;

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
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
    this.recentChat,
    this.projects,
    this.spaces,
  });

  final List<RecentChat>? recentChat;
  final List<Project>? projects;
  final List<Space>? spaces;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        recentChat: json["recentChat"] == null
            ? null
            : List<RecentChat>.from(
                json["recentChat"].map((x) => RecentChat.fromJson(x))),
        projects: json["Projects"] == null
            ? null
            : List<Project>.from(
                json["Projects"].map((x) => Project.fromJson(x))),
        spaces: List<Space>.from(json["spaces"].map((x) => Space.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "recentChat": List<dynamic>.from(recentChat!.map((x) => x.toJson())),
        "Projects": List<dynamic>.from(projects!.map((x) => x.toJson())),
        "spaces": List<dynamic>.from(spaces!.map((x) => x.toJson())),
      };
}

class Project {
  Project({
    this.id,
    this.name,
    this.percentage,
    this.creationDate,
  });

  final String? id;
  final String? name;
  final String? percentage;
  final String? creationDate;

  factory Project.fromJson(Map<String, dynamic> json) => Project(
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

class RecentChat {
  RecentChat({
    this.id,
    this.email,
  });

  final String? id;
  final String? email;

  factory RecentChat.fromJson(Map<String, dynamic> json) => RecentChat(
        id: json["id"],
        email: json["Email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "Email": email,
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
