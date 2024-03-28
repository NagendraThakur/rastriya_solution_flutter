part of 'print_station_cubit.dart';

class PrintStationState {
  final List<PrintStationModel> printStationList;
  final bool? isLoading;
  final bool? isFetching;
  final String? message;

  PrintStationState({
    required this.printStationList,
    this.isLoading,
    this.isFetching,
    this.message,
  });

  factory PrintStationState.initial() {
    return PrintStationState(
      printStationList: [],
    );
  }

  PrintStationState copyWith({
    List<PrintStationModel>? printStationList,
    bool? isLoading,
    bool? isFetching,
    String? message,
  }) {
    return PrintStationState(
      printStationList: printStationList ?? this.printStationList,
      isLoading: isLoading,
      isFetching: isFetching,
      message: message,
    );
  }
}
