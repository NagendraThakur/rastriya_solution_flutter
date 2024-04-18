import 'package:intl/intl.dart';
import 'package:rastriya_solution_flutter/model/ledger_model.dart';
import 'package:rastriya_solution_flutter/model/product_model.dart';

class PurchaseModel {
  final String? id;
  final String? billNo;
  final String? refBillNo;
  final DateTime? orderDate;
  final String? vendorBillNo;
  final DateTime? vendorBillDate;
  final String? vendorCode;
  final double? amount;
  final double? vatAmount;
  final double? discountAmount;
  final double? billAmount;
  final String? remarks;
  final int? createdUserId;
  final String? sequence;
  final String? postedDate;
  final int? postedUserId;
  final String? status;
  final String? storeCode;
  final String? vendorName;
  final String? vendorBillingAddress;
  final String? vendorBillingCity;
  final String? vendorBillingPhone;
  final String? vendorBillingStreetName;
  final String? vendorShippingAddress;
  final String? vendorShippingCity;
  final String? vendorShippingPhone;
  final String? vendorShippingStreetName;
  final DateTime? poExpiryDate;
  final String? purchaseOrderType;
  final String? taxInvoice;
  final double? taxableAmount;
  final double? nonTaxableAmount;
  final String? vat;
  final double? billAmountBeforeVat;
  final double? discountAmountBeforeVat;
  final double? grossAmount;
  final double? grossAmountBeforeVat;
  final String? createdAt;
  final String? updatedAt;
  final bool? isReceived;
  final String? storeName;
  final List<PurchaseLine>? lines;
  final LedgerModel? vendorInfo;
  final PostedUserData? postedUserData;
  final CreatedUserData? createdUserData;

  PurchaseModel({
    this.id,
    this.billNo,
    this.refBillNo,
    this.orderDate,
    this.vendorBillNo,
    this.vendorBillDate,
    this.vendorCode,
    this.amount,
    this.vatAmount,
    this.discountAmount,
    this.billAmount,
    this.remarks,
    this.createdUserId,
    this.sequence,
    this.postedDate,
    this.postedUserId,
    this.status,
    this.storeCode,
    this.vendorName,
    this.vendorBillingAddress,
    this.vendorBillingCity,
    this.vendorBillingPhone,
    this.vendorBillingStreetName,
    this.vendorShippingAddress,
    this.vendorShippingCity,
    this.vendorShippingPhone,
    this.vendorShippingStreetName,
    this.poExpiryDate,
    this.purchaseOrderType,
    this.taxInvoice,
    this.taxableAmount,
    this.nonTaxableAmount,
    this.vat,
    this.billAmountBeforeVat,
    this.discountAmountBeforeVat,
    this.grossAmount,
    this.grossAmountBeforeVat,
    this.createdAt,
    this.updatedAt,
    this.isReceived,
    this.storeName,
    this.lines,
    this.vendorInfo,
    this.postedUserData,
    this.createdUserData,
  });

  factory PurchaseModel.fromJson(Map<String, dynamic> json) {
    return PurchaseModel(
      id: json['id'].toString(),
      billNo: json['bill_no'],
      refBillNo: json['ref_bill_no'],
      orderDate: json['order_date'] != null
          ? DateFormat('yyyy-MM-dd').parse(json['order_date'])
          : null,
      vendorBillNo: json['vendor_bill_no'],
      vendorBillDate: json['vendor_bill_date'] != null
          ? DateFormat('yyyy-MM-dd').parse(json['vendor_bill_date'])
          : null,
      vendorCode: json['vendor_code'],
      amount: json['amount'] != null
          ? double.parse(json['amount'].toString())
          : 0.0,
      vatAmount: json['vat_amount'] != null
          ? double.parse(json['vat_amount'].toString())
          : 0.0,
      discountAmount: json['discount_amount'] != null
          ? double.parse(json['discount_amount'].toString())
          : 0.0,
      billAmount: json['bill_amount'] != null
          ? double.parse(json['bill_amount'].toString())
          : 0.0,
      remarks: json['remarks'],
      createdUserId: json['created_user_id'],
      sequence: json['sequence'],
      postedDate: json['posted_date'],
      postedUserId: json['posted_user_id'],
      status: json['status'].toString().toUpperCase(),
      storeCode: json['store_code'],
      vendorName: json['vendor_name'],
      vendorBillingAddress: json['vendor_billing_address'],
      vendorBillingCity: json['vendor_billing_city'],
      vendorBillingPhone: json['vendor_billing_phone'],
      vendorBillingStreetName: json['vendor_billing_street_name'],
      vendorShippingAddress: json['vendor_shipping_address'],
      vendorShippingCity: json['vendor_shipping_city'],
      vendorShippingPhone: json['vendor_shipping_phone'],
      vendorShippingStreetName: json['vendor_shipping_street_name'],
      poExpiryDate: json['PO_expiry_date'] != null
          ? DateFormat('yyyy-MM-dd').parse(json['PO_expiry_date'])
          : null,
      purchaseOrderType: json['purchase_order_type'],
      taxInvoice: json['tax_invoice'],
      taxableAmount: json['taxable_amount'] != null
          ? double.parse(json['taxable_amount'].toString())
          : 0.0,
      nonTaxableAmount: json['non_taxable_amount'] != null
          ? double.parse(json['non_taxable_amount'].toString())
          : 0.0,
      vat: json['vat'],
      billAmountBeforeVat: json['bil_lamount_before_vat'] != null
          ? double.parse(json['bil_lamount_before_vat'].toString())
          : 0.0,
      discountAmountBeforeVat: json['discount_amount_before_vat'] != null
          ? double.parse(json['discount_amount_before_vat'].toString())
          : 0.0,
      grossAmount: json['gross_amount'] != null
          ? double.parse(json['gross_amount'].toString())
          : 0.0,
      grossAmountBeforeVat: json['gross_amount_before_vat'] != null
          ? double.parse(json['gross_amount_before_vat'].toString())
          : 0.0,
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      isReceived: json['is_received'],
      storeName: json['store_name'],
      lines: json['lines'] != null
          ? List<PurchaseLine>.from(
              json['lines'].map((x) => PurchaseLine.fromJson(x)))
          : null,
      vendorInfo: json['vendor_info'] != null
          ? LedgerModel.fromJson(json['vendor_info'])
          : null,
      postedUserData: json['posted_user_data'] != null
          ? PostedUserData.fromJson(json['posted_user_data'])
          : null,
      createdUserData: json['created_user_data'] != null
          ? CreatedUserData.fromJson(json['created_user_data'])
          : null,
    );
  }
}

