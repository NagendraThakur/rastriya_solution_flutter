// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'purchase_cubit.dart';

class PurchaseState {
  final bool? isLoading;
  final bool? isFetching;
  final String? message;
  final List<PurchaseModel> purchaseList;
  final List<PurchaseModel> filteredPurchaseList;
  final List<LedgerModel> venderList;
  final List<PurchaseLine> productList;
  final List<ProductModel> searchProductList;
  final double quantity;
  final double totalAmount;
  final double totalDiscountAmount;
  final double totalNetAmount;

  PurchaseState({
    this.isLoading,
    this.isFetching,
    this.message,
    required this.purchaseList,
    required this.filteredPurchaseList,
    required this.venderList,
    required this.productList,
    required this.searchProductList,
    required this.quantity,
    required this.totalAmount,
    required this.totalDiscountAmount,
    required this.totalNetAmount,
  });

  factory PurchaseState.initial() {
    return PurchaseState(
        purchaseList: [],
        filteredPurchaseList: [],
        venderList: [],
        productList: [],
        searchProductList: [],
        quantity: 0.0,
        totalAmount: 0.0,
        totalDiscountAmount: 0.0,
        totalNetAmount: 0.0);
  }

  PurchaseState copyWith({
    bool? isLoading,
    bool? isFetching,
    String? message,
    List<PurchaseModel>? purchaseList,
    List<PurchaseModel>? filteredPurchaseList,
    List<LedgerModel>? venderList,
    List<PurchaseLine>? productList,
    List<ProductModel>? searchProductList,
    double? quantity,
    double? totalAmount,
    double? totalDiscountAmount,
    double? totalNetAmount,
  }) {
    return PurchaseState(
      isLoading: isLoading,
      isFetching: isFetching,
      message: message,
      purchaseList: purchaseList ?? this.purchaseList,
      filteredPurchaseList: filteredPurchaseList ?? this.filteredPurchaseList,
      venderList: venderList ?? this.venderList,
      productList: productList ?? this.productList,
      searchProductList: searchProductList ?? this.searchProductList,
      quantity: quantity ?? this.quantity,
      totalAmount: totalAmount ?? this.totalAmount,
      totalDiscountAmount: totalDiscountAmount ?? this.totalDiscountAmount,
      totalNetAmount: totalNetAmount ?? this.totalNetAmount,
    );
  }
}
