import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rastriya_solution_flutter/constants/config.dart';
import 'package:rastriya_solution_flutter/data/repository/get_repository.dart';
import 'package:rastriya_solution_flutter/model/void_report_model.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart' as picker;
part 'void_product_state.dart';

class VoidProductCubit extends Cubit<VoidProductState> {
  VoidProductCubit() : super(VoidProductState.initial());

  Future<void> fetchVoidReport(
      {required picker.NepaliDateTime fromDate,
      required picker.NepaliDateTime toDate}) async {
    emit(state.copyWith(isLoading: true));
    dynamic response = await GetRepository().getRequest(
      path: GetRepository.voidOrderReport,
      queryParameters: {"store": Config.storeInfo!.id},
      additionalHeader: {"company-id": Config.companyInfo!.id},
    );
    emit(state.copyWith(isLoading: false));
    if (response["status"] == "success") {
      List? data = response["report"];
      if (data != null && data.isNotEmpty) {
        List<VoidReportModel> voidReportList =
            data.map((json) => VoidReportModel.fromJson(json)).toList();
        emit(state.copyWith(voidReportList: voidReportList));
      }
    }
  }
}
