import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rastriya_solution_flutter/constants/config.dart';
import 'package:rastriya_solution_flutter/data/repository/get_repository.dart';
import 'package:rastriya_solution_flutter/data/repository/post_repository.dart';
import 'package:rastriya_solution_flutter/model/bill_model.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart' as picker;
part 'sales_return_state.dart';

class SalesReturnCubit extends Cubit<SalesReturnState> {
  SalesReturnCubit() : super(SalesReturnState.initial());

  Future<void> fetchSalesBill(
      {required picker.NepaliDateTime fromDate,
      required picker.NepaliDateTime toDate}) async {
    try {
      emit(state.copyWith(
        isLoading: true,
      ));
      final response = await GetRepository().getRequest(
        path: GetRepository.salesReturn,
        additionalHeader: {"company-id": Config.companyInfo!.id},
        data: {
          "start_date":
              "${fromDate.toDateTime().year}-${fromDate.toDateTime().month}-${fromDate.toDateTime().day}",
          "end_date":
              "${toDate.toDateTime().year}-${toDate.toDateTime().month}-${toDate.toDateTime().day}",
        },
      );

      if (response["status"] == "success") {
        double totalBillsAmount = 0.0;
        List<dynamic> data = response["data"];
        List<BillModel> salesBillList = data.map((json) {
          BillModel bill = BillModel.fromJson(json);
          totalBillsAmount += bill.billAmount!;
          return bill;
        }).toList();

        emit(state.copyWith(
          salesBillList: salesBillList,
          salesBillSearchResult: salesBillList,
          totalBillsAmount: totalBillsAmount,
          isLoading: false,
        ));
      } else {
        emit(state.copyWith(
            message: 'Failed to fetch sales bill', isLoading: false));
      }
    } catch (e) {
      emit(state.copyWith(message: 'Error: $e', isLoading: false));
    }
  }

  void salesBillSearch({required String value}) {
    List<BillModel>? salesBillList = state.salesBillList;
    List<BillModel>? salesBillSearchResult = [];

    if (salesBillList != null && salesBillList.isNotEmpty) {
      final searchValueLowerCase = value.toLowerCase();
      double totalBillsAmount = 0.0;
      for (BillModel bill in salesBillList) {
        if (bill.billNo.toLowerCase().contains(searchValueLowerCase) ||
            (bill.orderNo != null &&
                bill.orderNo!.toLowerCase().contains(searchValueLowerCase)) ||
            (bill.tableNo != null &&
                bill.tableNo!.toLowerCase().contains(searchValueLowerCase)) ||
            (bill.customerName != null &&
                bill.customerName!
                    .toLowerCase()
                    .contains(searchValueLowerCase)) ||
            (bill.customerAddress != null &&
                bill.customerAddress!
                    .toLowerCase()
                    .contains(searchValueLowerCase)) ||
            (bill.customerPhone != null &&
                bill.customerPhone!
                    .toLowerCase()
                    .contains(searchValueLowerCase)) ||
            (bill.customerPan != null &&
                bill.customerPan!
                    .toLowerCase()
                    .contains(searchValueLowerCase))) {
          salesBillSearchResult.add(bill);

          totalBillsAmount += (bill.billAmount!);
        }
      }
      emit(state.copyWith(
        salesBillSearchResult: salesBillSearchResult,
        totalBillsAmount: totalBillsAmount,
      ));
    }
  }
}
