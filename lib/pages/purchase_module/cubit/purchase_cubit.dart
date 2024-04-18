import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:rastriya_solution_flutter/constants/config.dart';
import 'package:rastriya_solution_flutter/data/repository/get_repository.dart';
import 'package:rastriya_solution_flutter/data/repository/post_repository.dart';
import 'package:rastriya_solution_flutter/data/repository/put_repository.dart';
import 'package:rastriya_solution_flutter/model/ledger_model.dart';
import 'package:rastriya_solution_flutter/model/product_model.dart';
import 'package:rastriya_solution_flutter/model/purchase_model.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart' as picker;
part 'purchase_state.dart';

class PurchaseCubit extends Cubit<PurchaseState> {
  PurchaseCubit() : super(PurchaseState.initial());

  void message() {
    emit(state.copyWith(message: "message"));
  }

  void calculateTotals() {
    List<PurchaseLine> lines = state.productList;
    double quantity = 0.0;
    double totalAmount = 0.0;
    double totalDiscountAmount = 0.0;
    double totalNetAmount = 0.0;

    for (var line in lines) {
      totalAmount += line.amount ?? 0.0;
      totalDiscountAmount += line.discountAmount ?? 0.0;
      totalNetAmount += line.netAmount ?? 0.0;
      quantity += line.quantity ?? 0.0;
    }
    emit(state.copyWith(
        quantity: quantity,
        totalAmount: totalAmount,
        totalDiscountAmount: totalDiscountAmount,
        totalNetAmount: totalNetAmount));
  }

  Future<void> createPurchaseBill({
    required LedgerModel vendor,
    required String vendorBillNo,
    required picker.NepaliDateTime vendorBillDate,
    required picker.NepaliDateTime poExpiryDate,
    required PurchaseModel purchaseInfo,
  }) async {
    emit(state.copyWith(isLoading: true));
    dynamic body = {
      "ref_bill_no": purchaseInfo.refBillNo,
      "vendor_bill_no": vendorBillNo,
      "vendor_bill_date":
          "${vendorBillDate.toDateTime().year}-${vendorBillDate.toDateTime().month}-${vendorBillDate.toDateTime().day}",
      "vendor_code": vendor.code,
      "amount": state.totalAmount,
      "taxable_amount": 0,
      "non_taxable_amount": 0,
      "vat": 150.00,
      "discount_amount_before_vat": 50.00,
      "gross_amount": state.totalAmount,
      "gross_amount_before_vat": 0,
      "bill_amount_before_vat": 0,
      "tax_invoice": null,
      "vat_amount": 0.0,
      "discount_amount": state.totalDiscountAmount,
      "bill_amount": state.totalNetAmount,
      "remarks": "",
      "vendor_name": vendor.name,
      "vendor_billing_address": vendor.billingAddress1,
      "vendor_billing_city": vendor.billingCity1,
      "vendor_billing_phone": vendor.billingPhone1,
      "vendor_billing_street_name": vendor.billingStreetName1,
      "vendor_shipping_address": vendor.shippingAddress1,
      "vendor_shipping_city": vendor.shippingCity1,
      "vendor_shipping_phone": vendor.shippingPhone1,
      "vendor_shipping_street_name": vendor.shippingStreetName1,
      "PO_expiry_date":
          "${poExpiryDate.toDateTime().year}-${poExpiryDate.toDateTime().month}-${poExpiryDate.toDateTime().day}",
      "purchase_order_type": "standard",
      "lines": state.productList
          .map((PurchaseLine product) => product.toJson())
          .toList(),
      "invoice_type": "receive_and_invoice"
    };
    dynamic response = await PostRepository()
        .postRequest(path: PostRepository.purchaseBill, body: body);
    emit(state.copyWith(isLoading: false));
    if (response["status"] == "success") {
      state.copyWith(message: response["message"]);
      emit(state.copyWith(isLoading: false));
    } else {
      state.copyWith(message: "Failed: Something went wrong");
    }
  }

