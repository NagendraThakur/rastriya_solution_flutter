part of 'category_cubit.dart';

class CategoryState {
  final List<CategoryModel> categoryList;
  final List<PrintStationModel> printStationList;
  final bool? isLoading;
  final bool? isFetching;
  final String? message;

  CategoryState(
      {required this.categoryList,
      required this.printStationList,
      this.isFetching,
      this.isLoading,
      this.message});

  factory CategoryState.initial() {
    return CategoryState(
      categoryList: [],
      printStationList: [],
    );
  }

  CategoryState copyWith({
    List<CategoryModel>? categoryList,
    List<PrintStationModel>? printStationList,
    bool? isLoading,
    bool? isFetching,
    String? message,
  }) {
    return CategoryState(
      categoryList: categoryList ?? this.categoryList,
      printStationList: printStationList ?? this.printStationList,
      isLoading: isLoading,
      isFetching: isFetching,
      message: message,
    );
  }
}
