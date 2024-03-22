import 'package:bloc/bloc.dart';
import 'package:rastriya_solution_flutter/constants/config.dart';
import 'package:rastriya_solution_flutter/data/repository/get_repository.dart';
import 'package:rastriya_solution_flutter/data/repository/post_repository.dart';
import 'package:rastriya_solution_flutter/data/repository/put_repository.dart';
import 'package:rastriya_solution_flutter/model/ledger_model.dart';

part 'ledger_state.dart';

class LedgerCubit extends Cubit<LedgerState> {
  LedgerCubit() : super(LedgerState.initial());

  Future<void> saveLedger({required LedgerModel ledger}) async {
    emit(state.copyWith(isLoading: true));

    try {
      dynamic response;

      if (ledger.id == null) {
        response = await PostRepository()
            .postRequest(path: GetRepository.ledger, body: ledger.toJson());
      } else {
        response = await PutRepository().putRequest(
            path: GetRepository.ledger,
            editId: ledger.id,
            body: ledger.toJson());
      }
      emit(state.copyWith(isLoading: false));
      if (response["status"] == "success") {
        emit(state.copyWith(
          message: response["message"],
          isLoading: false,
        ));
        fetchLedger(ledgerTypeInitial: ledger.ledgerType!);
      } else {
        emit(state.copyWith(message: 'Failed: ${response["message"]}'));
      }
    } catch (e) {
      emit(state.copyWith(message: 'Failed: $e'));
    }
  }

  Future<void> fetchLedger({required String ledgerTypeInitial}) async {
    emit(state.copyWith(isFetching: true));
    dynamic response = await GetRepository().getRequest(
        path: GetRepository.ledger,
        additionalHeader: {"company-id": Config.companyInfo!.id},
        queryParameters: {"type": ledgerTypeInitial});
    emit(state.copyWith(isFetching: false));
    if (response["status"] == "success") {
      List? data = response["data"];
      if (data != null && data.isNotEmpty) {
        List<LedgerModel> ledgerList =
            data.map((ledger) => LedgerModel.fromJson(ledger)).toList();
        emit(state.copyWith(ledgerList: ledgerList));
      }
    }
  }

  Future<void> searchLedger(
      {required String? searchText, required String ledgerTypeInitial}) async {
    if (searchText != null && searchText.isNotEmpty) {
      dynamic response = await GetRepository().getRequest(
          path: "${GetRepository.searchLedger}/$searchText",
          additionalHeader: {"company-id": Config.companyInfo!.id},
          queryParameters: {"type": ledgerTypeInitial});
      if (response["status"] == "success") {
        List? data = response["data"];
        if (data != null && data.isNotEmpty) {
          List<LedgerModel> ledgerList =
              data.map((ledger) => LedgerModel.fromJson(ledger)).toList();
          emit(state.copyWith(ledgerList: ledgerList));
        }
      }
    }
  }
}
