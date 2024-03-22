import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rastriya_solution_flutter/constants/config.dart';
import 'package:rastriya_solution_flutter/data/repository/get_repository.dart';
import 'package:rastriya_solution_flutter/data/repository/post_repository.dart';
import 'package:rastriya_solution_flutter/data/repository/put_repository.dart';
import 'package:rastriya_solution_flutter/model/store_model.dart';

part 'store_setup_state.dart';

class StoreSetupCubit extends Cubit<StoreSetupState> {
  StoreSetupCubit() : super(StoreSetupState.initial());
  Future<void> saveStore({required StoreModel store}) async {
    emit(state.copyWith(isLoading: true));

    try {
      dynamic response;
      if (store.id == null) {
        response = await PostRepository()
            .postRequest(path: GetRepository.store, body: store.toJson());
      } else {
        response = await PutRepository().putRequest(
            path: GetRepository.store, editId: store.id, body: store.toJson());
      }
      emit(state.copyWith(isLoading: false));
      if (response["status"] == "success") {
        emit(state.copyWith(
          message: response["message"],
          isLoading: false,
        ));
        fetchStore();
      } else {
        emit(state.copyWith(message: 'Failed: ${response["message"]}'));
      }
    } catch (e) {
      emit(state.copyWith(message: 'Failed: $e'));
    }
  }

  Future<void> fetchStore() async {
    emit(state.copyWith(isFetching: true));

    try {
      final response = await GetRepository().getRequest(
          path: GetRepository.store,
          additionalHeader: {"company-id": Config.companyInfo!.id});
      emit(state.copyWith(isFetching: false));
      if (response["status"] == "success") {
        List<dynamic> data = response["store_lists"];
        emit(state.copyWith(
          storeList: data.map((json) => StoreModel.fromJson(json)).toList(),
        ));
      } else {
        emit(state.copyWith(message: 'Failed to fetch data'));
      }
    } catch (e) {
      emit(state.copyWith(message: 'Failed: $e'));
    }
  }
}
