part of 'product_cubit.dart';

class ProductState {
  final List<CategoryModel> categoryList;
  final List<ProductModel> productList;
  final List<UnitModel> unitList;
  final bool? isLoading;
  final bool? isFetching;
  final String? message;

  ProductState(
      {required this.categoryList,
      required this.productList,
      required this.unitList,
      this.isLoading,
      this.isFetching,
      this.message});

  factory ProductState.initial() {
    return ProductState(
      categoryList: [],
      productList: [],
      unitList: [],
    );
  }

  ProductState copyWith({
    List<CategoryModel>? categoryList,
    List<ProductModel>? productList,
    List<UnitModel>? unitList,
    bool? isLoading,
    bool? isFetching,
    String? message,
  }) {
    return ProductState(
      categoryList: categoryList ?? this.categoryList,
      productList: productList ?? this.productList,
      unitList: unitList ?? this.unitList,
      isLoading: isLoading,
      isFetching: isFetching,
      message: message,
    );
  }
}
