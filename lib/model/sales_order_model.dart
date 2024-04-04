// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:rastriya_solution_flutter/model/print_station_model.dart';
import 'package:rastriya_solution_flutter/model/product_model.dart';

class OrderBillModel {
  String? id;
  String? billNo;
  String? orderNo;
  String? billDate;
  double? netAmount;
  double? billAmount;
  String? tableNo;
  double? discountAmount;
  String? entryTime;
  String? terminalCode;
  String? storeCode;
  int? sequence;
  dynamic customerCode;
  dynamic customerName;
  dynamic customerAddress;
  dynamic customerPhone;
  dynamic customerPan;
  int? userId;
  dynamic customerBillingAddress;
  dynamic customerBillingCity;
  dynamic customerBillingStreetName;
  dynamic customerBillingPhone;
  dynamic customerShippingAddress;
  dynamic customerShippingCity;
  dynamic customerShippingStreetName;
  dynamic customerShippingPhone;
  dynamic shipmentDeliveryDate;
  dynamic shipmentVehicleNo;
  dynamic shipmentVehicleName;
  dynamic shipmentVehicleDriverName;
  dynamic shipmentVehicleDriverNumber;
  dynamic shipmentVehicleDriverLicenseNo;
  int? exportSales;
  int? taxInvoice;
  String? loyaltyMemberNo;
  dynamic salesAgentId;
  double? taxableAmount;
  double? nonTaxableAmount;
  double? vat;
  double? discountAmountBeforeVat;
  double? grossAmount;
  double? grossAmountBeforeVat;
  double? billAmountBeforeVat;
  String? noOfGuests;
  String? storeName;
  String? terminalName;
  List<OrderBillLineModel> orderBillLine;
  UserInfo? userInfo;

  OrderBillModel({
    this.id,
    this.billNo,
    this.orderNo,
    this.billDate,
    this.netAmount,
    this.billAmount,
    this.tableNo,
    this.discountAmount,
    this.entryTime,
    this.terminalCode,
    this.storeCode,
    this.sequence,
    this.customerCode,
    this.customerName,
    this.customerAddress,
    this.customerPhone,
    this.customerPan,
    this.userId,
    this.customerBillingAddress,
    this.customerBillingCity,
    this.customerBillingStreetName,
    this.customerBillingPhone,
    this.customerShippingAddress,
    this.customerShippingCity,
    this.customerShippingStreetName,
    this.customerShippingPhone,
    this.shipmentDeliveryDate,
    this.shipmentVehicleNo,
    this.shipmentVehicleName,
    this.shipmentVehicleDriverName,
    this.shipmentVehicleDriverNumber,
    this.shipmentVehicleDriverLicenseNo,
    this.exportSales,
    this.taxInvoice,
    this.loyaltyMemberNo,
    this.salesAgentId,
    this.taxableAmount,
    this.nonTaxableAmount,
    this.vat,
    this.discountAmountBeforeVat,
    this.grossAmount,
    this.grossAmountBeforeVat,
    this.billAmountBeforeVat,
    this.noOfGuests,
    this.storeName,
    this.terminalName,
    required this.orderBillLine,
    this.userInfo,
  });

