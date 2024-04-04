// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'pos_cubit.dart';

class PosState {
  final bool? isLoading;
  final String? message;
  final String? toastMessage;
  // final bool? isFetchingTable;
  // final bool? isFetchingProduct;
  final List<TableModel> tableList;
  final List<SectionModel> sectionList;
  final List<ProductModel> productList;
  final Map<String, List<ProductModel>>? categoryProductList;

  PosState({
    this.isLoading,
    this.message,
    this.toastMessage,
    // this.isFetchingTable,
    // this.isFetchingProduct,
    required this.tableList,
    required this.sectionList,
    required this.productList,
    this.categoryProductList,
  });

  factory PosState.initial() {
    return PosState(
      tableList: [],
      sectionList: [],
      productList: [],
    );
  }

  PosState copyWith({
    bool? isLoading,
    String? message,
    String? toastMessage,
    List<TableModel>? tableList,
    List<SectionModel>? sectionList,
    List<ProductModel>? productList,
    Map<String, List<ProductModel>>? categoryProductList,
  }) {
    return PosState(
      isLoading: isLoading,
      message: message,
      toastMessage: toastMessage,
      tableList: tableList ?? this.tableList,
      sectionList: sectionList ?? this.sectionList,
      productList: productList ?? this.productList,
      categoryProductList: categoryProductList ?? this.categoryProductList,
    );
  }
}
