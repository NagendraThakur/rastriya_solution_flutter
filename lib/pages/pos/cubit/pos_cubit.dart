import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:rastriya_solution_flutter/constants/config.dart';
import 'package:rastriya_solution_flutter/data/repository/get_repository.dart';
import 'package:rastriya_solution_flutter/model/category_model.dart';
import 'package:rastriya_solution_flutter/model/product_model.dart';
import 'package:rastriya_solution_flutter/model/section_model.dart';
import 'package:rastriya_solution_flutter/model/table_model.dart';

part 'pos_state.dart';

class PosCubit extends Cubit<PosState> {
  PosCubit() : super(PosState.initial());

  void assignProductList({required List<ProductModel> productList}) {
    emit(state.copyWith(productList: productList));
  }

  void fetchCategoryProduct() async {
    try {
      final response = await GetRepository().getRequest(
          path: GetRepository.product,
          additionalHeader: {"company-id": Config.companyInfo!.id},
          queryParameters: {"blocked": 0, "sellable_item": 1});
      if (response["status"] == "success") {
        List<dynamic> data = response["data"];
        Map<String, List<ProductModel>> categoryList = {};
        List<ProductModel> productList = [];

        // Group data based on categoryName
        for (var json in data) {
          ProductModel product = ProductModel.fromJson(json);
          String categoryName = product.categoryName!;
          if (!categoryList.containsKey(categoryName)) {
            categoryList[categoryName] = [];
          }
          categoryList[categoryName]!.add(product);
        }
        if (categoryList.isNotEmpty) {
          productList = categoryList.values.elementAt(0);
        }

        emit(state.copyWith(
            categoryProductList: categoryList, productList: productList));
      } else {
        emit(state.copyWith(message: 'Failed to fetch data'));
      }
    } catch (e) {
      emit(state.copyWith(message: 'Failed: $e'));
    }
  }

  Future<void> fetchTables() async {
    emit(state.copyWith(tableList: []));

    try {
      final response = await GetRepository().getRequest(
          path: GetRepository.table,
          additionalHeader: {"company-id": Config.companyInfo!.id});

      if (response["status"] == "success") {
        List<dynamic> tableList = response["data"];
        emit(state.copyWith(
          tableList:
              tableList.map((json) => TableModel.fromJson(json)).toList(),
        ));
      } else {
        emit(state.copyWith(message: 'Failed to fetch data'));
      }
    } catch (e) {
      emit(state.copyWith(message: 'Failed: $e'));
    }
  }

  Future<void> fetchSection() async {
    try {
      final response = await GetRepository().getRequest(
          path: GetRepository.section,
          additionalHeader: {"company-id": Config.companyInfo!.id});

      if (response["status"] == "success") {
        List<dynamic> sectionList = response["data"];
        emit(state.copyWith(
          sectionList:
              sectionList.map((json) => SectionModel.fromJson(json)).toList(),
        ));
      } else {
        emit(state.copyWith(message: 'Failed to fetch data'));
      }
    } catch (e) {
      emit(state.copyWith(message: 'Error: $e'));
    }
  }
}
