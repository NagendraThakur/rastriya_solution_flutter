// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class BrandModel {
  String? id;
  String name;
  String? logo;

  BrandModel({
    this.id,
    required this.name,
    this.logo,
  });

  factory BrandModel.fromJson(Map<String, dynamic> json) {
    return BrandModel(
      id: json['id']?.toString(),
      name: json['name'],
      logo: json['logo'],
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'logo': logo,
    };
  }
}
