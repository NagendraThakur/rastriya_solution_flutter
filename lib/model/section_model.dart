class SectionModel {
  final int? id;
  final String sectionName;
  final String storeId;
  // final String storeName;

  SectionModel({
    this.id,
    required this.sectionName,
    required this.storeId,
    // required this.storeName,
  });

  factory SectionModel.fromJson(Map<String, dynamic> json) {
    return SectionModel(
      id: json['id'],
      sectionName: json['section_name'],
      storeId: json['store_id'].toString(),
      // storeName: json['store_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'section_name': sectionName,
      'store_id': storeId,
    };
  }

  SectionModel copyWith({
    int? id,
    String? sectionName,
    String? storeId,
  }) {
    return SectionModel(
      id: id ?? this.id,
      sectionName: sectionName ?? this.sectionName,
      storeId: storeId ?? this.storeId,
    );
  }
}
