import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rastriya_solution_flutter/constants/config.dart';
import 'package:rastriya_solution_flutter/data/repository/get_repository.dart';
import 'package:rastriya_solution_flutter/data/repository/post_repository.dart';
import 'package:rastriya_solution_flutter/data/repository/put_repository.dart';
import 'package:rastriya_solution_flutter/model/category_model.dart';
import 'package:rastriya_solution_flutter/model/product_model.dart';
import 'package:rastriya_solution_flutter/model/unit_model.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductState.initial()) {
    Future.delayed(Duration.zero, () {
      fetchProduct();
      fetchCategory();
      fetchUnit();
    });
  }

  Future<void> saveProduct({required ProductModel product}) async {
    emit(state.copyWith(isLoading: true));

    final body = {
      "name": product.name,
      "base_unit": product.baseUnit,
      "product_group": product.productGroup,
      "vat_percent": product.vatPercent,
      "last_unit_cost": product.lastUnitCost,
      "last_unit_price": product.lastUnitPrice,
      "barcode1": product.barcode1,
      "remarks1": product.remarks1,
      "mrp": product.mrp,
      "profit_percent": product.profitPercent,
      "product_detail": product.productDetail,
      "is_pos": product.isPos,
      "blocked": product.blocked,
      "discountable": product.discountable,
      "inventory_item": product.inventoryItem,
      "sellable_item": product.sellableItem,
      "batch_lot": product.batchLot,
      "flat_discount": 0
    };
    print(body);

    try {
      dynamic response;
      if (product.id == null) {
        response = await PostRepository()
            .postRequest(path: GetRepository.product, body: body);
      } else {
        response = await PutRepository().putRequest(
            path: GetRepository.product, editId: product.id, body: body);
      }
      emit(state.copyWith(isLoading: false));
      if (response["status"] == "success") {
        emit(state.copyWith(
          message: response["message"],
          isLoading: false,
        ));
        fetchProduct();
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

  Future<void> fetchUnit() async {
    emit(state.copyWith(isFetching: true));

    try {
      final response = await GetRepository().getRequest(
          path: GetRepository.unit,
          additionalHeader: {"company-id": Config.companyInfo!.id});
      emit(state.copyWith(isFetching: false));
      if (response["status"] == "success") {
        List<dynamic> data = response["units"];
        emit(state.copyWith(
          unitList: data.map((json) => UnitModel.fromJson(json)).toList(),
        ));
      } else {
        emit(state.copyWith(message: 'Failed to fetch data'));
      }
    } catch (e) {
      emit(state.copyWith(message: 'Failed: $e'));
    }
  }
}