  factory OrderBillModel.fromJson(Map<String, dynamic> json) => OrderBillModel(
        id: json['id'].toString(),
        billNo: json['bill_no'],
        orderNo: json['order_no'],
        billDate: json['bill_date'],
        netAmount: json['net_amount'] != null
            ? double.tryParse(json['net_amount'].toString()) ?? 0
            : 0,
        billAmount: json['bill_amount'] != null
            ? double.tryParse(json['bill_amount'].toString()) ?? 0
            : 0,
        tableNo: json['table_no'],
        discountAmount: json['discount_amount'] != null
            ? double.tryParse(json['discount_amount'].toString()) ?? 0
            : 0,
        entryTime: json['entry_time'],
        terminalCode: json['terminal_code'],
        storeCode: json['store_code'],
        sequence: json['sequence'],
        customerCode: json['customer_code'],
        customerName: json['customer_name'],
        customerAddress: json['customer_address'],
        customerPhone: json['customer_phone'],
        customerPan: json['customer_pan'],
        userId: json['user_id'],
        customerBillingAddress: json['customer_billing_address'],
        customerBillingCity: json['customer_billing_city'],
        customerBillingStreetName: json['customer_billing_street_name'],
        customerBillingPhone: json['customer_billing_phone'],
        customerShippingAddress: json['customer_shipping_address'],
        customerShippingCity: json['customer_shipping_city'],
        customerShippingStreetName: json['customer_shipping_street_name'],
        customerShippingPhone: json['customer_shipping_phone'],
        shipmentDeliveryDate: json['shipment_delivery_date'],
        shipmentVehicleNo: json['shipment_vehicle_no'],
        shipmentVehicleName: json['shipment_vehicle_name'],
        shipmentVehicleDriverName: json['shipment_vehicle_driver_name'],
        shipmentVehicleDriverNumber: json['shipment_vehicle_driver_number'],
        shipmentVehicleDriverLicenseNo:
            json['shipment_vehicle_driver_license_no'],
        exportSales: json['export_sales'],
        taxInvoice: json['tax_invoice'],
        loyaltyMemberNo: json['loyalty_member_no'],
        salesAgentId: json['sales_agent_id'],
        taxableAmount: json['taxable_amount'] != null
            ? double.parse(json['taxable_amount'].toString())
            : 0,
        nonTaxableAmount: json['non_taxable_amount'] != null
            ? double.parse(json['non_taxable_amount'].toString())
            : 0,
        vat: json['vat'] != null ? double.parse(json['vat'].toString()) : 0,
        discountAmountBeforeVat: json['discount_amount_before_vat'] != null
            ? double.parse(json['discount_amount_before_vat'].toString())
            : 0,
        grossAmount: json['gross_amount'] != null
            ? double.parse(json['gross_amount'].toString())
            : 0,
        grossAmountBeforeVat: json['gross_amount_before_vat'] != null
            ? double.parse(json['gross_amount_before_vat'].toString())
            : 0,
        billAmountBeforeVat: json['bill_amount_before_vat'] != null
            ? double.parse(json['bill_amount_before_vat'].toString())
            : 0,
        noOfGuests: json['no_of_guests'],
        storeName: json['store_name'],
        terminalName: json['terminal_name'],
        orderBillLine: List<OrderBillLineModel>.from(
            json['sales_lines'].map((x) => OrderBillLineModel.fromJson(x))),
        userInfo: UserInfo.fromJson(json['user_info']),
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'order_status': 'open',
      'bill_no': billNo,
      'order_no': orderNo,
      'bill_date': billDate,
      'net_amount': netAmount,
      'bill_amount': billAmount,
      'table_no': tableNo,
      'discount_amount': discountAmount,
      'entry_time': entryTime,
      'terminal_code': terminalCode,
      'store_code': storeCode,
      'sequence': sequence,
      'customer_code': customerCode,
      'customer_name': customerName,
      'customer_address': customerAddress,
      'customer_phone': customerPhone,
      'customer_pan': customerPan,
      'user_id': userId,
      'customer_billing_address': customerBillingAddress,
      'customer_billing_city': customerBillingCity,
      'customer_billing_street_name': customerBillingStreetName,
      'customer_billing_phone': customerBillingPhone,
      'customer_shipping_address': customerShippingAddress,
      'customer_shipping_city': customerShippingCity,
      'customer_shipping_street_name': customerShippingStreetName,
      'customer_shipping_phone': customerShippingPhone,
      'shipment_delivery_date': shipmentDeliveryDate,
      'shipment_vehicle_no': shipmentVehicleNo,
      'shipment_vehicle_name': shipmentVehicleName,
      'shipment_vehicle_driver_name': shipmentVehicleDriverName,
      'shipment_vehicle_driver_number': shipmentVehicleDriverNumber,
      'shipment_vehicle_driver_license_no': shipmentVehicleDriverLicenseNo,
      'export_sales': exportSales,
      'tax_invoice': taxInvoice,
      'loyalty_member_no': loyaltyMemberNo,
      'sales_agent_id': salesAgentId,
      'taxable_amount': taxableAmount,
      'non_taxable_amount': nonTaxableAmount,
      'vat': vat,
      'discount_amount_before_vat': discountAmountBeforeVat,
      'gross_amount': grossAmount,
      'gross_amount_before_vat': grossAmountBeforeVat,
      'bill_amount_before_vat': billAmountBeforeVat,
      'no_of_guests': noOfGuests,
      'store_name': storeName,
      'terminal_name': terminalName,
      'sales_lines': orderBillLine.map((line) => line.toJson()).toList(),
      'user_info': userInfo != null ? userInfo!.toJson() : null,
    };
  }

  OrderBillModel copyWith({
    String? id,
    String? billNo,
    String? orderNo,
    String? billDate,
    double? netAmount,
    double? billAmount,
    String? tableNo,
    double? discountAmount,
    String? entryTime,
    String? terminalCode,
    String? storeCode,
    int? sequence,
    dynamic customerCode,
    dynamic customerName,
    dynamic customerAddress,
    dynamic customerPhone,
    dynamic customerPan,
    int? userId,
    dynamic customerBillingAddress,
    dynamic customerBillingCity,
    dynamic customerBillingStreetName,
    dynamic customerBillingPhone,
    dynamic customerShippingAddress,
    dynamic customerShippingCity,
    dynamic customerShippingStreetName,
    dynamic customerShippingPhone,
    dynamic shipmentDeliveryDate,
    dynamic shipmentVehicleNo,
    dynamic shipmentVehicleName,
    dynamic shipmentVehicleDriverName,
    dynamic shipmentVehicleDriverNumber,
    dynamic shipmentVehicleDriverLicenseNo,
    int? exportSales,
    int? taxInvoice,
    String? loyaltyMemberNo,
    dynamic salesAgentId,
    double? taxableAmount,
    double? nonTaxableAmount,
    double? vat,
    double? discountAmountBeforeVat,
    double? grossAmount,
    double? grossAmountBeforeVat,
    double? billAmountBeforeVat,
    String? noOfGuests,
    String? storeName,
    String? terminalName,
    List<OrderBillLineModel>? orderBillLine,
    UserInfo? userInfo,
  }) {
    return OrderBillModel(
      id: id ?? this.id,
      billNo: billNo ?? this.billNo,
      orderNo: orderNo ?? this.orderNo,
      billDate: billDate ?? this.billDate,
      netAmount: netAmount ?? this.netAmount,
      billAmount: billAmount ?? this.billAmount,
      tableNo: tableNo ?? this.tableNo,
      discountAmount: discountAmount ?? this.discountAmount,
      entryTime: entryTime ?? this.entryTime,
      terminalCode: terminalCode ?? this.terminalCode,
      storeCode: storeCode ?? this.storeCode,
      sequence: sequence ?? this.sequence,
      customerCode: customerCode ?? this.customerCode,
      customerName: customerName ?? this.customerName,
      customerAddress: customerAddress ?? this.customerAddress,
      customerPhone: customerPhone ?? this.customerPhone,
      customerPan: customerPan ?? this.customerPan,
      userId: userId ?? this.userId,
      customerBillingAddress:
          customerBillingAddress ?? this.customerBillingAddress,
      customerBillingCity: customerBillingCity ?? this.customerBillingCity,
      customerBillingStreetName:
          customerBillingStreetName ?? this.customerBillingStreetName,
      customerBillingPhone: customerBillingPhone ?? this.customerBillingPhone,
      customerShippingAddress:
          customerShippingAddress ?? this.customerShippingAddress,
      customerShippingCity: customerShippingCity ?? this.customerShippingCity,
      customerShippingStreetName:
          customerShippingStreetName ?? this.customerShippingStreetName,
      customerShippingPhone:
          customerShippingPhone ?? this.customerShippingPhone,
      shipmentDeliveryDate: shipmentDeliveryDate ?? this.shipmentDeliveryDate,
      shipmentVehicleNo: shipmentVehicleNo ?? this.shipmentVehicleNo,
      shipmentVehicleName: shipmentVehicleName ?? this.shipmentVehicleName,
      shipmentVehicleDriverName:
          shipmentVehicleDriverName ?? this.shipmentVehicleDriverName,
      shipmentVehicleDriverNumber:
          shipmentVehicleDriverNumber ?? this.shipmentVehicleDriverNumber,
      shipmentVehicleDriverLicenseNo:
          shipmentVehicleDriverLicenseNo ?? this.shipmentVehicleDriverLicenseNo,
      exportSales: exportSales ?? this.exportSales,
      taxInvoice: taxInvoice ?? this.taxInvoice,
      loyaltyMemberNo: loyaltyMemberNo ?? this.loyaltyMemberNo,
      salesAgentId: salesAgentId ?? this.salesAgentId,
      taxableAmount: taxableAmount ?? this.taxableAmount,
      nonTaxableAmount: nonTaxableAmount ?? this.nonTaxableAmount,
      vat: vat ?? this.vat,
      discountAmountBeforeVat:
          discountAmountBeforeVat ?? this.discountAmountBeforeVat,
      grossAmount: grossAmount ?? this.grossAmount,
      grossAmountBeforeVat: grossAmountBeforeVat ?? this.grossAmountBeforeVat,
      billAmountBeforeVat: billAmountBeforeVat ?? this.billAmountBeforeVat,
      noOfGuests: noOfGuests ?? this.noOfGuests,
      storeName: storeName ?? this.storeName,
      terminalName: terminalName ?? this.terminalName,
      orderBillLine: orderBillLine ?? this.orderBillLine,
      userInfo: userInfo ?? this.userInfo,
    );
  }
}

