import 'package:rastriya_solution_flutter/model/section_model.dart';

class TableModel {
  final int? id;
  final String tableName;
  final String sectionId;
  final int guestCapacity;
  final int status;
  final String availability;
  final SectionModel? section;

  TableModel({
    this.id,
    required this.tableName,
    required this.sectionId,
    required this.guestCapacity,
    required this.status,
    required this.availability,
    this.section,
  });

  factory TableModel.fromJson(Map<String, dynamic> json) {
    return TableModel(
      id: json['id'],
      tableName: json['table_name'],
      sectionId: json['section_id'],
      guestCapacity: int.parse(json['guest_capacity']),
      status: int.parse(json['status']),
      availability: json['availability'],
      section: SectionModel.fromJson(json['section']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'table_name': tableName,
      'section_id': sectionId,
      'guest_capacity': guestCapacity.toString(),
      'status': status.toString(),
      'availability': availability,
    };
  }

  @override
  bool operator ==(covariant TableModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.tableName == tableName &&
        other.sectionId == sectionId &&
        other.guestCapacity == guestCapacity &&
        other.status == status &&
        other.availability == availability &&
        other.section == section;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        tableName.hashCode ^
        sectionId.hashCode ^
        guestCapacity.hashCode ^
        status.hashCode ^
        availability.hashCode ^
        section.hashCode;
  }
}
