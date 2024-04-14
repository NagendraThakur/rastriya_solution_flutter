import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:rastriya_solution_flutter/constants/config.dart';
import 'package:rastriya_solution_flutter/data/repository/get_repository.dart';
import 'package:rastriya_solution_flutter/data/repository/post_repository.dart';
import 'package:rastriya_solution_flutter/data/repository/put_repository.dart';
import 'package:rastriya_solution_flutter/model/bill_model.dart';
import 'package:rastriya_solution_flutter/model/ledger_model.dart';
import 'package:rastriya_solution_flutter/model/loyalty_member_discount_model.dart';
import 'package:rastriya_solution_flutter/model/loyalty_member_model.dart';
import 'package:rastriya_solution_flutter/model/payment_mode_model.dart';
import 'package:rastriya_solution_flutter/model/product_model.dart';
import 'package:rastriya_solution_flutter/model/sales_order_model.dart';
import 'package:rastriya_solution_flutter/model/section_model.dart';
import 'package:rastriya_solution_flutter/model/table_model.dart';
import 'package:rastriya_solution_flutter/model/void_reason_model.dart';

part 'pos_state.dart';

class PosCubit extends Cubit<PosState> {
  PosCubit() : super(PosState.initial()) {
    fetchPaymentMode();
  }

  void createSalesBill() async {
    emit(state.copyWith(isLoading: true));
    dynamic body = {
      "bill_date":
          "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}",
      "order_no": state.salesOrderBill?.billNo,
      "net_amount": state.totalAmount,
      "bill_amount": state.totalAmount,
      "no_of_guests": state.noOfGuest,
      "table_no": state.selectedTable != null ? state.selectedTable!.id : 0,
      "is_request_f_and_b": state.selectedTable != null ? 1 : 0,
      "discount_amount": state.discountAmount,
      "customer_code": state.customer?.code,
      "customer_name": state.customer?.name,
      "customer_address": state.customer?.billingAddress1,
      "customer_phone": state.customer?.billingPhone1,
      "customer_pan": state.customer?.panNo,
      "customer_billing_address": state.customer?.billingAddress1,
      "customer_billing_city": state.customer?.billingCity1,
      "customer_billing_street_name": state.customer?.billingStreetName1,
      "customer_billing_phone": state.customer?.billingPhone1,
      "customer_shipping_address": state.customer?.shippingAddress1,
      "customer_shipping_city": state.customer?.shippingCity1,
      "customer_shipping_street_name": state.customer?.shippingStreetName1,
      "customer_shipping_phone": state.customer?.shippingPhone1,
      "shipment_delivery_date": null,
      "shipment_vehicle_no": null,
      "shipment_vehicle_name": null,
      "shipment_vehicle_driver_name": null,
      "shipment_vehicle_driver_number": null,
      "shipment_vehicle_driver_license_no": null,
      "export_sales": state.exportSales == true ? 1 : 0,
      "tax_invoice": state.totalAmount > 10000
          ? 1
          : state.taxInvoice == true
              ? 1
              : 0,
      "loyalty_member_no": state.loyaltyMember?.memberCode,
      "sales_agent_id": null,
      "payments": state.paidPaymentModeList
          ?.map((PaymentModeModel paymentMode) => paymentMode.toJson())
          .toList(),
      "sales_lines": state.orderList
          ?.map((ProductModel product) => product.toJson())
          .toList()
    };
    log(body.toString());

    dynamic response = await PostRepository()
        .postRequest(path: PostRepository.saleBill, body: body);

    if (response["status"] == "success") {
      emit(state.copyWith(
        message: response["message"],
      ));

      emit(state.copyWith(
          billSavedSuccessfully:
              BillModel.fromJson(response['data'] as Map<String, dynamic>)));
      clearOrder();
    } else {
      emit(state.copyWith(message: 'Failed: ${response["message"]}'));
    }
  }

  void clearpaidPaymentModeList() {
    emit(state.copyWith(removepaidPaymentModeList: true, paidAmount: 0));
  }

