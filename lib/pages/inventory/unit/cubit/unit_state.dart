part of 'unit_cubit.dart';

class UnitState {
  final List<UnitModel>? unitList;
  final bool? isLoading;
  final bool? isFetching;
  final String? message;

  UnitState(
      {required this.unitList, this.isLoading, this.isFetching, this.message});

  factory UnitState.initial() {
    return UnitState(unitList: []);
  }

  UnitState copyWith({
    List<UnitModel>? unitList,
    bool? isLoading,
    bool? isFetching,
    String? message,
  }) {
    return UnitState(
      unitList: unitList ?? this.unitList,
      isLoading: isLoading,
      isFetching: isFetching,
      message: message,
    );
  }
}
