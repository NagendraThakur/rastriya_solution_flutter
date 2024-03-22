class BatchModel {
  final String id;
  final String productId;
  final String batchName;
  final double? unitCost;
  final double unitPrice;
  final String? manufacturingDate;
  final String? expirationDate;
  final String? status;
  final String? createdAt;
  final String? updatedAt;
  final String? productName;

  BatchModel({
    required this.id,
    required this.productId,
    required this.batchName,
    this.unitCost,
    required this.unitPrice,
    this.manufacturingDate,
    this.expirationDate,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.productName,
  });

  factory BatchModel.fromJson(Map<String, dynamic> json) {
    return BatchModel(
      id: json['id'].toString(),
      productId: json['product_id'].toString(),
      batchName: json['batch_name'],
      unitCost: json['unit_cost'] != null
          ? double.parse(
              (double.parse(json['unit_cost'].toString())).toStringAsFixed(2))
          : null,
      unitPrice: double.parse(
          (double.parse(json['unit_price'].toString())).toStringAsFixed(2)),
      manufacturingDate: json['mfg_date'].toString(),
      expirationDate: json['exp_date'].toString(),
      status: json['status'].toString(),
      createdAt: json['created_at'].toString(),
      updatedAt: json['updated_at'].toString(),
      productName: json['product_name'],
    );
  }
}