  Future<void> fetchPaymentMode() async {
    try {
      final response = await GetRepository().getRequest(
          path: GetRepository.paymentMode,
          additionalHeader: {"company-id": Config.companyInfo!.id});

      if (response["status"] == "success") {
        List<dynamic> data = response["data"];
        List<PaymentModeModel> paymentModeList = data
            .map((paymentMode) => PaymentModeModel.fromJson(paymentMode))
            .where((element) => element.status)
            .toList();

        Map<String, PaymentModeModel> uniqueNamesMap = {};

        for (var paymentMode in paymentModeList) {
          if (!uniqueNamesMap.containsKey(paymentMode.name)) {
            uniqueNamesMap[paymentMode.name] = paymentMode;
          }
        }

        List<PaymentModeModel> uniqueByName = uniqueNamesMap.values.toList();
        emit(state.copyWith(paymentModeList: uniqueByName));
      } else {
        emit(state.copyWith(message: 'Failed to fetch payment mode data'));
      }
    } catch (e) {
      emit(state.copyWith(message: 'Error: $e'));
    }
  }

  void addpaidPaymentMode({required PaymentModeModel paidPaymentMode}) {
    List<PaymentModeModel> paidPaymentModeList =
        state.paidPaymentModeList ?? [];
    double paidAmount = 0.0;
    paidPaymentModeList.add(paidPaymentMode);
    for (PaymentModeModel paymentMode in paidPaymentModeList) {
      paidAmount += paymentMode.amount!;
    }
    emit(state.copyWith(
        paidPaymentModeList: paidPaymentModeList, paidAmount: paidAmount));
  }

  void removeOrderProduct() {
    ProductModel product = state.selectedProduct!;
    List<ProductModel> orderList = state.orderList ?? [];
    orderList.remove(product);
    emit(state.copyWith(orderList: orderList, removeSelectedProduct: true));
    calculateOrderSummary();
  }

  Future<bool> voidOrder({required String voidId}) async {
    ProductModel voidProduct = state.selectedProduct!;

    dynamic body = {
      "items": [
        {
          "bill_no": state.salesOrderBill?.billNo,
          "product_id": voidProduct.id,
          "qty": state.quantity,
          "amount": state.quantity * (voidProduct.lastUnitPrice ?? 1),
          "rate": voidProduct.lastUnitPrice,
          "user_id": state.salesOrderBill?.userId,
          "store_id": Config.storeInfo?.id,
          "terminal_id": Config.terminalInfo?.id,
          "table_id": state.selectedTable?.id,
          "void_reason_id": voidId
        }
      ]
    };

    dynamic response = await PostRepository()
        .postRequest(path: PostRepository.salesVoid, body: body);

    if (response["status"] == "success") {
      emit(state.copyWith(message: "Product Deleted"));
      if (state.quantity == state.selectedProduct!.quantity) {
        removeOrderProduct();
      } else {
        editQuantity(review: "");
      }

      return true;
    }
    return false;
  }

  Future<void> fetchVoidReason() async {
    final response = await GetRepository().getRequest(
        path: GetRepository.voidReason,
        additionalHeader: {"company-id": Config.companyInfo!.id});

    if (response["status"] == "success") {
      List<dynamic> data = response["data"];

      emit(state.copyWith(
          voidReasonList:
              data.map((reason) => VoidReasonModel.fromJson(reason)).toList()));
    }
  }

  Future<bool> fireOrder(
      {required OrderBillModel orderBill,
      required List<OrderBillLineModel> orderLineList}) async {
    OrderBillModel body = orderBill.copyWith(orderBillLine: orderLineList);
    dynamic response = await PutRepository().putRequest(
        path: PostRepository.salesOrder,
        editId: orderBill.id,
        body: body.toJson());

    if (response["status"] == "success") {
      return true;
    }
    return false;
  }