class OrderBillLineModel {
  int? id;
  String? billNo;
  String? productCode;
  String? unit;
  double? quantity;
  double? rate;
  double? amount;
  // from here
  int? fired;
  int? printStationId;
  int? isCanceled;
  //till here
  double? discountPercentage;
  double? discountAmount;
  double? netAmount;
  int? sequence;
  double? discountPercent;
  double? rateBeforeVat;
  double? amountBeforeVat;
  double? discountAmountBeforeVat;
  double? vatRate;
  double? netAmountBeforeVat;
  double? vatAmount;
  int? loyaltyMemberId;
  String? terminalCode;
  String? storeCode;
  String? salesAgentId;
  String? review;

  ProductModel? productInfo;
  PrintStationModel? printStationInfo;
  bool? selected;

  OrderBillLineModel({
    this.id,
    this.billNo,
    this.productCode,
    this.unit,
    this.quantity,
    this.rate,
    this.amount,
    this.fired,
    this.printStationId,
    this.isCanceled,
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
    this.terminalCode,
    this.storeCode,
    this.salesAgentId,
    this.review,
    this.productInfo,
    this.printStationInfo,
    this.selected = true,
  });

  factory OrderBillLineModel.fromJson(Map<String, dynamic> json) =>
      OrderBillLineModel(
          id: json['id'],
          billNo: json['bill_no'],
          productCode: json['product_code'],
          unit: json['unit'],
          quantity: json['quantity'] != null
              ? double.tryParse(json['quantity'].toString()) ?? 0
              : 0,
          rate: json['rate'] != null
              ? double.tryParse(json['rate'].toString()) ?? 0
              : 0,
          fired: json['fired'],
          printStationId: json['print_station_id'],
          isCanceled: json['is_canceled'],
          sequence: json['sequence'],
          amount: json['amount'] != null
              ? double.tryParse(json['amount'].toString()) ?? 0
              : 0,
          discountPercentage: json['discount_percentage'] != null
              ? double.tryParse(json['discount_percentage'].toString()) ?? 0
              : 0,
          discountAmount: json['discount_amount'] != null
              ? double.tryParse(json['discount_amount'].toString()) ?? 0
              : 0,
          netAmount: json['net_amount'] != null
              ? double.tryParse(json['net_amount'].toString()) ?? 0
              : 0,
          rateBeforeVat: json['rate_before_vat'] != null
              ? double.tryParse(json['rate_before_vat'].toString()) ?? 0
              : 0,
          amountBeforeVat: json['amount_before_vat'] != null
              ? double.tryParse(json['amount_before_vat'].toString()) ?? 0
              : 0,
          discountAmountBeforeVat: json['discount_amount_before_vat'] != null
              ? double.tryParse(
                      json['discount_amount_before_vat'].toString()) ??
                  0
              : 0,
          vatRate: json['vat_rate'] != null
              ? double.tryParse(json['vat_rate'].toString()) ?? 0
              : 0,
          netAmountBeforeVat:
              json['net_amount_before_vat'] != null
                  ? double.tryParse(json['net_amount_before_vat'].toString()) ??
                      0
                  : 0,
          vatAmount: json['vat_amount'] != null
              ? double.tryParse(json['vat_amount'].toString()) ?? 0
              : 0,
          loyaltyMemberId: json['loyalty_member_id'],
          terminalCode: json['terminal_code'],
          storeCode: json['store_code'],
          salesAgentId: json['sales_agent_id'].toString(),
          review: json['review'],
          productInfo: ProductModel.fromJson(json['product_info']),
          printStationInfo:
              PrintStationModel.fromJson(json['print_station_info']));

