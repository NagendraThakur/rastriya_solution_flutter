part of 'top_selling_products_cubit.dart';

class TopSellingProductsState {
  final List<TopSellingProductsModel> topSellingProductsList;
  final bool? isLoading;
  final bool? message;

  TopSellingProductsState(
      {required this.topSellingProductsList, this.isLoading, this.message});

  factory TopSellingProductsState.initial() {
    return TopSellingProductsState(topSellingProductsList: []);
  }

  TopSellingProductsState copyWith({
    List<TopSellingProductsModel>? topSellingProductsList,
    bool? isLoading,
    bool? message,
  }) {
    return TopSellingProductsState(
      topSellingProductsList:
          topSellingProductsList ?? this.topSellingProductsList,
      isLoading: isLoading ?? this.isLoading,
      message: message ?? this.message,
    );
  }
}