  Future<OrderBillModel?> salesOrder(
      {required String requestType, required String orderStatus}) async {
    dynamic body = {
      "order_status": orderStatus,
      "bill_date":
          "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}",
      "net_amount": state.totalAmount,
      "bill_amount": state.totalAmount,
      "table_no": state.selectedTable?.id,
      "discount_amount": state.discountAmount,
      "customer_code": state.customer?.code,
      "customer_name": state.customer?.name,
      "customer_address": state.customer?.billingAddress1,
      "customer_phone": state.customer?.billingPhone1,
      "customer_pan": state.customer?.panNo,
      "customer_billing_address": state.customer?.billingAddress1,
      "customer_billing_city": state.customer?.billingCity1,
      "customer_billing_street_name": state.customer?.billingStreetName1,
      "customer_billing_phone": state.customer?.billingPhone1,
      "customer_shipping_address": state.customer?.shippingAddress1,
      "customer_shipping_city": state.customer?.shippingCity1,
      "customer_shipping_street_name": state.customer?.shippingStreetName1,
      "customer_shipping_phone": state.customer?.shippingPhone1,
      "shipment_delivery_date": null,
      "shipment_vehicle_no": null,
      "shipment_vehicle_name": null,
      "shipment_vehicle_driver_name": null,
      "shipment_vehicle_driver_number": null,
      "shipment_vehicle_driver_license_no": null,
      "export_sales": state.exportSales == true ? 1 : 0,
      "tax_invoice": state.totalAmount > 10000
          ? 1
          : state.taxInvoice == true
              ? 1
              : 0,
      "loyalty_member_no": state.loyaltyMember?.memberCode,
      "sales_agent_id": null,
      "sales_lines": state.orderList
          ?.map((ProductModel product) => product.toJson())
          .toList(),
      "no_of_guests": state.noOfGuest,
    };
    dynamic response;
    if (requestType == "post") {
      response = await PostRepository()
          .postRequest(path: PostRepository.salesOrder, body: body);
    } else {
      response = await PutRepository().putRequest(
          path: PostRepository.salesOrder,
          editId: state.salesOrderBill!.id,
          body: body);
    }

    if (response["status"] == "success") {
      OrderBillModel salesOrderBill =
          OrderBillModel.fromJson(response['data'] as Map<String, dynamic>);
      fetchTables();
      return salesOrderBill;
    } else {
      emit(state.copyWith(message: 'Failed: ${response["message"]}'));
    }
    return null;
  }

  Future<bool> assignProuductListToOderList(
      {required List<ProductModel> productList}) async {
    emit(state.copyWith(orderList: productList));
    calculateOrderSummary();
    return true;
  }

  Future<void> margeAndAssignOrderUsingBillLine(
      {required List<OrderBillLineModel> billLineList}) async {
    Map<String, ProductModel> orderMap = {};

    for (OrderBillLineModel billLine in billLineList) {
      if (billLine.productInfo != null) {
        ProductModel product = billLine.productInfo!;
        String productId = product.id!;

        if (orderMap.containsKey(productId)) {
          // If product already exists, update its quantity
          orderMap[productId]!.quantity =
              (orderMap[productId]!.quantity ?? 0) + (product.quantity ?? 0);
        } else {
          // If product doesn't exist, add it to the map
          orderMap[productId] = product;
        }
      }
    }

    // Update the state with merged order list
    emit(state.copyWith(orderList: orderMap.values.toList()));
    calculateOrderSummary();
  }

  Future<bool> assignSalesLineToOrderList(
      {required List<OrderBillLineModel> billLineList}) async {
    List<ProductModel> orderList = state.orderList ?? [];
    for (OrderBillLineModel billLine in billLineList) {
      ProductModel product = billLine.productInfo!;
      orderList.add(
          product.copyWith(fired: billLine.fired, review: billLine.review));
    }

    emit(state.copyWith(orderList: orderList));
    calculateOrderSummary();
    return true;
  }

  Future<OrderBillModel?> getSalesOrderByTable({required int? tableId}) async {
    dynamic response = await GetRepository().getRequest(
        path: PostRepository.salesOrder,
        additionalHeader: {
          "company-id": Config.companyInfo!.id
        },
        queryParameters: {
          "table": tableId ?? state.selectedTable!.id,
          "status": "open"
        });

    if (response["status"] == "success") {
      if (response['data'] != null && (response['data']).isNotEmpty) {
        Map<String, dynamic> data = response['data'][0];
        OrderBillModel orderBill = OrderBillModel.fromJson(data);
        emit(state.copyWith(salesOrderBill: orderBill));

        return orderBill;
      }
    } else {
      emit(state.copyWith(message: 'Failed: ${response["message"]}'));
    }
    return null;
  }

  void editQuantity({required String review}) {
    ProductModel product = state.selectedProduct!;
    List<ProductModel> orderList = state.orderList ?? [];

    int index = orderList.indexWhere((item) => item == product);

    if (index != -1) {
      orderList[index] = state.selectedProduct!
          .copyWith(quantity: state.quantity, review: review);

      emit(state.copyWith(orderList: orderList, removeSelectedProduct: true));
      calculateOrderSummary();
    }
  }

  void assignQuantity(double quantity) {
    emit(state.copyWith(quantity: quantity));
  }

  void selectProduct({required ProductModel product}) {
    emit(state.copyWith(selectedProduct: product, quantity: product.quantity));
  }

  void assignProductList({required List<ProductModel> productList}) {
    emit(state.copyWith(productList: productList));
  }

  void assignLoyaltyMember({required LoyaltyMemberModel loyaltyMember}) {
    emit(state.copyWith(loyaltyMember: loyaltyMember));
    fetchLoyaltyMemberDiscount();
  }

