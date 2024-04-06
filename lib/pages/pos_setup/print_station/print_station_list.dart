import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rastriya_solution_flutter/helper/dialog_utility.dart';
import 'package:rastriya_solution_flutter/helper/toastification.dart';
import 'package:rastriya_solution_flutter/model/print_station_model.dart';
import 'package:rastriya_solution_flutter/pages/pos_setup/print_station/cubit/print_station_cubit.dart';
import 'package:rastriya_solution_flutter/shared/text_style.dart';
import 'package:rastriya_solution_flutter/widgets/data_table.dart';
import 'package:rastriya_solution_flutter/widgets/list_view_container.dart';
import 'package:rastriya_solution_flutter/widgets/shimmer.dart';
import 'package:toastification/toastification.dart';

class PrintStationList extends StatefulWidget {
  const PrintStationList({super.key});

  @override
  State<PrintStationList> createState() => _PrintStationListState();
}

class _PrintStationListState extends State<PrintStationList> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero,
        () => BlocProvider.of<PrintStationCubit>(context).fetchPrintStations());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PrintStationCubit, PrintStationState>(
        listener: (context, state) {
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
          title: const Text("Printers"),
          leading: const CupertinoNavigationBarBackButton(),
        ),
        body: state.isFetching == true
            ? const CustomShimmer()
            : ListView.builder(
                itemCount: state.printStationList.length,
                itemBuilder: (BuildContext context, int index) {
                  PrintStationModel printStation =
                      state.printStationList[index];
                  return ListViewContainer(
                    child: ListTile(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          "/edit_print_station",
                          arguments: printStation,
                        );
                      },
                      leading: CircleAvatar(
                        child: Text(printStation.printTitle!
                            .toUpperCase()
                            .substring(0, 1)),
                      ),
                      title: Text(printStation.printTitle!.toUpperCase()),
                      subtitle: Text(printStation.printerName ?? ""),
                    ),
                  );
                }),
        // : CustomDataTable(columnNames: const [
        //     "Print Title",
        //     "Printer Name",
        //     "Double Copy",
        //   ], createRow: createRow((state.printStationList))),
        floatingActionButton: FloatingActionButton.extended(
            icon: const Icon(CupertinoIcons.add),
            label: Text(
              "Add Print Station",
              style: kSubtitleRegularTextStyle,
            ),
            onPressed: () =>
                Navigator.of(context).pushNamed("/edit_print_station")),
      );
    });
  }

  List<DataRow> createRow(List<PrintStationModel> data) {
    return data.map((PrintStationModel item) {
      return DataRow(
        selected: false,
        cells: [
          DataCell(Text(item.printTitle ?? "-")),
          DataCell(Text(item.printerName ?? "-")),
          DataCell(Text(item.doubleCopy! == "1" ? "True" : "False")),
        ],
        onSelectChanged: (value) async {
          Navigator.of(context).pushNamed(
            "/edit_print_station",
            arguments: item,
          );
        },
      );
    }).toList();
  }
}
