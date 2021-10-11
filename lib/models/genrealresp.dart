// To parse this JSON data, do
//
//     final successresp = successrespFromJson(jsonString);

import 'dart:convert';

Successresp successrespFromJson(String str) =>
    Successresp.fromJson(json.decode(str));

String successrespToJson(Successresp data) => json.encode(data.toJson());

class Successresp {
  Successresp({
    this.data,
    this.message,
    this.code,
  });

  final List<dynamic>? data;
  final String? message;
  final int? code;

  factory Successresp.fromJson(Map<String, dynamic> json) => Successresp(
        data: List<dynamic>.from(json["data"].map((x) => x)),
        message: json["message"],
        code: json["Code"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x)),
        "message": message,
        "Code": code,
      };
}
