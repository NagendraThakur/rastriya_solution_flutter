class VoidReasonModel {
  final String id;
  final String reason;

  VoidReasonModel({
    required this.id,
    required this.reason,
  });

  factory VoidReasonModel.fromJson(Map<String, dynamic> json) {
    return VoidReasonModel(
      id: json['id'].toString(),
      reason: json['reason'],
    );
  }
}
