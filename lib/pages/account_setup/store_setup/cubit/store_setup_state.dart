part of 'store_setup_cubit.dart';

class StoreSetupState {
  final List<StoreModel> storeList;
  final bool? isLoading;
  final String? message;
  final bool? isFetching;

  StoreSetupState(
      {required this.storeList, this.isFetching, this.isLoading, this.message});

  factory StoreSetupState.initial() {
    return StoreSetupState(storeList: []);
  }

  StoreSetupState copyWith({
    List<StoreModel>? storeList,
    bool? isLoading,
    bool? isFetching,
    String? message,
  }) {
    return StoreSetupState(
      storeList: storeList ?? this.storeList,
      isLoading: isLoading,
      message: message,
      isFetching: isFetching,
    );
  }
}
