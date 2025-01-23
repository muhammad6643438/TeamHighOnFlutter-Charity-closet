// To parse this JSON data, do
//
//     final ngosModel = ngosModelFromJson(jsonString);

import 'dart:convert';

List<NgosModel> ngosModelFromJson(String str) =>
    List<NgosModel>.from(json.decode(str).map((x) => NgosModel.fromJson(x)));

String ngosModelToJson(List<NgosModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NgosModel {
  String? id;
  String? desc;
  String? name;

  NgosModel({
    this.id,
    this.desc,
    this.name,
  });

  factory NgosModel.fromJson(Map<String, dynamic> json) => NgosModel(
        id: json["id"],
        desc: json["desc"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "desc": desc,
        "name": name,
      };
}
