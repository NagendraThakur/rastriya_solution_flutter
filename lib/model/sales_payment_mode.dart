class SalesPaymentMode {
  final int id;
  final String billNo;
  final String payMode;
  final String? ledgerCode;
  final double amount;

  SalesPaymentMode({
    required this.id,
    required this.billNo,
    required this.payMode,
    this.ledgerCode,
    required this.amount,
  });

  factory SalesPaymentMode.fromJson(Map<String, dynamic> json) {
    return SalesPaymentMode(
      id: json['id'],
      billNo: json['bill_no'],
      payMode: json['pay_mode'],
      ledgerCode: json['ledger_code'],
      amount: double.parse(json['amount']),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'bill_no': billNo,
      'pay_mode': payMode,
      'ledger_code': ledgerCode,
      'amount': amount,
    };
  }
}
