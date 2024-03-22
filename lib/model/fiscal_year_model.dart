class FiscalYearModel {
  final String id;
  final String name;
  final String startDate;
  final String endDate;
  final String noSeriesPrefix;
  final String createdAt;
  final String updatedAt;

  FiscalYearModel({
    required this.id,
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.noSeriesPrefix,
    required this.createdAt,
    required this.updatedAt,
  });

  factory FiscalYearModel.fromJson(Map<String, dynamic> json) {
    return FiscalYearModel(
      id: json['id'].toString(),
      name: json['name'].toString(),
      startDate: json['start_date'].toString(),
      endDate: json['end_date'].toString(),
      noSeriesPrefix: json['no_series_prefix'].toString(),
      createdAt: json['created_at'].toString(),
      updatedAt: json['updated_at'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'start_date': startDate,
      'end_date': endDate,
      'no_series_prefix': noSeriesPrefix,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
