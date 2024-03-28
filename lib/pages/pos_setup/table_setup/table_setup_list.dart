import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rastriya_solution_flutter/helper/dialog_utility.dart';
import 'package:rastriya_solution_flutter/model/table_model.dart';
import 'package:rastriya_solution_flutter/pages/pos_setup/table_setup/cubit/table_cubit.dart';
import 'package:rastriya_solution_flutter/shared/text_style.dart';
import 'package:rastriya_solution_flutter/widgets/data_table.dart';

class TableSetupList extends StatefulWidget {
  const TableSetupList({Key? key}) : super(key: key);

  @override
  State<TableSetupList> createState() => _TableSetupListState();
}

class _TableSetupListState extends State<TableSetupList> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero,
        () => BlocProvider.of<TableCubit>(context).fetchTables());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TableCubit, TableState>(listener: (context, state) {
      if (state.isLoading == true) {
        Future.delayed(
            Duration.zero, () => DialogUtils.showProcessingDialog(context));
      } else if (state.isLoading == false) {
        Navigator.of(context).pop();
      }
    }, builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Table"),
          elevation: 1,
          leading: const CloseButton(),
        ),
        body: CustomDataTable(columnNames: const [
          "Name",
          "Status",
          "Availability",
          "Capacity",
        ], createRow: createRow((state.tableList))),
        floatingActionButton: FloatingActionButton.extended(
            icon: const Icon(CupertinoIcons.add),
            label: Text(
              "Add Table",
              style: kSubtitleRegularTextStyle,
            ),
            onPressed: () => Navigator.of(context).pushNamed("/edit_table")),
      );
    });
  }

  List<DataRow> createRow(List<TableModel> data) {
    return data.map((TableModel item) {
      return DataRow(
        selected: false,
        cells: [
          DataCell(Text(item.tableName)),
          DataCell(Text(item.status == 1 ? "Yes" : "No")),
          DataCell(Text(item.availability)),
          DataCell(Text(item.guestCapacity.toString())),
        ],
        onSelectChanged: (value) async {
          Navigator.of(context).pushNamed(
            "/edit_table",
            arguments: item,
          );
        },
      );
    }).toList();
  }
}
