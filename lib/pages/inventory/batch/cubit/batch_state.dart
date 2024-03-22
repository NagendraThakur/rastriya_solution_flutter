part of 'batch_cubit.dart';

class BatchState {
  final List<BatchModel> batchList;
  final List<ProductModel> productList;
  final bool? isLoading;
  final bool? isFetching;
  final String? message;

  BatchState(
      {required this.batchList,
      required this.productList,
      this.isLoading,
      this.isFetching,
      this.message});

  factory BatchState.initial() {
    return BatchState(batchList: [], productList: []);
  }

  BatchState copyWith({
    List<BatchModel>? batchList,
    List<ProductModel>? productList,
    bool? isLoading,
    bool? isFetching,
    String? message,
  }) {
    return BatchState(
      batchList: batchList ?? this.batchList,
      productList: productList ?? this.productList,
      isLoading: isLoading,
      isFetching: isFetching,
      message: message,
    );
  }
}
