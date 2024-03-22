import 'package:rastriya_solution_flutter/model/product_model.dart';

class BillLine {
  String id;
  String? productName;
  int? fired;
  String? billNo;
  String? productCode;
  String? unit;
  double? quantity;
  double? rate;
  double? amount;
  double? discountPercentage;
  double? discountAmount;
  double? netAmount;
  String? sequence;
  String? discountPercent;
  double? rateBeforeVat;
  double? amountBeforeVat;
  String? discountAmountBeforeVat;
  double? vatRate;
  String? netAmountBeforeVat;
  String? vatAmount;
  String? loyaltyMemberId;
  String? batchNo;
  String? terminalCode;
  String? storeCode;
  String? salesAgentId;
  String? unitName;
  String? printStationId;
  ProductModel? product;

  BillLine({
    required this.id,
    this.productName,
    this.fired,
    this.billNo,
    this.productCode,
    this.unit,
    this.quantity,
    this.rate,
    this.amount,
    this.discountPercentage,
    this.discountAmount,
    this.netAmount,
    this.sequence,
    this.discountPercent,
    this.rateBeforeVat,
    this.amountBeforeVat,
    this.discountAmountBeforeVat,
    this.vatRate,
    this.netAmountBeforeVat,
    this.vatAmount,
    this.loyaltyMemberId,
    this.batchNo,
    this.terminalCode,
    this.storeCode,
    this.salesAgentId,
    this.unitName,
    this.printStationId,
    this.product,
  });

  factory BillLine.fromJson(Map<String, dynamic> json) {
    return BillLine(
      id: json['id'].toString(),
      productName: json['product_name'],
      fired: json['fired'] != null ? int.parse(json['fired'].toString()) : 0,
      billNo: json['bill_no'],
      productCode: json['product_code'],
      unit: json['unit'],
      quantity: json['quantity'] != null
          ? double.parse(json['quantity'].toString())
          : 0,
      rate: json['rate'] != null ? double.parse(json['rate'].toString()) : 0,
      amount:
          json['amount'] != null ? double.parse(json['amount'].toString()) : 0,
      discountPercentage: json['discount_percentage'] != null
          ? double.parse(json['discount_percentage'].toString())
          : 0,
      discountAmount: json['discount_amount'] != null
          ? double.parse(json['discount_amount'].toString())
          : 0,
      netAmount: json['net_amount'] != null
          ? double.parse(json['net_amount'].toString())
          : 0,
      sequence: json['sequence'].toString(),
      discountPercent: json['discount_percent'],
      rateBeforeVat: json['rate_before_vat'] != null
          ? double.parse(json['rate_before_vat'].toString())
          : 0,
      amountBeforeVat: json['amount_before_vat'] != null
          ? double.parse(json['amount_before_vat'].toString())
          : 0,
      discountAmountBeforeVat: json['discount_amount_before_vat'],
      vatRate: json['vat_rate'] != null
          ? (double.parse(json['vat_rate'].toString()))
          : 0,
      netAmountBeforeVat: json['net_amount_before_vat'],
      vatAmount: json['vat_amount'],
      loyaltyMemberId: json['loyalty_member_id']?.toString(),
      batchNo: json['batch_no'],
      terminalCode: json['terminal_code'],
      storeCode: json['store_code'],
      salesAgentId: json['sales_agent_id'],
      unitName: json['unit_name'],
      printStationId: json['print_station_id'].toString(),
      product: json['product_info'] != null
          ? ProductModel.fromJson(json['product_info'])
          : null,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_name': productName,
      'fired': fired,
      'bill_no': billNo,
      'product_code': productCode,
      'unit': unit,
      'quantity': quantity,
      'rate': rate,
      'amount': amount,
      'discount_percentage': discountPercentage,
      'discount_amount': discountAmount,
      'net_amount': netAmount,
      'sequence': sequence,
      'discount_percent': discountPercent,
      'rate_before_vat': rateBeforeVat,
      'amount_before_vat': amountBeforeVat,
      'discount_amount_before_vat': discountAmountBeforeVat,
      'vat_rate': vatRate,
      'net_amount_before_vat': netAmountBeforeVat,
      'vat_amount': vatAmount,
      'loyalty_member_id': loyaltyMemberId,
      'batch_no': batchNo,
      'terminal_code': terminalCode,
      'store_code': storeCode,
      'sales_agent_id': salesAgentId,
      'unit_name': unitName,
      'print_station_id': printStationId,
    };
  }
}
