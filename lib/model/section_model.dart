class SectionModel {
  final int id;
  final String sectionName;
  final int storeId;
  // final String storeName;

  SectionModel({
    required this.id,
    required this.sectionName,
    required this.storeId,
    // required this.storeName,
  });

  factory SectionModel.fromJson(Map<String, dynamic> json) {
    return SectionModel(
      id: json['id'],
      sectionName: json['section_name'],
      storeId: json['store_id'],
      // storeName: json['store_name'],
    );
  }
}
