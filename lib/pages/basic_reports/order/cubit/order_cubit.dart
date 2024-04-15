import 'package:bloc/bloc.dart';
import 'package:rastriya_solution_flutter/constants/config.dart';
import 'package:rastriya_solution_flutter/data/repository/get_repository.dart';
import 'package:rastriya_solution_flutter/model/order_report_model.dart';
part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderState.initial());

  Future<void> fetchOrderReport() async {
    emit(state.copyWith(isLoading: true));
    dynamic response = await GetRepository().getRequest(
      path: GetRepository.fAndBOrderReport,
      additionalHeader: {"company-id": Config.companyInfo!.id},
    );
    emit(state.copyWith(isLoading: false));

    if (response["status"] == "success") {
      List? data = response["report"];
      if (data != null && data.isNotEmpty) {
        List<OrderReportModel> orderReportList =
            data.map((json) => OrderReportModel.fromJson(json)).toList();

        // Emit in batches of 20
        int batchSize = 20;
        int numberOfBatches = (orderReportList.length / batchSize).ceil();

        for (int i = 0; i < numberOfBatches; i++) {
          int start = i * batchSize;
          int end = (i + 1) * batchSize;
          if (end > orderReportList.length) {
            end = orderReportList.length;
          }
          List<OrderReportModel> batch = orderReportList.sublist(start, end);
          emit(state.copyWith(orderReportList: batch));
          // You might want to add a small delay between batches if needed
          // await Future.delayed(Duration(milliseconds: 100));
        }
      }
    }
  }
}
