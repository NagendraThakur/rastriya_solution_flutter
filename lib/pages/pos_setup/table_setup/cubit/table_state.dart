part of 'table_cubit.dart';

class TableState {
  final List<TableModel> tableList;
  final List<SectionModel> sectionList;
  final bool? isLoading;
  final bool? isFetching;
  final String? message;

  TableState({
    required this.tableList,
    required this.sectionList,
    this.isLoading,
    this.isFetching,
    this.message,
  });

  factory TableState.initial() {
    return TableState(tableList: [], sectionList: []);
  }

  TableState copyWith({
    List<TableModel>? tableList,
    List<SectionModel>? sectionList,
    bool? isLoading,
    bool? isFetching,
    String? message,
  }) {
    return TableState(
      tableList: tableList ?? this.tableList,
      sectionList: sectionList ?? this.sectionList,
      isLoading: isLoading,
      isFetching: isFetching,
      message: message ?? this.message,
    );
  }
}
