// To parse this JSON data, do
//
//     final ngosModel = ngosModelFromJson(jsonString);

import 'dart:convert';

List<BrandsModel> brandsModelFromJson(String str) => List<BrandsModel>.from(
    json.decode(str).map((x) => BrandsModel.fromJson(x)));

String ngosModelToJson(List<BrandsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BrandsModel {
  String? id;
  String? desc;
  String? name;

  BrandsModel({
    this.id,
    this.desc,
    this.name,
  });

  factory BrandsModel.fromJson(Map<String, dynamic> json) => BrandsModel(
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
