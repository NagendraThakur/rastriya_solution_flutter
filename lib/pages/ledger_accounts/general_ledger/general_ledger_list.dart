import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rastriya_solution_flutter/helper/dialog_utility.dart';
import 'package:rastriya_solution_flutter/helper/toastification.dart';
import 'package:rastriya_solution_flutter/model/ledger_model.dart';
import 'package:rastriya_solution_flutter/pages/ledger_accounts/cubit/ledger_cubit.dart';
import 'package:rastriya_solution_flutter/shared/text_style.dart';
import 'package:rastriya_solution_flutter/widgets/data_table.dart';
import 'package:rastriya_solution_flutter/widgets/shimmer.dart';
import 'package:toastification/toastification.dart';

class GeneralLedgerList extends StatefulWidget {
  const GeneralLedgerList({super.key});

  @override
  State<GeneralLedgerList> createState() => _GeneralLedgerListState();
}

class _GeneralLedgerListState extends State<GeneralLedgerList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(
        Duration.zero,
        () => BlocProvider.of<LedgerCubit>(context)
            .fetchLedger(ledgerTypeInitial: "g"));
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
            title: const Text("General Ledger"),
          ),
          body: state.isFetching == true
              ? const CustomShimmer()
              : SingleChildScrollView(
                  child: CustomDataTable(columnNames: const [
                    "Ledger Name",
                    "Trail Balance",
                    "Type",
                    "Cash",
                    "Credit"
                  ], createRow: createRow(data: state.ledgerList)),
                ),
          floatingActionButton: FloatingActionButton.extended(
              icon: const Icon(CupertinoIcons.add),
              label: Text(
                "Add Vendor",
                style: kSubtitleRegularTextStyle,
              ),
              onPressed: () => Navigator.of(context).pushNamed("/edit_vendor")),
        );
      },
    );
  }

  List<DataRow>? createRow({required List<LedgerModel>? data}) {
    if (data!.isEmpty) {
      return null;
    }

    return data.map((LedgerModel ledger) {
      return DataRow(
        selected: false,
        cells: [
          DataCell(Text(ledger.name)),
          DataCell(Text(ledger.trialGroupData?.name ?? "")),
          DataCell(Text(ledger.trialGroupData?.bsPl ?? "")),
          DataCell(Text(ledger.bank == "1" ? "Yes" : "No")),
          DataCell(Text(ledger.cash == "1" ? "Yes" : "No")),
        ],
        onSelectChanged: (value) {
          Navigator.of(context).pushNamed("/edit_vendor", arguments: ledger);
        },
      );
    }).toList();
  }
}
