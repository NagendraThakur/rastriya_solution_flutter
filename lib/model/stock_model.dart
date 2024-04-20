class StockModel {
  final double quantity;
  final double amount;

  StockModel({required this.quantity, required this.amount});

  factory StockModel.fromJson(Map<String, dynamic> json) {
    return StockModel(
      quantity: json['quantity'] != null
          ? double.parse(json['quantity'].toString())
          : 0.0,
      amount: json['amount'] != null
          ? double.parse(json['amount'].toString())
          : 0.0,
    );
  }
}
