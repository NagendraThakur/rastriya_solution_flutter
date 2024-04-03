import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rastriya_solution_flutter/helper/dialog_utility.dart';
import 'package:rastriya_solution_flutter/helper/toastification.dart';
import 'package:rastriya_solution_flutter/model/ledger_model.dart';
import 'package:rastriya_solution_flutter/pages/ledger_accounts/cubit/ledger_cubit.dart';
import 'package:rastriya_solution_flutter/shared/text_style.dart';
import 'package:rastriya_solution_flutter/widgets/data_table.dart';
import 'package:rastriya_solution_flutter/widgets/list_view_container.dart';
import 'package:rastriya_solution_flutter/widgets/shimmer.dart';
import 'package:toastification/toastification.dart';

class CustomerList extends StatefulWidget {
  const CustomerList({super.key});

  @override
  State<CustomerList> createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(
        Duration.zero,
        () => BlocProvider.of<LedgerCubit>(context)
            .fetchLedger(ledgerTypeInitial: "c"));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return BlocConsumer<LedgerCubit, LedgerState>(
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
            title: const Text("Customers"),
          ),
          body: state.isFetching == true
              ? const CustomShimmer()
              : ListView.builder(
                  itemCount: state.ledgerList!.length,
                  itemBuilder: (BuildContext context, int index) {
                    LedgerModel ledger = state.ledgerList![index];
                    return ListViewContainer(
                        child: ListTile(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed("/edit_customer", arguments: ledger);
                      },
                      leading: const CircleAvatar(child: Text("C")),
                      title: Text(ledger.name),
                      subtitle: ledger.billingPhone1 == null &&
                              ledger.billingEmail == null
                          ? null
                          : Text(
                              "${ledger.billingEmail ?? ""}${ledger.billingPhone1 ?? ""}"),
                    ));
                  }),
          // : SingleChildScrollView(
          //     child: CustomDataTable(
          //         columnNames: const ["Code", "Name", "Phone", "Email"],
          //         createRow: createRow(data: state.ledgerList)),
          //   ),
          floatingActionButton: FloatingActionButton.extended(
              icon: const Icon(CupertinoIcons.add),
              label: Text(
                "Add Customer",
                style: kSubtitleRegularTextStyle,
              ),
              onPressed: () =>
                  Navigator.of(context).pushNamed("/edit_customer")),
        );
      },
    );
  }

  // List<DataRow>? createRow({required List<LedgerModel>? data}) {
  //   if (data!.isEmpty) {
  //     return null;
  //   }

  //   return data.map((LedgerModel ledger) {
  //     return DataRow(
  //       selected: false,
  //       cells: [
  //         DataCell(Text(ledger.code ?? "-")),
  //         DataCell(Text(ledger.name)),
  //         DataCell(Text(ledger.billingPhone1 ?? "-")),
  //         DataCell(Text(ledger.billingEmail ?? "-")),
  //       ],
  //       onSelectChanged: (value) {
  //         Navigator.of(context).pushNamed("/edit_customer", arguments: ledger);
  //       },
  //     );
  //   }).toList();
  // }
}
