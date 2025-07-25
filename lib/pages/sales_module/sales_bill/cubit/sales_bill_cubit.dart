import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rastriya_solution_flutter/constants/config.dart';
import 'package:rastriya_solution_flutter/data/repository/get_repository.dart';
import 'package:rastriya_solution_flutter/data/repository/post_repository.dart';
import 'package:rastriya_solution_flutter/model/bill_model.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart' as picker;
part 'sales_bill_state.dart';

class SalesBillCubit extends Cubit<SalesBillState> {
  SalesBillCubit() : super(SalesBillState.initial());

  Future<void> fetchSalesBill(
      {required picker.NepaliDateTime fromDate,
      required picker.NepaliDateTime toDate}) async {
    try {
      emit(state.copyWith(
        isFetching: true,
      ));
      final response = await GetRepository().getRequest(
        path: GetRepository.salesBill,
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
        double totalDiscountAmount = 0.0;
        List<dynamic> data = response["data"];
        List<BillModel> salesBillList = data.map((json) {
          BillModel bill = BillModel.fromJson(json);
          totalBillsAmount += bill.billAmount!;
          totalDiscountAmount += bill.discountAmount!;
          return bill;
        }).toList();

        emit(state.copyWith(
          salesBillList: salesBillList,
          salesBillSearchResult: salesBillList,
          totalBillsAmount: totalBillsAmount,
          totalDiscountAmount: totalDiscountAmount,
        ));
      } else {
        emit(state.copyWith(message: 'Failed to fetch sales bill'));
      }
    } catch (e) {
      emit(state.copyWith(message: 'Error: $e'));
    }
  }

  void salesBillSearch({required String value}) {
    List<BillModel>? salesBillList = state.salesBillList;
    List<BillModel>? salesBillSearchResult = [];

    if (salesBillList != null && salesBillList.isNotEmpty) {
      final searchValueLowerCase = value.toLowerCase();
      double totalBillsAmount = 0.0;
      double totalDiscountAmount = 0.0;
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
          totalDiscountAmount += (bill.discountAmount!);
        }
      }
      emit(state.copyWith(
        salesBillSearchResult: salesBillSearchResult,
        totalBillsAmount: totalBillsAmount,
        totalDiscountAmount: totalDiscountAmount,
      ));
    }
  }

  Future<void> createSalesReturn(
      {required BillModel salesBill, required String returnReason}) async {
    try {
      emit(state.copyWith(
        isLoading: true,
      ));
      dynamic body = salesBill.salesReturnToJson(returnReason: returnReason);
      final response = await PostRepository().postRequest(
        path: PostRepository.salesReturn,
        body: body,
      );

      if (response["status"] == "success") {
        BillModel returnBill = BillModel.fromJson(response["data"]);
        log(returnBill.toString());
        emit(state.copyWith(salesReturnSuccess: returnBill));
        emit(state.copyWith(message: "Sales Return Created Successfully"));
        emit(state.copyWith(isLoading: false));
      } else {
        emit(state.copyWith(message: 'Failed to fetch sales bill'));
        emit(state.copyWith(isLoading: false));
      }
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(message: 'Error: $e'));
      emit(state.copyWith(isLoading: false));
    }
  }
}