  void assignDiscountPercentage({required double discountPercentage}) {
    emit(state.copyWith(discountPercentage: discountPercentage));
    calculateOrderSummary();
  }

  void assignLedger({required LedgerModel customer}) {
    emit(state.copyWith(customer: customer));
  }

  assignTable({required TableModel table}) {
    emit(state.copyWith(selectedTable: table));
  }

  void addProductToOrder(
      {required ProductModel product, required double quantity}) {
    List<ProductModel>? orderList = state.orderList ?? [];
    bool productFound = false;
    for (int i = 0; i < orderList.length; i++) {
      if (orderList[i] == product) {
        // If a matching product is found, update the quantity
        orderList[i] = orderList[i].copyWith(
          quantity: (orderList[i].quantity ?? 0) + quantity,
        );
        productFound = true;
        break;
      }
    }
    if (!productFound) {
      // If no matching product is found, add the new product to orderList
      orderList.add(product.copyWith(quantity: quantity));
    }

    // emit(state.copyWith(orderList: orderList, message: product.name));
    emit(state.copyWith(
        orderList: orderList,
        toastMessage: "${product.name} X ${quantity.toStringAsFixed(0)}"));

    calculateOrderSummary();
  }

  void calculateOrderSummary() {
    List<ProductModel>? orderList = state.orderList;
    double discountPercentage = state.discountPercentage;
    double discountAmount = 0;
    double subtotal = 0;
    double quantity = 0;
    if (orderList != null) {
      for (ProductModel product in orderList) {
        if (product.quantity != null) {
          //quantity = this.quantity + total previous quanity
          quantity = product.quantity! + quantity;
          if (product.lastUnitPrice != null) {
            //unit price summary is the this price * this*quantity
            double unitPriceSummary =
                product.quantity! * product.lastUnitPrice!;
            //subtotal = this.item quantiy * this.price + total previous subtotal
            subtotal += unitPriceSummary;
            if (product.discountable == "1") {
              discountAmount += (unitPriceSummary * discountPercentage) / 100;
            }
          }
        }
      }
    }
    emit(state.copyWith(
        subtotal: subtotal,
        discountAmount: discountAmount,
        orderQuantity: quantity,
        totalAmount: subtotal - discountAmount));
    // emit(state.copyWith(
    //   discountAmount: discountAmount,
    // ));
    // emit(state.copyWith(orderQuantity: quantity));
    // emit(state.copyWith(totalAmount: subtotal - discountAmount));
  }

  Future<void> fetchLoyaltyMemberDiscount() async {
    emit(state.copyWith(isLoading: true));

    dynamic response = await GetRepository().getRequest(
        path:
            "${GetRepository.loyaltyMemberDiscount}/${state.loyaltyMember!.id}",
        additionalHeader: {
          "company-id": Config.companyInfo!.id
        },
        data: {
          "product_codes":
              state.orderList?.map((product) => product.id).toList()
        });
    List data = response['data'];
    List<LoyaltyMemberDiscountModel> loyaltyMemberDiscountList = data
        .map((product) => LoyaltyMemberDiscountModel.fromJson(product))
        .toList();
    List<ProductModel> orderList = state.orderList!;
    List<ProductModel> newOderList = [];
    double discountAmount = 0.0;
    double discountAmountSummary = 0.0;

    for (int i = 0; i < orderList.length; i++) {
      ProductModel itemInfo = orderList[i];
      LoyaltyMemberDiscountModel loyaltyDiscountInfo =
          loyaltyMemberDiscountList[i];
      if (itemInfo.id == loyaltyDiscountInfo.productId &&
          itemInfo.discountable == "1") {
        double unitPrice = itemInfo.quantity! * itemInfo.lastUnitPrice!;
        discountAmount = (unitPrice * loyaltyDiscountInfo.discount) / 100;
        discountAmountSummary += discountAmount;
        newOderList.add(orderList[i].copyWith(
            discountPercentage: loyaltyMemberDiscountList[i].discount,
            discountAmount: discountAmount));
      } else {
        newOderList.add(orderList[i]);
      }
    }
    emit(state.copyWith(orderList: newOderList));
    emit(state.copyWith(discountAmount: discountAmountSummary));
    emit(state.copyWith(totalAmount: state.subtotal - discountAmountSummary));
  }

