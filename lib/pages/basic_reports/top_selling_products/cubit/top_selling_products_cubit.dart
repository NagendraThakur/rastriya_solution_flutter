import 'package:bloc/bloc.dart';
import 'package:rastriya_solution_flutter/constants/config.dart';
import 'package:rastriya_solution_flutter/data/repository/get_repository.dart';
import 'package:rastriya_solution_flutter/model/top_selling_products_model.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart' as picker;
part 'top_selling_products_state.dart';

class TopSellingProductsCubit extends Cubit<TopSellingProductsState> {
  TopSellingProductsCubit() : super(TopSellingProductsState.initial());

  Future<void> fetchTopSellingProducts(
      {required picker.NepaliDateTime fromDate,
      required picker.NepaliDateTime toDate}) async {
    emit(state.copyWith(isLoading: true));
    dynamic response = await GetRepository().getRequest(
      path: GetRepository.dailyProductReport,
      queryParameters: {"store": Config.storeInfo!.id},
      additionalHeader: {"company-id": Config.companyInfo!.id},
      data: {
        "start_date":
            "${fromDate.toDateTime().year}-${fromDate.toDateTime().month}-${fromDate.toDateTime().day}",
        "end_date":
            "${toDate.toDateTime().year}-${toDate.toDateTime().month}-${toDate.toDateTime().day}",
      },
    );
    emit(state.copyWith(isLoading: false));
    if (response["status"] == "success") {
      List? data = response["report"];
      if (data != null && data.isNotEmpty) {
        List<TopSellingProductsModel> productSalesReportList = data
            .map((productReport) =>
                TopSellingProductsModel.fromJson(productReport))
            .toList();
        Map<String, TopSellingProductsModel> aggregatedData = {};

        for (var productReport in productSalesReportList) {
          if (!aggregatedData.containsKey(productReport.productName)) {
            aggregatedData[productReport.productName] = productReport;
          } else {
            // Aggregate values
            aggregatedData[productReport.productName] = TopSellingProductsModel(
              productName: productReport.productName,
              salesQuantity:
                  aggregatedData[productReport.productName]!.salesQuantity +
                      productReport.salesQuantity,
              salesReturnQuantity: aggregatedData[productReport.productName]!
                      .salesReturnQuantity +
                  productReport.salesReturnQuantity,
              netQuantity:
                  aggregatedData[productReport.productName]!.netQuantity +
                      productReport.netQuantity,
              grossAmount:
                  aggregatedData[productReport.productName]!.grossAmount +
                      productReport.grossAmount,
              discountAmount:
                  aggregatedData[productReport.productName]!.discountAmount +
                      productReport.discountAmount,
              amount: aggregatedData[productReport.productName]!.amount +
                  productReport.amount,
              vatAmount: aggregatedData[productReport.productName]!.vatAmount +
                  productReport.vatAmount,
              netAmount: aggregatedData[productReport.productName]!.netAmount +
                  productReport.netAmount,
            );
          }
        }
        emit(state.copyWith(
            topSellingProductsList:
                aggregatedData.entries.map((entry) => entry.value).toList()));
      }
    }
  }
}
