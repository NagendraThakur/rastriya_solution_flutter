import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rastriya_solution_flutter/constants/config.dart';
import 'package:rastriya_solution_flutter/data/repository/get_repository.dart';
import 'package:rastriya_solution_flutter/data/repository/post_repository.dart';
import 'package:rastriya_solution_flutter/data/repository/put_repository.dart';
import 'package:rastriya_solution_flutter/model/print_station_model.dart';
part 'print_station_state.dart';

class PrintStationCubit extends Cubit<PrintStationState> {
  PrintStationCubit() : super(PrintStationState.initial()) {
    Future.delayed(Duration.zero, () => fetchPrintStations());
  }

  Future<void> savePrintStation(
      {required PrintStationModel printStation}) async {
    emit(state.copyWith(isLoading: true, message: ''));
    dynamic response;
    if (printStation.id == null) {
      response = await PostRepository().postRequest(
          path: PostRepository.printStation, body: printStation.toJson());
    } else {
      response = await PutRepository().putRequest(
          path: PostRepository.printStation,
          editId: printStation.id!,
          body: printStation.toJson());
    }
    emit(state.copyWith(isLoading: false));

    if (response["status"] == "success") {
      emit(state.copyWith(
        message: response["message"],
        isLoading: false,
      ));
      fetchPrintStations();
    } else {
      emit(state.copyWith(message: 'Failed: ${response["message"]}'));
    }
  }

  Future<void> fetchPrintStations() async {
    emit(state.copyWith(isFetching: true));
    try {
      final response = await GetRepository().getRequest(
          path: GetRepository.printStation,
          additionalHeader: {"company-id": Config.companyInfo!.id});
      emit(state.copyWith(isFetching: false));

      if (response["status"] == "success") {
        List<dynamic> printStationData = response["print_station_lists"];
        emit(state.copyWith(
          printStationList: printStationData
              .map((json) => PrintStationModel.fromJson(json))
              .toList(),
        ));
      } else {
        emit(state.copyWith(message: 'Failed to fetch data'));
      }
    } catch (e) {
      emit(state.copyWith(message: 'Error: $e'));
    }
  }
}
