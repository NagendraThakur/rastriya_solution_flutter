class AssetsModel {
  final String uploads;

  AssetsModel({required this.uploads});

  factory AssetsModel.fromMap(Map<String, dynamic> json) {
    return AssetsModel(
      uploads: json['uploads'],
    );
  }
}
