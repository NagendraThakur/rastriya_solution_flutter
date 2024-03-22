import 'dart:developer';

import 'package:rastriya_solution_flutter/model/bill_created_by_model.dart';
import 'package:rastriya_solution_flutter/model/bill_line_model.dart';
import 'package:rastriya_solution_flutter/model/ird_info_model.dart';
import 'package:rastriya_solution_flutter/model/sales_payment_mode.dart';
import 'package:intl/intl.dart';

class BillModel {
  String id;
  String billNo;
  String? refNo;
  String? returnReason;
  String? orderNo;
  DateTime? billDate;
  double? totalQuantity;
  double? netAmount;
  double? billAmount;
  String? tableNo;
  double? discountAmount;
  String? entryTime;
  String? terminalCode;
  String? storeCode;
  String? sequence;
  String? customerCode;
  String? customerName;
  String? customerAddress;
  String? customerPhone;
  String? customerPan;
  String? userId;
  String? customerBillingAddress;
  String? customerBillingCity;
  String? customerBillingStreetName;
  String? customerBillingPhone;
  String? customerShippingAddress;
  String? customerShippingCity;
  String? customerShippingStreetName;
  String? customerShippingPhone;
  String? shipmentDeliveryDate;
  String? shipmentVehicleNo;
  String? shipmentVehicleName;
  String? shipmentVehicleDriverName;
  String? shipmentVehicleDriverNumber;
  String? shipmentVehicleDriverLicenseNo;
  String? exportSales;
  String? taxInvoice;
  String? loyaltyMemberNo;
  String? salesAgentId;
  //new part
  double? taxableAmount;
  double? nonTaxableAmount;
  double? vat;
  double? discountAmountBeforeVat;
  double? grossAmount;
  double? grossAmountBeforeVat;
  double? billAmountBeforeVat;
  String? storeName;
  String? terminalName;
  List<BillLine>? billLines;
  List<SalesPaymentMode>? payments;
  IrdInfo? irdInfo;
  CreatedBy? createdBy;

  BillModel({
    required this.id,
    required this.billNo,
    this.refNo,
    this.returnReason,
    this.orderNo,
    this.billDate,
    this.totalQuantity,
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
    this.storeName,
    this.terminalName,
    this.billLines,
    this.payments,
    this.irdInfo,
    this.createdBy,
  });

  factory BillModel.fromJson(Map<String, dynamic> json) {
    double sumQuantity = 0.0;
    if (json['sales_lines'] != null) {
      sumQuantity = json['sales_lines'].fold(0.0, (acc, line) {
        return acc + (double.parse(line['quantity'].toString()));
      });
    }
    return BillModel(
      id: json['id'].toString(),
      billNo: json['bill_no'],
      refNo: json['ref_no'],
      returnReason: json['return_reason'],
      orderNo: json['order_no'].toString(),
      billDate: json['bill_date'] != null
          ? DateFormat('yyyy-MM-dd').parse(json['bill_date'])
          : null,
      totalQuantity: sumQuantity,
      netAmount: json['net_amount'] != null
          ? double.parse(json['net_amount'].toString())
          : 0,
      billAmount: json['bill_amount'] != null
          ? double.parse(json['bill_amount'].toString())
          : 0,
      tableNo: json['table_no'].toString(),
      discountAmount: json['discount_amount'] != null
          ? double.parse(json['discount_amount'].toString())
          : 0,
      entryTime: json['entry_time'],
      terminalCode: json['terminal_code'].toString(),
      storeCode: json['store_code'].toString(),
      sequence: json['sequence'].toString(),
      customerCode: json['customer_code'].toString(),
      customerName: json['customer_name'],
      customerAddress: json['customer_address'],
      customerPhone: json['customer_phone'],
      customerPan: json['customer_pan'],
      userId: json['user_id'].toString(),
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
      exportSales: json['export_sales'].toString(),
      taxInvoice: json['tax_invoice'].toString(),
      loyaltyMemberNo: json['loyalty_member_no'].toString(),
      salesAgentId: json['sales_agent_id'].toString(),
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
      storeName: json['store_name'],
      terminalName: json['terminal_name'],
      billLines: json['sales_lines'] != null
          ? List<BillLine>.from(
              json['sales_lines'].map((product) => BillLine.fromJson(product)))
          : null,
      payments: json['payments'] != null
          ? List<SalesPaymentMode>.from(json['payments']
              .map((payment) => SalesPaymentMode.fromJson(payment)))
          : null,
      irdInfo:
          json['ird_info'] != null ? IrdInfo.fromJson(json['ird_info']) : null,
      createdBy: json['created_by'] != null
          ? CreatedBy.fromJson(json['created_by'])
          : null,
    );
  }
  Map<String, dynamic> salesReturnToJson({required String returnReason}) {
    try {
      return {
        'ref_no': billNo,
        "return_reason": returnReason,
        'bill_date': billDate.toString(),
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
        'store_name': storeName,
        'terminal_name': terminalName,
        'sales_lines': billLines?.map((line) => line.toJson()).toList(),
        'payments': payments?.map((payment) => payment.toJson()).toList(),
      };
    } catch (error) {
      log(error.toString());
      throw error;
    }
  }

  Map<String, dynamic> salesOrderToJson({required String billStatus}) {
    try {
      return {
        "order_status": billStatus,
        'bill_date': billDate.toString(),
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
        'store_name': storeName,
        'terminal_name': terminalName,
        'sales_lines': billLines?.map((line) => line.toJson()).toList(),
        'payments': payments?.map((payment) => payment.toJson()).toList(),
      };
    } catch (error) {
      log(error.toString());
      throw error;
    }
  }
}