  Map<String, dynamic> toJson() => {
        'id': id,
        'bill_no': billNo,
        'product_code': productCode,
        'unit': unit,
        'quantity': quantity,
        'rate': rate,
        'amount': amount,
        'fired': fired,
        'print_station_id': printStationId,
        'is_canceled': isCanceled,
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
        'terminal_code': terminalCode,
        'store_code': storeCode,
        'sales_agent_id': salesAgentId,
        'review': review,
        'product_info': productInfo!.toJson()
      };

  OrderBillLineModel copyWith({
    int? id,
    String? billNo,
    String? productCode,
    String? unit,
    double? quantity,
    double? rate,
    double? amount,
    int? fired,
    int? printStationId,
    int? isCanceled,
    double? discountPercentage,
    double? discountAmount,
    double? netAmount,
    int? sequence,
    double? discountPercent,
    double? rateBeforeVat,
    double? amountBeforeVat,
    double? discountAmountBeforeVat,
    double? vatRate,
    double? netAmountBeforeVat,
    double? vatAmount,
    int? loyaltyMemberId,
    String? terminalCode,
    String? storeCode,
    String? salesAgentId,
    String? review,
    ProductModel? productInfo,
    PrintStationModel? printStationInfo,
    bool? selected,
  }) {
    return OrderBillLineModel(
      id: id ?? this.id,
      billNo: billNo ?? this.billNo,
      productCode: productCode ?? this.productCode,
      unit: unit ?? this.unit,
      quantity: quantity ?? this.quantity,
      rate: rate ?? this.rate,
      amount: amount ?? this.amount,
      fired: fired ?? this.fired,
      printStationId: printStationId ?? this.printStationId,
      isCanceled: isCanceled ?? this.isCanceled,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      discountAmount: discountAmount ?? this.discountAmount,
      netAmount: netAmount ?? this.netAmount,
      sequence: sequence ?? this.sequence,
      discountPercent: discountPercent ?? this.discountPercent,
      rateBeforeVat: rateBeforeVat ?? this.rateBeforeVat,
      amountBeforeVat: amountBeforeVat ?? this.amountBeforeVat,
      discountAmountBeforeVat:
          discountAmountBeforeVat ?? this.discountAmountBeforeVat,
      vatRate: vatRate ?? this.vatRate,
      netAmountBeforeVat: netAmountBeforeVat ?? this.netAmountBeforeVat,
      vatAmount: vatAmount ?? this.vatAmount,
      loyaltyMemberId: loyaltyMemberId ?? this.loyaltyMemberId,
      terminalCode: terminalCode ?? this.terminalCode,
      storeCode: storeCode ?? this.storeCode,
      salesAgentId: salesAgentId ?? this.salesAgentId,
      review: review ?? this.review,
      productInfo: productInfo ?? this.productInfo,
      printStationInfo: printStationInfo ?? this.printStationInfo,
      selected: selected ?? this.selected,
    );
  }
}

class UserInfo {
  String? username;
  String? fullName;

  UserInfo({
    this.username,
    this.fullName,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        username: json['username'],
        fullName: json['full_name'],
      );

  Map<String, dynamic> toJson() => {
        'username': username,
        'full_name': fullName,
      };
}
