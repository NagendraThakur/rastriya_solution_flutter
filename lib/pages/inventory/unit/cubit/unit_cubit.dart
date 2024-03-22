import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rastriya_solution_flutter/constants/config.dart';
import 'package:rastriya_solution_flutter/data/repository/get_repository.dart';
import 'package:rastriya_solution_flutter/data/repository/post_repository.dart';
import 'package:rastriya_solution_flutter/data/repository/put_repository.dart';
import 'package:rastriya_solution_flutter/model/unit_model.dart';

part 'unit_state.dart';

class UnitCubit extends Cubit<UnitState> {
  UnitCubit() : super(UnitState.initial());

  Future<void> saveUnit({required UnitModel unit}) async {
    emit(state.copyWith(isLoading: true));

    try {
      final body = {"name": unit.name};
      dynamic response;

      if (unit.id == null) {
        response = await PostRepository()
            .postRequest(path: GetRepository.unit, body: body);
      } else {
        response = await PutRepository()
            .putRequest(path: GetRepository.unit, editId: unit.id, body: body);
      }
      emit(state.copyWith(isLoading: false));
      if (response["status"] == "success") {
        emit(state.copyWith(
          message: response["message"],
          isLoading: false,
        ));
        fetchUnits();
      } else {
        emit(state.copyWith(message: 'Failed: ${response["message"]}'));
      }
    } catch (e) {
      emit(state.copyWith(message: 'Failed: $e'));
    }
  }

  Future<void> fetchUnits() async {
    emit(state.copyWith(isFetching: true));
    dynamic response = await GetRepository().getRequest(
      path: GetRepository.unit,
      additionalHeader: {"company-id": Config.companyInfo!.id},
    );
    emit(state.copyWith(isFetching: false));
    if (response["status"] == "success") {
      List? data = response["units"];
      if (data != null && data.isNotEmpty) {
        List<UnitModel> unitList =
            data.map((unit) => UnitModel.fromJson(unit)).toList();
        emit(state.copyWith(unitList: unitList));
      }
    }
  }
}
