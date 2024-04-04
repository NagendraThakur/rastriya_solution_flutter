import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:rastriya_solution_flutter/constants/config.dart';
import 'package:rastriya_solution_flutter/data/repository/get_repository.dart';
import 'package:rastriya_solution_flutter/model/bill_model.dart';
import 'package:rastriya_solution_flutter/model/category_model.dart';
import 'package:rastriya_solution_flutter/model/ledger_model.dart';
import 'package:rastriya_solution_flutter/model/loyalty_member_discount_model.dart';
import 'package:rastriya_solution_flutter/model/loyalty_member_model.dart';
import 'package:rastriya_solution_flutter/model/payment_mode_model.dart';
import 'package:rastriya_solution_flutter/model/product_model.dart';
import 'package:rastriya_solution_flutter/model/sales_order_model.dart';
import 'package:rastriya_solution_flutter/model/section_model.dart';
import 'package:rastriya_solution_flutter/model/table_model.dart';

part 'pos_state.dart';

class PosCubit extends Cubit<PosState> {
  PosCubit() : super(PosState.initial());

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

    try {
      final response = await GetRepository().getRequest(
          path: GetRepository.table,
          additionalHeader: {"company-id": Config.companyInfo!.id});

      if (response["status"] == "success") {
        List<dynamic> tableList = response["data"];
        emit(state.copyWith(
          tableList:
              tableList.map((json) => TableModel.fromJson(json)).toList(),
        ));
      } else {
        emit(state.copyWith(message: 'Failed to fetch data'));
      }
    } catch (e) {
      emit(state.copyWith(message: 'Failed: $e'));
    }
  }

  Future<void> fetchSection() async {
    try {
      final response = await GetRepository().getRequest(
          path: GetRepository.section,
          additionalHeader: {"company-id": Config.companyInfo!.id});

      if (response["status"] == "success") {
        List<dynamic> sectionList = response["data"];
        emit(state.copyWith(
          sectionList:
              sectionList.map((json) => SectionModel.fromJson(json)).toList(),
        ));
      } else {
        emit(state.copyWith(message: 'Failed to fetch data'));
      }
    } catch (e) {
      emit(state.copyWith(message: 'Error: $e'));
    }
  }

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
