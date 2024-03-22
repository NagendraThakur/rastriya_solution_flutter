part of 'brand_cubit.dart';

class BrandState {
  final List<BrandModel>? brandList;
  final bool? isLoading;
  final bool? isFetching;
  final String? message;

  BrandState(
      {required this.brandList, this.isLoading, this.isFetching, this.message});

  factory BrandState.initial() {
    return BrandState(brandList: []);
  }

  BrandState copyWith({
    List<BrandModel>? brandList,
    bool? isLoading,
    bool? isFetching,
    String? message,
  }) {
    return BrandState(
      brandList: brandList ?? this.brandList,
      isLoading: isLoading,
      isFetching: isFetching,
      message: message,
    );
  }
}
