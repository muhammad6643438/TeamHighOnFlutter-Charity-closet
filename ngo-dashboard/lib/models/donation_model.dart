import 'package:cloud_firestore/cloud_firestore.dart';

class DonationModel {
  String? id;
  String? clothingOption;
  String? selectedNGO;
  String? deliveryMethod;
  String? description;
  bool? hideName;
  String? address;
  String? userEmail;
  Timestamp? timestamp;

  DonationModel({
    this.id,
    this.clothingOption,
    this.selectedNGO,
    this.deliveryMethod,
    this.description,
    this.hideName,
    this.address,
    this.userEmail,
    this.timestamp,
  });

  factory DonationModel.fromJson(Map<String, dynamic> json) {
    return DonationModel(
      id: json['id'],
      clothingOption: json['clothingOption'],
      selectedNGO: json['selectedNGO'],
      deliveryMethod: json['deliveryMethod'],
      description: json['description'],
      hideName: json['hideName'],
      address: json['address'],
      userEmail: json['userEmail'],
      timestamp: json['timestamp'],
    );
  }
}