  void assignDiscountForOrder() {
    emit(state.copyWith(isLoading: true));
    List<ProductModel> orderList = state.orderList ?? [];
    List<ProductModel> finalizedOrderList = [];
    for (ProductModel item in orderList) {
      if (item.discountable == "1") {
        item.discountPercentage = state.discountPercentage;
        item.discountAmount = item.lastUnitPrice! *
            item.quantity! *
            state.discountPercentage /
            100;
      }
      finalizedOrderList.add(item);
    }
    emit(state.copyWith(orderList: finalizedOrderList));
    calculateOrderSummary();
  }

  void fetchProductForRetail() async {
    try {
      final response = await GetRepository().getRequest(
          path: GetRepository.product,
          additionalHeader: {"company-id": Config.companyInfo!.id},
          queryParameters: {"blocked": 0, "sellable_item": 1, "limit": 10});
      if (response["status"] == "success") {
        List<dynamic> productList = response["data"];
        emit(state.copyWith(
          productList:
              productList.map((json) => ProductModel.fromJson(json)).toList(),
          taxInvoice:
              Config.companyInfo?.taxInvoiceOnlyInPos == "1" ? true : false,
        ));
      } else {
        emit(state.copyWith(message: 'Failed to fetch data'));
      }
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(message: 'message: $e'));
    }
  }

  void fetchCategoryProduct() async {
    try {
      final response = await GetRepository().getRequest(
          path: GetRepository.product,
          additionalHeader: {"company-id": Config.companyInfo!.id},
          queryParameters: {"blocked": 0, "sellable_item": 1});
      if (response["status"] == "success") {
        List<dynamic> data = response["data"];
        Map<String, List<ProductModel>> categoryList = {};
        List<ProductModel> productList = [];

        // Group data based on categoryName
        for (var json in data) {
          ProductModel product = ProductModel.fromJson(json);
          productList.add(product);
          String categoryName = product.categoryName!;
          if (!categoryList.containsKey(categoryName)) {
            categoryList[categoryName] = [];
          }
          categoryList[categoryName]!.add(product);
        }

        emit(state.copyWith(
            categoryProductList: categoryList, productList: productList));
      } else {
        emit(state.copyWith(message: 'Failed to fetch data'));
      }
    } catch (e) {
      emit(state.copyWith(message: 'Failed: $e'));
    }
  }

  Future<void> fetchTables() async {
    emit(state.copyWith(tableList: []));
    List<SectionModel> sectionList = [];
    List<TableModel> tableList = [];

    try {
      final response = await GetRepository().getRequest(
          path: GetRepository.table,
          additionalHeader: {"company-id": Config.companyInfo!.id});

      if (response["status"] == "success") {
        List<dynamic> data = response["data"];
        List<String> sectionIds = [];
        for (var json in data) {
          TableModel table = TableModel.fromJson(json);
          if (table.section?.storeId != Config.storeInfo!.id) {
            return;
          }
          tableList.add(table);
          if (!sectionIds.contains(table.sectionId)) {
            sectionIds.add(table.sectionId);
            sectionList.add(table.section!);
          }
        }

        emit(state.copyWith(
          tableList: tableList,
          sectionList: sectionList,
        ));
      } else {
        emit(state.copyWith(message: 'Failed to fetch Table'));
      }
    } catch (e) {
      emit(state.copyWith(message: 'Failed: $e store not assigned'));
    }
  }

  // Future<void> fetchSection() async {
  //   try {
  //     final response = await GetRepository().getRequest(
  //         path: GetRepository.section,
  //         additionalHeader: {"company-id": Config.companyInfo!.id});

  //     if (response["status"] == "success") {
  //       List<dynamic> sectionList = response["data"];
  //       emit(state.copyWith(
  //         sectionList:
  //             sectionList.map((json) => SectionModel.fromJson(json)).toList(),
  //       ));
  //     } else {
  //       emit(state.copyWith(message: 'Failed to fetch data'));
  //     }
  //   } catch (e) {
  //     emit(state.copyWith(message: 'Error: $e'));
  //   }
  // }

  void clearOrder() {
    emit(state.copyWith(
      orderQuantity: 0,
      removeOrder: true,
      orderList: null,
      removeCustomer: true,
      removeLoyaltyMember: true,
      customer: null,
      removepaidPaymentModeList: true,
      discountAmount: 0,
      discountPercentage: 0,
      totalAmount: 0,
      paidAmount: 0,
      subtotal: 0,
      taxInvoice: false,
      exportSales: false,
      noOfGuest: 1,
      removeSalesOrderBill: true,
      // removeSelectedTable: true,
    ));
  }
}
