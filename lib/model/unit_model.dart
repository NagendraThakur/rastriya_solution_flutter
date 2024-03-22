class UnitModel {
  final String? id;
  final String name;

  UnitModel({
    this.id,
    required this.name,
  });

  factory UnitModel.fromJson(Map<String, dynamic> json) {
    return UnitModel(
      id: json['id']?.toString(),
      name: json['name'],
    );
  }
}
