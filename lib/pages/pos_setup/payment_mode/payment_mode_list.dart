import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rastriya_solution_flutter/helper/dialog_utility.dart';
import 'package:rastriya_solution_flutter/helper/toastification.dart';
import 'package:rastriya_solution_flutter/model/payment_mode_model.dart';
import 'package:rastriya_solution_flutter/pages/pos_setup/payment_mode/cubit/payment_mode_cubit.dart';
import 'package:rastriya_solution_flutter/shared/text_style.dart';
import 'package:rastriya_solution_flutter/widgets/data_table.dart';
import 'package:rastriya_solution_flutter/widgets/list_view_container.dart';
import 'package:rastriya_solution_flutter/widgets/shimmer.dart';
import 'package:toastification/toastification.dart';

class PaymentModeListScreen extends StatefulWidget {
  const PaymentModeListScreen({super.key});

  @override
  State<PaymentModeListScreen> createState() => _PaymentModeListScreenState();
}

class _PaymentModeListScreenState extends State<PaymentModeListScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      BlocProvider.of<PaymentModeCubit>(context).fetchPaymentMode();
      BlocProvider.of<PaymentModeCubit>(context).fetchLedgers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentModeCubit, PaymentModeState>(
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
          title: const Text("Payment Mode"),
          leading: const CupertinoNavigationBarBackButton(),
        ),
        body: state.isFetching == true
            ? const CustomShimmer()
            : ListView.builder(
                itemCount: state.paymentModeList.length,
                itemBuilder: (BuildContext context, int index) {
                  PaymentModeModel paymentMode = state.paymentModeList[index];
                  return ListViewContainer(
                    child: ListTile(
                      onTap: () {
                        Navigator.of(context).pushNamed("/edit_payment_mode",
                            arguments: paymentMode);
                      },
                      leading: CircleAvatar(
                          child: Text(
                              paymentMode.name.toUpperCase().substring(0, 1))),
                      title: Text(paymentMode.name),
                      subtitle: Text(paymentMode.ledgerName ?? ""),
                      trailing: Text(paymentMode.type),
                    ),
                  );
                }),
        // : CustomDataTable(
        //     columnNames: const ["Name", "Status", "Type", "Ledger"],
        //     createRow: paymentModeRow(
        //         context: context, data: state.paymentModeList)),
        floatingActionButton: FloatingActionButton.extended(
            icon: const Icon(CupertinoIcons.add),
            label: Text(
              "Add Payment Mode",
              style: kSubtitleRegularTextStyle,
            ),
            onPressed: () => Navigator.of(context).pushNamed(
                  "/edit_payment_mode",
                )),
      );
    });
  }

  List<DataRow> paymentModeRow({
    required BuildContext context,
    required List<PaymentModeModel> data,
  }) {
    return data.map((paymentMode) {
      return DataRow(
        selected: false,
        cells: [
          DataCell(Text(paymentMode.name)),
          DataCell(Text(paymentMode.status ? "True" : "False")),
          DataCell(Text(paymentMode.type)),
          DataCell(Text(paymentMode.ledgerName ?? "N/A")),
        ],
        onSelectChanged: (value) async {
          // i want to send two agrument paymentMode and ledger

          Navigator.of(context)
              .pushNamed("/edit_payment_mode", arguments: paymentMode);
        },
      );
    }).toList();
  }
}
