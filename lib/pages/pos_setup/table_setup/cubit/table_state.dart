part of 'table_cubit.dart';

class TableState {
  final List<TableModel> tableList;
  final List<SectionModel> sectionList;
  final bool? isLoading;
  final String? message;

  TableState({
    required this.tableList,
    required this.sectionList,
    this.isLoading,
    this.message,
  });

  factory TableState.initial() {
    return TableState(tableList: [], sectionList: []);
  }

  TableState copyWith({
    List<TableModel>? tableList,
    List<SectionModel>? sectionList,
    bool? isLoading,
    String? message,
  }) {
    return TableState(
      tableList: tableList ?? this.tableList,
      sectionList: sectionList ?? this.sectionList,
      isLoading: isLoading,
      message: message ?? this.message,
    );
  }
}
