class VoidReportModel {
  int? id;
  String? billNo;
  int? productId;
  int? userId;
  int? qty;
  double? amount;
  double? rate;
  int? storeId;
  int? terminalId;
  int? tableId;
  int? voidReasonId;
  String? productName;
  String? storeName;
  String? terminalName;
  String? tableName;
  String? reason;
  UserInfo? userInfo;

  VoidReportModel(
      {this.id,
      this.billNo,
      this.productId,
      this.userId,
      this.qty,
      this.amount,
      this.rate,
      this.storeId,
      this.terminalId,
      this.tableId,
      this.voidReasonId,
      this.productName,
      this.storeName,
      this.terminalName,
      this.tableName,
      this.reason,
      this.userInfo});

  factory VoidReportModel.fromJson(Map<String, dynamic> json) {
    return VoidReportModel(
      id: json['id'],
      billNo: json['bill_no'],
      productId: json['product_id'],
      userId: json['user_id'],
      qty: json['qty'],
      amount: double.parse(json['amount']),
      rate: double.parse(json['rate']),
      storeId: json['store_id'],
      terminalId: json['terminal_id'],
      tableId: json['table_id'],
      voidReasonId: json['void_reason_id'],
      productName: json['product_name'],
      storeName: json['store_name'],
      terminalName: json['terminal_name'],
      tableName: json['table_name'],
      reason: json['reason'],
      userInfo: UserInfo.fromJson(json['user_info']),
    );
  }
}

class UserInfo {
  String? username;
  String? fullName;

  UserInfo({this.username, this.fullName});

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      username: json['username'],
      fullName: json['full_name'],
    );
  }
}
