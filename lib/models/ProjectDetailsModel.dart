// To parse this JSON data, do
//
//     final projectdetailsModel = projectdetailsModelFromJson(jsonString);

import 'dart:convert';

ProjectdetailsModel projectdetailsModelFromJson(String str) =>
    ProjectdetailsModel.fromJson(json.decode(str));

String projectdetailsModelToJson(ProjectdetailsModel data) =>
    json.encode(data.toJson());

class ProjectdetailsModel {
  ProjectdetailsModel({
    this.data,
    this.message,
    this.code,
  });

  final List<Datum>? data;
  final String? message;
  final int? code;

  factory ProjectdetailsModel.fromJson(Map<String, dynamic> json) =>
      ProjectdetailsModel(
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
    this.tasks,
  });

  final String? id;
  final String? name;
  final String? percentage;
  final String? creationDate;
  final List<Task>? tasks;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["Name"],
        percentage: json["Percentage"],
        creationDate: json["CreationDate"],
        tasks: List<Task>.from(json["tasks"].map((x) => Task.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "Name": name,
        "Percentage": percentage,
        "CreationDate": creationDate,
        "tasks": List<dynamic>.from(tasks!.map((x) => x.toJson())),
      };
}

class Task {
  Task({
    this.taskname,
    this.taskEndDate,
    this.donePrecentage,
    this.username,
  });

  final String? taskname;
  final DateTime? taskEndDate;
  final double? donePrecentage;
  final String? username;

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        taskname: json["taskname"],
        taskEndDate: DateTime.parse(json["TaskEndDate"]),
        donePrecentage: json["DonePrecentage"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "taskname": taskname,
        "TaskEndDate": taskEndDate!.toIso8601String(),
        "DonePrecentage": donePrecentage,
        "username": username,
      };
}