class PurchaseLine {
  final String? id;
  final String? billNo;
  final String? productCode;
  final String? unitCode;
  final double? quantity;
  final double? rate;
  final double? amount;
  final double? discountPercent;
  final double? discountAmount;
  final double? netAmount;
  final String? sequence;
  final String? productType;
  final double? vatPercent;
  final double? vatAmount;
  final String? batchNo;
  final double? lineNetAmount;
  final double? receivedQuantity;
  final String? createdAt;
  final String? updatedAt;
  final ProductModel? productInfo;
  final String? unitName;
  final String? batchInfo;

  PurchaseLine({
    this.id,
    this.billNo,
    this.productCode,
    this.unitCode,
    this.quantity,
    this.rate,
    this.amount,
    this.discountPercent,
    this.discountAmount,
    this.netAmount,
    this.sequence,
    this.productType,
    this.vatPercent,
    this.vatAmount,
    this.batchNo,
    this.lineNetAmount,
    this.receivedQuantity,
    this.createdAt,
    this.updatedAt,
    this.productInfo,
    this.unitName,
    this.batchInfo,
  });

  factory PurchaseLine.fromJson(Map<String, dynamic> json) {
    return PurchaseLine(
      id: json['id'].toString(),
      billNo: json['bill_no'],
      productCode: json['product_code'],
      unitCode: json['unit_code'],
      quantity: json['quantity'] != null
          ? double.parse(json['quantity'].toString())
          : 0.0,
      rate: json['rate'] != null ? double.parse(json['rate'].toString()) : 0.0,
      amount: json['amount'] != null
          ? double.parse(json['amount'].toString())
          : 0.0,
      discountPercent: json['discount_percent'] != null
          ? double.parse(json['discount_percent'].toString())
          : 0.0,
      discountAmount: json['discount_amount'] != null
          ? double.parse(json['discount_amount'].toString())
          : 0.0,
      netAmount: json['net_amount'] != null
          ? double.parse(json['net_amount'].toString())
          : 0.0,
      sequence: json['sequence'],
      productType: json['product_type'],
      vatPercent: json['vat_percent'] != null
          ? double.parse(json['vat_percent'].toString())
          : 0.0,
      vatAmount: json['vat_amount'] != null
          ? double.parse(json['vat_amount'].toString())
          : 0.0,
      batchNo: json['batch_no'],
      lineNetAmount: json['line_net_amount'] != null
          ? double.parse(json['line_net_amount'].toString())
          : 0.0,
      receivedQuantity: json['received_quantity'] != null
          ? double.parse(json['received_quantity'].toString())
          : 0.0,
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      productInfo: json['product_info'] != null
          ? ProductModel.fromJson(json['product_info'])
          : null,
      unitName: json['unit_name'],
      batchInfo: json['batch_info'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'bill_no': billNo,
      'product_code': productCode,
      'unit_code': unitCode,
      'quantity': quantity,
      'rate': rate,
      'amount': amount,
      'discount_percent': discountPercent,
      'discount_amount': discountAmount,
      'net_amount': netAmount,
      'sequence': sequence,
      'product_type': productType,
      'vat_percent': vatPercent,
      'vat_amount': vatAmount,
      'batch_no': batchNo,
      'line_net_amount': lineNetAmount,
      'received_quantity': receivedQuantity,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'product_info': productInfo != null ? productInfo!.toJson() : null,
      'unit_name': unitName,
      'batch_info': batchInfo,
    };
  }
}

class PostedUserData {
  final String? fullName;
  final String? username;

  PostedUserData({
    this.fullName,
    this.username,
  });

  factory PostedUserData.fromJson(Map<String, dynamic> json) {
    return PostedUserData(
      fullName: json['full_name'],
      username: json['username'],
    );
  }
}

class CreatedUserData {
  final String? fullName;
  final String? username;

  CreatedUserData({
    this.fullName,
    this.username,
  });

  factory CreatedUserData.fromJson(Map<String, dynamic> json) {
    return CreatedUserData(
      fullName: json['full_name'],
      username: json['username'],
    );
  }
}
