import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rastriya_solution_flutter/helper/dialog_utility.dart';
import 'package:rastriya_solution_flutter/helper/toastification.dart';
import 'package:rastriya_solution_flutter/model/terminal_model.dart';
import 'package:rastriya_solution_flutter/pages/account_setup/terminal/cubit/terminal_cubit.dart';
import 'package:rastriya_solution_flutter/shared/text_style.dart';
import 'package:rastriya_solution_flutter/widgets/data_table.dart';
import 'package:rastriya_solution_flutter/widgets/list_view_container.dart';
import 'package:rastriya_solution_flutter/widgets/shimmer.dart';
import 'package:toastification/toastification.dart';

class TerminalListScreen extends StatefulWidget {
  const TerminalListScreen({super.key});

  @override
  State<TerminalListScreen> createState() => _TerminalListScreenState();
}

class _TerminalListScreenState extends State<TerminalListScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero,
        () => BlocProvider.of<TerminalCubit>(context).fetchTerminal());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TerminalCubit, TerminalState>(
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
      },
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              leading: const CupertinoNavigationBarBackButton(),
              title: const Text("Terminals"),
            ),
            body: state.isFetching == true
                ? const CustomShimmer()
                : ListView.builder(
                    itemCount: state.terminalList.length,
                    itemBuilder: (BuildContext context, int index) {
                      TerminalModel terminal = state.terminalList[index];
                      return ListViewContainer(
                          child: ListTile(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            "/terminal_edit",
                            arguments: {
                              'terminal': terminal,
                              'storeList': state.storeList
                            },
                          );
                        },
                        leading: CircleAvatar(
                          child: Text(terminal.terminalName!
                              .substring(0, 1)
                              .toUpperCase()),
                        ),
                        title: Text(terminal.terminalName!.toUpperCase()),
                        subtitle: Text(terminal.storeName!.toUpperCase()),
                        trailing:
                            Text(terminal.billPrinterName?.toUpperCase() ?? ""),
                      ));
                    }),
            // : SingleChildScrollView(
            //     child: Padding(
            //       padding: const EdgeInsets.symmetric(horizontal: 10),
            //       child: CustomDataTable(columnNames: const [
            //         "Terminal Name",
            //         "Store Name",
            //         "Printer Name"
            //       ], createRow: createRow(state.terminalList, state)),
            //     ),
            //   ),
            floatingActionButton: FloatingActionButton.extended(
                icon: const Icon(CupertinoIcons.add),
                label: Text(
                  "Add Terminal",
                  style: kSubtitleRegularTextStyle,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    "/terminal_edit",
                    arguments: {'terminal': null, 'storeList': state.storeList},
                  );
                }));
      },
    );
  }

  // List<DataRow> createRow(List<TerminalModel> data, TerminalState state) {
  //   return data.map((TerminalModel item) {
  //     return DataRow(
  //       selected: false,
  //       cells: [
  //         DataCell(Text(
  //           item.terminalName ?? "-",
  //           style: kBodyRegularTextStyle,
  //         )),
  //         DataCell(Text(
  //           item.storeName ?? "-",
  //           style: kBodyRegularTextStyle,
  //         )),
  //         DataCell(Text(
  //           item.billPrinterName ?? "-",
  //           style: kBodyRegularTextStyle,
  //         )),
  //       ],
  //       onSelectChanged: (value) async {
  //         Navigator.of(context).pushNamed(
  //           "/terminal_edit",
  //           arguments: {'terminal': item, 'storeList': state.storeList},
  //         );
  //       },
  //     );
  //   }).toList();
  // }
}
