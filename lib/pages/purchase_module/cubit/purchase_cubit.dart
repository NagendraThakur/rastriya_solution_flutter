import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rastriya_solution_flutter/constants/config.dart';
import 'package:rastriya_solution_flutter/data/repository/get_repository.dart';
import 'package:rastriya_solution_flutter/model/ledger_model.dart';
import 'package:rastriya_solution_flutter/model/product_model.dart';
import 'package:rastriya_solution_flutter/model/purchase_model.dart';
part 'purchase_state.dart';

class PurchaseCubit extends Cubit<PurchaseState> {
  PurchaseCubit() : super(PurchaseState.initial());

  assignProductToPurchaseLine({required ProductModel product}) {
    double calculateNetAmount() {
      double quantityValue = product.quantity!;
      double lastUnitCostValue = product.lastUnitCost!;
      double total = quantityValue * lastUnitCostValue;
      double discountValue = product.discountAmount!;
      return total - discountValue;
    }

    double netAmount = calculateNetAmount();

    PurchaseLine purchaseLine = PurchaseLine(
      productCode: product.productCode,
      unitCode: product.baseUnit,
      quantity: product.quantity,
      rate: product.lastUnitCost,
      discountPercent: product.discountPercentage,
      discountAmount: product.discountAmount,
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
