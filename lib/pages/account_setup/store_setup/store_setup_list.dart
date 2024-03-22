import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rastriya_solution_flutter/helper/dialog_utility.dart';
import 'package:rastriya_solution_flutter/helper/toastification.dart';
import 'package:rastriya_solution_flutter/model/store_model.dart';
import 'package:rastriya_solution_flutter/pages/account_setup/store_setup/cubit/store_setup_cubit.dart';
import 'package:rastriya_solution_flutter/pages/account_setup/terminal/cubit/terminal_cubit.dart';
import 'package:rastriya_solution_flutter/shared/text_style.dart';
import 'package:rastriya_solution_flutter/widgets/data_table.dart';
import 'package:rastriya_solution_flutter/widgets/shimmer.dart';
import 'package:toastification/toastification.dart';

class StoreSetupListScreen extends StatefulWidget {
  const StoreSetupListScreen({super.key});

  @override
  State<StoreSetupListScreen> createState() => _StoreSetupListScreenState();
}

class _StoreSetupListScreenState extends State<StoreSetupListScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero,
        () => BlocProvider.of<StoreSetupCubit>(context).fetchStore());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StoreSetupCubit, StoreSetupState>(
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
              title: const Text("Stores"),
            ),
            body: state.isFetching == true
                ? const CustomShimmer()
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: CustomDataTable(columnNames: const [
                        "Store Name",
                        "Store Address",
                        "Store Contact",
                        "Store Email",
                        "Owner Name",
                        "Owner Contact"
                      ], createRow: createRow(state.storeList)),
                    ),
                  ),
            floatingActionButton: FloatingActionButton.extended(
                icon: const Icon(CupertinoIcons.add),
                label: Text(
                  "Add Store",
                  style: kSubtitleRegularTextStyle,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    "/edit_store_setup",
                  );
                }));
      },
    );
  }

  List<DataRow> createRow(List<StoreModel> data) {
    return data.map((StoreModel item) {
      return DataRow(
        selected: false,
        cells: [
          DataCell(Text(
            item.name ?? "-",
            style: kBodyRegularTextStyle,
          )),
          DataCell(Text(
            item.address ?? "-",
            style: kBodyRegularTextStyle,
          )),
          DataCell(Text(
            item.phone ?? "-",
            style: kBodyRegularTextStyle,
          )),
          DataCell(Text(
            item.email ?? "-",
            style: kBodyRegularTextStyle,
          )),
          DataCell(Text(
            item.contactPersonName ?? "-",
            style: kBodyRegularTextStyle,
          )),
          DataCell(Text(
            item.contactPersonPhone ?? "-",
            style: kBodyRegularTextStyle,
          )),
        ],
        onSelectChanged: (value) async {
          Navigator.of(context).pushNamed(
            "/edit_store_setup",
          );
        },
      );
    }).toList();
  }
}
