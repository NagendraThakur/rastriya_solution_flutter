import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rastriya_solution_flutter/constants/config.dart';
import 'package:rastriya_solution_flutter/data/repository/get_repository.dart';
import 'package:rastriya_solution_flutter/model/ledger_model.dart';
import 'package:rastriya_solution_flutter/model/purchase_model.dart';
part 'purchase_state.dart';

class PurchaseCubit extends Cubit<PurchaseState> {
  PurchaseCubit() : super(PurchaseState.initial());

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
