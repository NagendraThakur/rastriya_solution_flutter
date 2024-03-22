class BatchModel {
  final String? id;
  final String productId;
  final String batchName;
  final double? unitCost;
  final double unitPrice;
  final String? manufacturingDate;
  final String? expirationDate;
  final String? status;
  final String? productName;

  BatchModel({
    this.id,
    required this.productId,
    required this.batchName,
    this.unitCost,
    required this.unitPrice,
    this.manufacturingDate,
    this.expirationDate,
    this.status,
    this.productName,
  });

  factory BatchModel.fromJson(Map<String, dynamic> json) {
    return BatchModel(
      id: json['id']?.toString(),
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
      productName: json['product_name'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_id': productId,
      'batch_name': batchName,
      'unit_cost': unitCost,
      'unit_price': unitPrice,
      'mfg_date': manufacturingDate,
      'exp_date': expirationDate,
      'status': status,
      'product_name': productName,
    };
  }
}
