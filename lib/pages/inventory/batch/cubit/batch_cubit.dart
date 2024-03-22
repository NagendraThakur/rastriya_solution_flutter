import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rastriya_solution_flutter/constants/config.dart';
import 'package:rastriya_solution_flutter/data/repository/get_repository.dart';
import 'package:rastriya_solution_flutter/data/repository/post_repository.dart';
import 'package:rastriya_solution_flutter/data/repository/put_repository.dart';
import 'package:rastriya_solution_flutter/model/batch_model.dart';
import 'package:rastriya_solution_flutter/model/product_model.dart';

part 'batch_state.dart';

class BatchCubit extends Cubit<BatchState> {
  BatchCubit() : super(BatchState.initial());

  Future<void> saveBatch({required BatchModel batch}) async {
    emit(state.copyWith(isLoading: true));

    try {
      dynamic response;

      if (batch.id == null) {
        response = await PostRepository()
            .postRequest(path: GetRepository.batch, body: batch.toJson());
      } else {
        response = await PutRepository().putRequest(
            path: GetRepository.batch, editId: batch.id, body: batch.toJson());
      }
      emit(state.copyWith(isLoading: false));
      if (response["status"] == "success") {
        emit(state.copyWith(
          message: response["message"],
          isLoading: false,
        ));
        fetchBatch();
      } else {
        emit(state.copyWith(message: 'Failed: ${response["message"]}'));
      }
    } catch (e) {
      emit(state.copyWith(message: 'Failed: $e'));
    }
  }

  Future<void> fetchProduct() async {
    emit(state.copyWith(isFetching: true));

    try {
      final response = await GetRepository().getRequest(
          path: GetRepository.product,
          additionalHeader: {"company-id": Config.companyInfo!.id});
      emit(state.copyWith(isFetching: false));
      if (response["status"] == "success") {
        List<dynamic> data = response["data"];
        emit(state.copyWith(
          productList: data.map((json) => ProductModel.fromJson(json)).toList(),
        ));
      } else {
        emit(state.copyWith(message: 'Failed to fetch data'));
      }
    } catch (e) {
      emit(state.copyWith(message: 'Failed: $e'));
    }
  }

  Future<void> fetchBatch() async {
    emit(state.copyWith(isFetching: true));
    dynamic response = await GetRepository().getRequest(
      path: GetRepository.batch,
      additionalHeader: {"company-id": Config.companyInfo!.id},
    );
    emit(state.copyWith(isFetching: false));
    if (response["status"] == "success") {
      List? data = response["data"];
      if (data != null && data.isNotEmpty) {
        List<BatchModel> batchList =
            data.map((batch) => BatchModel.fromJson(batch)).toList();
        emit(state.copyWith(batchList: batchList));
      }
    }
  }
}
