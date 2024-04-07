// ignore_for_file: public_member_api_docs, sort_constructors_first
class PaymentModeModel {
  final String? id;
  final String? storeId;
  final String name;
  final bool status;
  final String ledgerCode;
  final String type;
  final String? ledgerName;
  final String? image;
  final String? imagePath;
  final double? amount;
  final String? terminalId;

  PaymentModeModel({
    this.id,
    this.storeId,
    required this.name,
    required this.status,
    required this.ledgerCode,
    required this.type,
    this.ledgerName,
    this.image,
    this.imagePath,
    required this.amount,
    this.terminalId,
  });
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'store_id': storeId,
      'pay_mode': name.toUpperCase(),
      'status': status ? "1" : "0",
      'ledger_code': ledgerCode,
      'type': type.toLowerCase(),
      'ledger_name': ledgerName,
      'image': image,
      'image_path': imagePath,
      'amount': amount,
      'terminal_id': terminalId
    };
  }

  factory PaymentModeModel.fromJson(Map<String, dynamic> json) {
    return PaymentModeModel(
        id: json['id'].toString(),
        storeId: json['store_id'].toString(),
        name: json['name'],
        status: json['status'].toString() == "1" ? true : false,
        ledgerCode: json['ledger_code'],
        type: json['type'].toString().toUpperCase(),
        ledgerName: json['ledger_name'],
        image: json['image'],
        imagePath: json['image_path'],
        amount: null,
        terminalId: json['terminal_id']);
  }

  PaymentModeModel copyWith({
    String? id,
    String? storeId,
    String? name,
    bool? status,
    String? ledgerCode,
    String? type,
    String? ledgerName,
    String? image,
    String? imagePath,
    double? amount,
    String? terminalId,
  }) {
    return PaymentModeModel(
      id: id ?? this.id,
      storeId: storeId ?? this.storeId,
      name: name ?? this.name,
      status: status ?? this.status,
      ledgerCode: ledgerCode ?? this.ledgerCode,
      type: type ?? this.type,
      ledgerName: ledgerName ?? this.ledgerName,
      image: image ?? this.image,
      imagePath: imagePath ?? this.imagePath,
      amount: amount ?? this.amount,
      terminalId: terminalId ?? this.terminalId,
    );
  }
}
