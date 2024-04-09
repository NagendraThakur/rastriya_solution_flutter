import 'package:flutter/material.dart';
import 'package:rastriya_solution_flutter/shared/text_style.dart';

class CustomDataTable extends StatelessWidget {
  final List<String> columnNames;
  final List<DataRow>? createRow;

  CustomDataTable({
    required this.columnNames,
    required this.createRow,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        showCheckboxColumn: false,
        headingRowHeight: 40,
        headingRowColor: MaterialStateProperty.resolveWith(
            (states) => Colors.blueGrey.shade200),
        headingTextStyle: kSubtitleRegularTextStyle,
        dataRowHeight: 40,
        dataTextStyle: kSubtitleRegularTextStyle,
        border: TableBorder.symmetric(
          outside: const BorderSide(),
        ),
        columns: _buildColumns(columnNames),
        rows: createRow ?? emptyRow(columnNames: columnNames),
      ),
    );
  }

  List<DataRow> emptyRow({required List<String> columnNames}) {
    return [
      DataRow(
        cells: columnNames.map((column) {
          return const DataCell(
            Text(""),
          );
        }).toList(),
      ),
    ];
  }

  List<DataColumn> _buildColumns(List<String> columnNames) {
    return columnNames.map((columnName) {
      return DataColumn(
        label: Text(
          columnName,
          style: kBodyRegularTextStyle1,
        ),
      );
    }).toList();
  }
}
