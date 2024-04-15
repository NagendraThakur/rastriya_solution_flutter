import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart' as picker;
import 'package:rastriya_solution_flutter/constants/config.dart';
import 'package:rastriya_solution_flutter/data/repository/get_repository.dart';

part 'collection_state.dart';

class CollectionCubit extends Cubit<CollectionState> {
  CollectionCubit() : super(CollectionState.initial());

  Future<void> fetchCollectionReport(
      {required picker.NepaliDateTime fromDate,
      required picker.NepaliDateTime toDate}) async {
    emit(state.copyWith(isLoading: true));
    dynamic response = await GetRepository().getRequest(
      path: GetRepository.collectionReport,
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
      Map<String, dynamic>? report = response["report"];
      emit(state.copyWith(report: report));
    } else {
      emit(state.copyWith(message: "Failed: Something went wrong"));
    }
  }
}
