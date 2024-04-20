import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rastriya_solution_flutter/helper/dialog_utility.dart';
import 'package:rastriya_solution_flutter/helper/toastification.dart';
import 'package:rastriya_solution_flutter/model/store_model.dart';
import 'package:rastriya_solution_flutter/model/table_model.dart';
import 'package:rastriya_solution_flutter/pages/pos_setup/table_setup/cubit/table_cubit.dart';
import 'package:rastriya_solution_flutter/shared/spacing.dart';
import 'package:rastriya_solution_flutter/shared/text_style.dart';
import 'package:rastriya_solution_flutter/widgets/data_table.dart';
import 'package:rastriya_solution_flutter/widgets/list_view_container.dart';
import 'package:rastriya_solution_flutter/widgets/mini_bottom_sheet.dart';
import 'package:rastriya_solution_flutter/widgets/shimmer.dart';
import 'package:toastification/toastification.dart';

class TableSetupList extends StatefulWidget {
  const TableSetupList({Key? key}) : super(key: key);

  @override
  State<TableSetupList> createState() => _TableSetupListState();
}

class _TableSetupListState extends State<TableSetupList> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      BlocProvider.of<TableCubit>(context).fetchTables();
      BlocProvider.of<TableCubit>(context).fetchStore();
    });
  }

  String? storeId;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TableCubit, TableState>(listener: (context, state) {
      if (state.isLoading == true) {
        Future.delayed(
            Duration.zero, () => DialogUtils.showProcessingDialog(context));
      } else if (state.isLoading == false) {
        Navigator.of(context).pop();
      } else if (state.message != null) {
        showToastification(
            context: context,
            message: state.message!,
            toastificationType: state.message!.contains("Failed")
                ? ToastificationType.error
                : ToastificationType.success);
      }
    }, builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Table"),
          leading: const CupertinoNavigationBarBackButton(),
          actions: [
            MiniBottomSheet(
              avatarInitials: "S",
              hintText: "",
              label: "Store",
              value: storeId,
              onChanged: (String? value) {
                setState(() {
                  storeId = value;
                });
              },
              items: state.storeList.map((StoreModel store) {
                return DropdownMenuItem<String>(
                  value: store.id.toString(),
                  child: Text(store.name ?? ""),
                );
              }).toList(),
            ),
            horizontalSpaceTiny
          ],
        ),
        body: state.isFetching == true
            ? const CustomShimmer()
            : ListView.builder(
                itemCount: state.tableList.length,
                itemBuilder: (BuildContext context, int index) {
                  TableModel table = state.tableList[index];
                  if (storeId == null || storeId == table.section?.storeId) {
                    return ListViewContainer(
                        child: ListTile(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          "/edit_table",
                          arguments: table,
                        );
                      },
                      leading: CircleAvatar(
                          child: Text(
                              table.tableName.toUpperCase().substring(0, 1))),
                      title: Text(table.tableName),
                      subtitle: Text(table.section?.sectionName ?? ""),
                      trailing: Text(table.availability),
                    ));
                  }
                }),
        // body: CustomDataTable(columnNames: const [
        //   "Name",
        //   "Status",
        //   "Availability",
        //   "Capacity",
        // ], createRow: createRow((state.tableList))),
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
