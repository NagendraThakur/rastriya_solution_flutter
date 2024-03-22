import 'package:bloc/bloc.dart';
import 'package:rastriya_solution_flutter/constants/config.dart';
import 'package:rastriya_solution_flutter/data/repository/get_repository.dart';
import 'package:rastriya_solution_flutter/data/repository/post_repository.dart';
import 'package:rastriya_solution_flutter/data/repository/put_repository.dart';
import 'package:rastriya_solution_flutter/model/category_model.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryState.initial());

  Future<void> saveCategory({required CategoryModel category}) async {
    emit(state.copyWith(isLoading: true));
    final body = {
      "name": category.name,
      "bronze_discount": 0,
      "silver_discount": category.silverDiscount,
      "gold_discount": category.goldDiscount,
      "platinum_discount": category.platinumDiscount,
      "show_pos": category.showPos == true ? 1 : 0,
      "no_series_prefix": category.noSeriesPrefix,
      "prefix_format": category.prefixFormat,
    };

    try {
      dynamic response;
      if (category.id == null) {
        response = await PostRepository()
            .postRequest(path: GetRepository.category, body: body);
      } else {
        response = await PutRepository().putRequest(
            path: GetRepository.category, editId: category.id, body: body);
      }
      emit(state.copyWith(isLoading: false));
      if (response["status"] == "success") {
        emit(state.copyWith(
          message: response["message"],
          isLoading: false,
        ));
        fetchCategory();
      } else {
        emit(state.copyWith(message: 'Failed: ${response["message"]}'));
      }
    } catch (e) {
      emit(state.copyWith(message: 'Failed: $e'));
    }
  }

  Future<void> fetchCategory() async {
    emit(state.copyWith(isFetching: true));

    try {
      final response = await GetRepository().getRequest(
          path: GetRepository.category,
          additionalHeader: {"company-id": Config.companyInfo!.id});
      emit(state.copyWith(isFetching: false));
      if (response["status"] == "success") {
        List<dynamic> data = response["category_lists"];
        emit(state.copyWith(
          categoryList:
              data.map((json) => CategoryModel.fromJson(json)).toList(),
        ));
      } else {
        emit(state.copyWith(message: 'Failed to fetch data'));
      }
    } catch (e) {
      emit(state.copyWith(message: 'Failed: $e'));
    }
  }
}
