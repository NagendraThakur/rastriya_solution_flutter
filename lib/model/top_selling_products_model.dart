class TopSellingProductsModel {
  final String productName;
  final double salesQuantity;
  final double salesReturnQuantity;
  final double netQuantity;
  final double grossAmount;
  final double discountAmount;
  final double amount;
  final double vatAmount;
  final double netAmount;

  TopSellingProductsModel({
    required this.productName,
    required this.salesQuantity,
    required this.salesReturnQuantity,
    required this.netQuantity,
    required this.grossAmount,
    required this.discountAmount,
    required this.amount,
    required this.vatAmount,
    required this.netAmount,
  });

  factory TopSellingProductsModel.fromJson(Map<String, dynamic> json) {
    return TopSellingProductsModel(
      productName: json['product_name'],
      salesQuantity: double.parse(json['sales_quantity'].toString()),
      salesReturnQuantity:
          double.parse(json['sales_return_quantity'].toString()),
      netQuantity: double.parse(json['net_quantity'].toString()),
      grossAmount: double.parse(json['gross_amount'].toString()),
      discountAmount: double.parse(json['discount_amount'].toString()),
      amount: double.parse(json['amount'].toString()),
      vatAmount: double.parse(json['vat_amount'].toString()),
      netAmount: double.parse(json['net_amount'].toString()),
    );
  }
}

class Filter {
  final String startDate;
  final String endDate;
  final String store;

  Filter({
    required this.startDate,
    required this.endDate,
    required this.store,
  });

  factory Filter.fromJson(Map<String, dynamic> json) {
    return Filter(
      startDate: json['start_date'],
      endDate: json['end_date'],
      store: json['store'].toString(),
    );
  }
}