  Future<void> createPurchaseOrder({
    required LedgerModel vendor,
    required String vendorBillNo,
    required picker.NepaliDateTime vendorBillDate,
    required picker.NepaliDateTime poExpiryDate,
    required PurchaseModel? purchaseInfo,
  }) async {
    emit(state.copyWith(isLoading: true));
    dynamic body = {
      "vendor_bill_no": vendorBillNo,
      "vendor_bill_date":
          "${vendorBillDate.toDateTime().year}-${vendorBillDate.toDateTime().month}-${vendorBillDate.toDateTime().day}",
      "vendor_code": vendor.code,
      "amount": state.totalAmount,
      "taxable_amount": 0,
      "non_taxable_amount": 0,
      "vat": 150.00,
      "discount_amount_before_vat": 50.00,
      "gross_amount": state.totalAmount,
      "gross_amount_before_vat": 0,
      "bill_amount_before_vat": 0,
      "tax_invoice": null,
      "vat_amount": 0.0,
      "discount_amount": state.totalDiscountAmount,
      "bill_amount": state.totalNetAmount,
      "remarks": "",
      "vendor_name": vendor.name,
      "vendor_billing_address": vendor.billingAddress1,
      "vendor_billing_city": vendor.billingCity1,
      "vendor_billing_phone": vendor.billingPhone1,
      "vendor_billing_street_name": vendor.billingStreetName1,
      "vendor_shipping_address": vendor.shippingAddress1,
      "vendor_shipping_city": vendor.shippingCity1,
      "vendor_shipping_phone": vendor.shippingPhone1,
      "vendor_shipping_street_name": vendor.shippingStreetName1,
      "PO_expiry_date":
          "${poExpiryDate.toDateTime().year}-${poExpiryDate.toDateTime().month}-${poExpiryDate.toDateTime().day}",
      "purchase_order_type": "standard",
      "lines": state.productList
          .map((PurchaseLine product) => product.toJson())
          .toList()
    };
    dynamic response;
    if (purchaseInfo == null) {
      response = await PostRepository()
          .postRequest(path: PostRepository.purchaseOrder, body: body);
    } else {
      response = await PutRepository().putRequest(
          path: PostRepository.purchaseOrder,
          editId: purchaseInfo.id,
          body: body);
    }
    emit(state.copyWith(isLoading: false));
    if (response["status"] == "success") {
      emit(state.copyWith(isLoading: false));
      state.copyWith(message: response["message"]);
    } else {
      state.copyWith(message: "Failed: Something went wrong");
    }
  }

  assignProductToPurchaseLine({required ProductModel product}) {
    double quantityValue = product.quantity!;
    double lastUnitCostValue = product.lastUnitCost!;
    double amount = quantityValue * lastUnitCostValue;
    double discountValue = product.discountAmount!;

    double netAmount = amount - discountValue;

    PurchaseLine purchaseLine = PurchaseLine(
      productCode: product.productCode,
      unitCode: product.baseUnit,
      quantity: product.quantity,
      rate: product.lastUnitCost,
      discountPercent: product.discountPercentage,
      discountAmount: product.discountAmount,
      amount: amount,
      netAmount: netAmount,
      productType: "product",
      vatPercent: product.vatPercent,
      vatAmount: (netAmount * (product.vatPercent ?? 0)) / 100,
      batchNo: product.batch?.id,
      lineNetAmount: netAmount,
      productInfo: product,
    );
    List<PurchaseLine> productList = state.productList;
    productList.add(purchaseLine);
    emit(state.copyWith(productList: productList));
    calculateTotals();
  }

  assignPurchaseLine({required List<PurchaseLine>? line}) {
    emit(state.copyWith(productList: line));
    calculateTotals();
  }

  Future<void> fetchProduct() async {
    emit(state.copyWith(isFetching: true));

    try {
      final response = await GetRepository().getRequest(
          path: GetRepository.product,
          additionalHeader: {"company-id": Config.companyInfo!.id});
      emit(state.copyWith(isFetching: false));
      if (response["status"] == "success") {
        List<dynamic> data = response["data"];
        emit(state.copyWith(
          searchProductList:
              data.map((json) => ProductModel.fromJson(json)).toList(),
        ));
      } else {
        emit(state.copyWith(message: 'Failed to fetch data'));
      }
    } catch (e) {
      emit(state.copyWith(message: 'Failed: $e'));
    }
  }

  Future<void> fetchLedger() async {
    dynamic response = await GetRepository().getRequest(
        path: GetRepository.ledger,
        additionalHeader: {"company-id": Config.companyInfo!.id},
        queryParameters: {"type": "v"});
    if (response["status"] == "success") {
      List? data = response["data"];
      if (data != null && data.isNotEmpty) {
        List<LedgerModel> ledgerList =
            data.map((ledger) => LedgerModel.fromJson(ledger)).toList();
        emit(state.copyWith(venderList: ledgerList));
      }
    }
  }

  Future<void> fetchPurchaseOrder() async {
    emit(state.copyWith(
      isFetching: true,
    ));
    final response = await GetRepository().getRequest(
      path: GetRepository.purchaseBill,
      additionalHeader: {"company-id": Config.companyInfo!.id},
    );
    emit(state.copyWith(
      isFetching: false,
    ));
    if (response["status"] == "success") {
      double totalBillsAmount = 0.0;
      double totalDiscountAmount = 0.0;
      List<dynamic> data = response["data"];
      List<PurchaseModel> purchaseList = data.map((json) {
        PurchaseModel purchase = PurchaseModel.fromJson(json);
        totalBillsAmount += purchase.billAmount!;
        totalDiscountAmount += purchase.discountAmount!;
        return purchase;
      }).toList();

      emit(state.copyWith(
        purchaseList: purchaseList,
        filteredPurchaseList: purchaseList,
      ));
    } else {
      emit(state.copyWith(
        message: 'Failed to fetch Purchase Order',
      ));
    }
  }
}
