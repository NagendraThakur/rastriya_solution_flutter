part of 'category_cubit.dart';

class CategoryState {
  final List<CategoryModel> categoryList;
  final bool? isLoading;
  final bool? isFetching;
  final String? message;

  CategoryState(
      {required this.categoryList,
      this.isFetching,
      this.isLoading,
      this.message});

  factory CategoryState.initial() {
    return CategoryState(categoryList: []);
  }

  CategoryState copyWith({
    List<CategoryModel>? categoryList,
    bool? isLoading,
    bool? isFetching,
    String? message,
  }) {
    return CategoryState(
      categoryList: categoryList ?? this.categoryList,
      isLoading: isLoading,
      isFetching: isFetching,
      message: message,
    );
  }
}
