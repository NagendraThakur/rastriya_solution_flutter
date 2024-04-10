import 'package:rastriya_solution_flutter/model/ledger_model.dart';
import 'package:rastriya_solution_flutter/model/product_model.dart';

class PurchaseModel {
  final String? id;
  final String? billNo;
  final String? refBillNo;
  final String? orderDate;
  final String? vendorBillNo;
  final String? vendorBillDate;
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
  final String? poExpiryDate;
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
      orderDate: json['order_date'],
      vendorBillNo: json['vendor_bill_no'],
      vendorBillDate: json['vendor_bill_date'],
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
      poExpiryDate: json['PO_expiry_date'],
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
}

// class ProductInfo {
//   final int? id;
//   final String? name;
//   final String? baseUnit;
//   final String? barcode1;
//   final String? barcode2;
//   final String? barcode3;
//   final String? barcode4;
//   final String? productGroup;
//   final String? flatDiscountDateFrom;
//   final String? flatDiscountDateTo;
//   final String? remarks1;
//   final String? remarks2;
//   final int? blocked;
//   final String? vatPercent;
//   final int? discountable;
//   final String? flatDiscount;
//   final String? lastUnitCost;
//   final String? lastUnitPrice;
//   final int? inventoryItem;
//   final int? sellableItem;
//   final int? isPos;
//   final dynamic lastVendorCode;
//   final dynamic brandId;
//   final dynamic modelYearId;
//   final String? mrp;
//   final dynamic otherUnitId;
//   final dynamic otherUnitFactor;
//   final String? profitPercent;
//   final dynamic printName;
//   final String? batchLot;
//   final dynamic productDetail;
//   final String? productCode;
//   final dynamic image;
//   final String? createdAt;
//   final String? updatedAt;

//   ProductInfo({
//     this.id,
//     this.name,
//     this.baseUnit,
//     this.barcode1,
//     this.barcode2,
//     this.barcode3,
//     this.barcode4,
//     this.productGroup,
//     this.flatDiscountDateFrom,
//     this.flatDiscountDateTo,
//     this.remarks1,
//     this.remarks2,
//     this.blocked,
//     this.vatPercent,
//     this.discountable,
//     this.flatDiscount,
//     this.lastUnitCost,
//     this.lastUnitPrice,
//     this.inventoryItem,
//     this.sellableItem,
//     this.isPos,
//     this.lastVendorCode,
//     this.brandId,
//     this.modelYearId,
//     this.mrp,
//     this.otherUnitId,
//     this.otherUnitFactor,
//     this.profitPercent,
//     this.printName,
//     this.batchLot,
//     this.productDetail,
//     this.productCode,
//     this.image,
//     this.createdAt,
//     this.updatedAt,
//   });

//   factory ProductInfo.fromJson(Map<String, dynamic> json) {
//     return ProductInfo(
//       id: json['id'],
//       name: json['name'],
//       baseUnit: json['base_unit'],
//       barcode1: json['barcode1'],
//       barcode2: json['barcode2'],
//       barcode3: json['barcode3'],
//       barcode4: json['barcode4'],
//       productGroup: json['product_group'],
//       flatDiscountDateFrom: json['flat_discount_date_from'],
//       flatDiscountDateTo: json['flat_discount_date_to'],
//       remarks1: json['remarks1'],
//       remarks2: json['remarks2'],
//       blocked: json['blocked'],
//       vatPercent: json['vat_percent'],
//       discountable: json['discountable'],
//       flatDiscount: json['flat_discount'],
//       lastUnitCost: json['last_unit_cost'],
//       lastUnitPrice: json['last_unit_price'],
//       inventoryItem: json['inventory_item'],
//       sellableItem: json['sellable_item'],
//       isPos: json['is_pos'],
//       lastVendorCode: json['last_vendor_code'],
//       brandId: json['brand_id'],
//       modelYearId: json['model_year_id'],
//       mrp: json['mrp'],
//       otherUnitId: json['other_unit_id'],
//       otherUnitFactor: json['other_unit_factor'],
//       profitPercent: json['profit_percent'],
//       printName: json['print_name'],
//       batchLot: json['batch_lot'],
//       productDetail: json['product_detail'],
//       productCode: json['product_code'],
//       image: json['image'],
//       createdAt: json['created_at'],
//       updatedAt: json['updated_at'],
//     );
//   }
// }

// class VendorInfo {
//   final int? id;
//   final String? code;
//   final String? name;
//   final String? ledgerType;
//   final int? bank;
//   final int? cash;
//   final String? panNo;
//   final String? billingAddress1;
//   final String? billingPhone1;
//   final String? billingEmail;
//   final String? contactDescription;
//   final String? contactPersonPhone;
//   final int? trialGroupId;
//   final String? shortName;
//   final String? billingCity1;
//   final String? billingStreetName1;
//   final dynamic logoImage;
//   final String? shippingAddress1;
//   final String? shippingPhone1;
//   final String? shippingCity1;
//   final String? shippingStreetName1;
//   final dynamic creditLimitAmount;
//   final String? createdAt;
//   final String? updatedAt;

//   VendorInfo({
//     this.id,
//     this.code,
//     this.name,
//     this.ledgerType,
//     this.bank,
//     this.cash,
//     this.panNo,
//     this.billingAddress1,
//     this.billingPhone1,
//     this.billingEmail,
//     this.contactDescription,
//     this.contactPersonPhone,
//     this.trialGroupId,
//     this.shortName,
//     this.billingCity1,
//     this.billingStreetName1,
//     this.logoImage,
//     this.shippingAddress1,
//     this.shippingPhone1,
//     this.shippingCity1,
//     this.shippingStreetName1,
//     this.creditLimitAmount,
//     this.createdAt,
//     this.updatedAt,
//   });

//   factory VendorInfo.fromJson(Map<String, dynamic> json) {
//     return VendorInfo(
//       id: json['id'],
//       code: json['code'],
//       name: json['name'],
//       ledgerType: json['ledger_type'],
//       bank: json['bank'],
//       cash: json['cash'],
//       panNo: json['pan_no'],
//       billingAddress1: json['billing_address1'],
//       billingPhone1: json['billing_phone1'],
//       billingEmail: json['billing_email'],
//       contactDescription: json['contact_description'],
//       contactPersonPhone: json['contact_person_phone'],
//       trialGroupId: json['trial_group_id'],
//       shortName: json['short_name'],
//       billingCity1: json['billing_city1'],
//       billingStreetName1: json['billing_street_name1'],
//       logoImage: json['logo_image'],
//       shippingAddress1: json['shipping_address1'],
//       shippingPhone1: json['shipping_phone1'],
//       shippingCity1: json['shipping_city1'],
//       shippingStreetName1: json['shipping_street_name1'],
//       creditLimitAmount: json['credit_limit_amount'],
//       createdAt: json['created_at'],
//       updatedAt: json['updated_at'],
//     );
//   }
// }

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
