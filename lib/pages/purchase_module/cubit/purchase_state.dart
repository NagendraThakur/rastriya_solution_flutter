// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'purchase_cubit.dart';

class PurchaseState {
  final bool? isLoading;
  final bool? isFetching;
  final String? message;
  final List<PurchaseModel> purchaseList;
  final List<PurchaseModel> filteredPurchaseList;
  final List<LedgerModel> venderList;

  PurchaseState({
    this.isLoading,
    this.isFetching,
    this.message,
    required this.purchaseList,
    required this.filteredPurchaseList,
    required this.venderList,
  });

  factory PurchaseState.initial() {
    return PurchaseState(
        purchaseList: [], filteredPurchaseList: [], venderList: []);
  }

  PurchaseState copyWith(
      {bool? isLoading,
      bool? isFetching,
      String? message,
      List<PurchaseModel>? purchaseList,
      List<PurchaseModel>? filteredPurchaseList,
      List<LedgerModel>? venderList}) {
    return PurchaseState(
      isLoading: isLoading,
      isFetching: isFetching,
      message: message,
      purchaseList: purchaseList ?? this.purchaseList,
      filteredPurchaseList: filteredPurchaseList ?? this.filteredPurchaseList,
      venderList: venderList ?? this.venderList,
    );
  }
}
