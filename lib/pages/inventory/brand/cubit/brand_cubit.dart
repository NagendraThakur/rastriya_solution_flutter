import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rastriya_solution_flutter/constants/config.dart';
import 'package:rastriya_solution_flutter/data/repository/get_repository.dart';
import 'package:rastriya_solution_flutter/data/repository/post_repository.dart';
import 'package:rastriya_solution_flutter/data/repository/put_repository.dart';
import 'package:rastriya_solution_flutter/model/brand_model.dart';
part 'brand_state.dart';

class BrandCubit extends Cubit<BrandState> {
  BrandCubit() : super(BrandState.initial()) {
    Future.delayed(Duration.zero, () => fetchBrands());
  }

  Future<void> saveBrand({required BrandModel brand}) async {
    emit(state.copyWith(isLoading: true));

    try {
      dynamic response;

      if (brand.id == null) {
        response = await PostRepository()
            .postRequest(path: GetRepository.brand, body: brand.toJson());
      } else {
        response = await PutRepository().putRequest(
            path: GetRepository.brand, editId: brand.id, body: brand.toJson());
      }
      emit(state.copyWith(isLoading: false));
      if (response["status"] == "success") {
        emit(state.copyWith(
          message: response["message"],
          isLoading: false,
        ));
        fetchBrands();
      } else {
        emit(state.copyWith(message: 'Failed: ${response["message"]}'));
      }
    } catch (e) {
      emit(state.copyWith(message: 'Failed: $e'));
    }
  }

  Future<void> fetchBrands() async {
    emit(state.copyWith(isFetching: true));
    dynamic response = await GetRepository().getRequest(
      path: GetRepository.brand,
      additionalHeader: {"company-id": Config.companyInfo!.id},
    );
    emit(state.copyWith(isFetching: false));
    if (response["status"] == "success") {
      List? data = response["data"];
      if (data != null && data.isNotEmpty) {
        List<BrandModel> brandList =
            data.map((ledger) => BrandModel.fromJson(ledger)).toList();
        emit(state.copyWith(brandList: brandList));
      }
    }
  }
}
