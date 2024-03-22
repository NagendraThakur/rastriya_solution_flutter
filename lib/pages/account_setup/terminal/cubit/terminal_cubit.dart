import 'package:bloc/bloc.dart';
import 'package:rastriya_solution_flutter/constants/config.dart';
import 'package:rastriya_solution_flutter/data/repository/get_repository.dart';
import 'package:rastriya_solution_flutter/data/repository/post_repository.dart';
import 'package:rastriya_solution_flutter/data/repository/put_repository.dart';
import 'package:rastriya_solution_flutter/model/store_model.dart';
import 'package:rastriya_solution_flutter/model/terminal_model.dart';
part 'terminal_state.dart';

class TerminalCubit extends Cubit<TerminalState> {
  TerminalCubit() : super(TerminalState.initial());

  Future<void> saveTerminal({required TerminalModel terminal}) async {
    emit(state.copyWith(isLoading: true));
    dynamic response;
    if (terminal.id == null) {
      response = await PostRepository().postRequest(
          path: GetRepository.posTerminal, body: terminal.toJson());
    } else {
      response = await PutRepository().putRequest(
          path: GetRepository.posTerminal,
          editId: terminal.id,
          body: terminal.toJson());
    }
    emit(state.copyWith(isLoading: false));

    if (response["status"] == "success") {
      emit(state.copyWith(
        message: response["message"],
        isLoading: false,
      ));
      fetchTerminal();
    } else {
      emit(state.copyWith(message: 'Failed: ${response["message"]}'));
    }
  }

  Future<void> fetchTerminal() async {
    emit(state.copyWith(isFetching: true));

    try {
      final response = await GetRepository().getRequest(
          path: GetRepository.posTerminal,
          additionalHeader: {"company-id": Config.companyInfo!.id});
      emit(state.copyWith(isFetching: false));
      if (response["status"] == "success") {
        List<dynamic> data = response["terminal_lists"];
        List<dynamic> storeList = response["store_lists"];
        emit(state.copyWith(
          terminalList:
              data.map((json) => TerminalModel.fromJson(json)).toList(),
          storeList:
              storeList.map((json) => StoreModel.fromJson(json)).toList(),
        ));
      } else {
        emit(state.copyWith(message: 'Failed to fetch data'));
      }
    } catch (e) {
      emit(state.copyWith(message: 'Failed: $e'));
    }
  }
}
