class OrderReportModel {
  final String? orderNumber;
  final String? orderDate;
  final String? itemName;
  final double? quantity;
  final String? unit;
  final String? orderNote;
  final String? status;
  final String? billNo;
  final String? tableNo;
  final String? voidReason;
  // final dynamic user;

  OrderReportModel({
    this.orderNumber,
    this.orderDate,
    this.itemName,
    this.quantity,
    this.unit,
    this.orderNote,
    this.status,
    this.billNo,
    this.tableNo,
    this.voidReason,
    // this.user,
  });

  factory OrderReportModel.fromJson(Map<String, dynamic> json) {
    return OrderReportModel(
      orderNumber: json['order_number'],
      orderDate: json['order_date'],
      itemName: json['item_name'],
      quantity: double.parse(json['quantity'].toString()),
      unit: json['unit'],
      orderNote: json['order_note'] ?? "",
      status: json['status'],
      billNo: json['bill_no'] ?? "",
      tableNo: json['table_no'],
      voidReason: json['void_reason'] ?? "",
      // user: json['user'],
    );
  }
}
