import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rastriya_solution_flutter/constants/config.dart';
import 'package:rastriya_solution_flutter/data/repository/get_repository.dart';
import 'package:rastriya_solution_flutter/model/top_selling_products_model.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart' as picker;

part 'top_selling_products_state.dart';

class TopSellingProductsCubit extends Cubit<TopSellingProductsState> {
  TopSellingProductsCubit() : super(TopSellingProductsState.initial()) {
    fetchTopSellingProducts(fromDate: fromDate, toDate: toDate);
  }
  picker.NepaliDateTime fromDate = picker.NepaliDateTime.now();
  picker.NepaliDateTime toDate = picker.NepaliDateTime.now();
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
        List<TopSellingProductsModel> topSellingProductsList =
            data.map((json) => TopSellingProductsModel.fromJson(json)).toList();
        emit(state.copyWith(topSellingProductsList: topSellingProductsList));
      }
    }
  }
}
