import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rastriya_solution_flutter/helper/dialog_utility.dart';
import 'package:rastriya_solution_flutter/helper/toastification.dart';
import 'package:rastriya_solution_flutter/model/batch_model.dart';
import 'package:rastriya_solution_flutter/pages/inventory/batch/cubit/batch_cubit.dart';
import 'package:rastriya_solution_flutter/shared/text_style.dart';
import 'package:rastriya_solution_flutter/widgets/data_table.dart';
import 'package:rastriya_solution_flutter/widgets/list_view_container.dart';
import 'package:rastriya_solution_flutter/widgets/shimmer.dart';
import 'package:toastification/toastification.dart';

class BatchListScreen extends StatefulWidget {
  const BatchListScreen({super.key});

  @override
  State<BatchListScreen> createState() => _BatchListScreenState();
}

class _BatchListScreenState extends State<BatchListScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      BlocProvider.of<BatchCubit>(context).fetchBatch();
      BlocProvider.of<BatchCubit>(context).fetchProduct();
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return BlocConsumer<BatchCubit, BatchState>(
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
            title: const Text("Batch"),
          ),
          body: state.isFetching == true
              ? const CustomShimmer()
              : ListView.builder(
                  itemCount: state.batchList.length,
                  itemBuilder: (BuildContext context, int index) {
                    BatchModel batch = state.batchList[index];
                    return ListViewContainer(
                        child: ListTile(
                      onTap: () {
                        Navigator.of(context).pushNamed("/edit_batch",
                            arguments: {
                              "productList": state.productList,
                              "batch": batch
                            });
                      },
                      leading: const CircleAvatar(child: Text("B")),
                      title: Text(batch.batchName.toUpperCase()),
                      subtitle: Text(batch.productName ?? ""),
                      trailing:
                          Text("Rs ${batch.unitPrice.toStringAsFixed(2)}"),
                    ));
                  }),
          // : SingleChildScrollView(
          //     child: CustomDataTable(columnNames: const [
          //       "Batch Name",
          //       "Selling Price",
          //       "Product Name"
          //     ], createRow: createRow(data: state.batchList, state: state)),
          //   ),
          floatingActionButton: FloatingActionButton.extended(
              icon: const Icon(CupertinoIcons.add),
              label: Text(
                "Add Batch",
                style: kSubtitleRegularTextStyle,
              ),
              onPressed: () => Navigator.of(context).pushNamed("/edit_batch",
                  arguments: {"productList": state.productList})),
        );
      },
    );
  }

  // List<DataRow>? createRow(
  //     {required List<BatchModel>? data, required BatchState state}) {
  //   if (data!.isEmpty) {
  //     return null;
  //   }

  //   return data.map((BatchModel item) {
  //     return DataRow(
  //       selected: false,
  //       cells: [
  //         DataCell(Text(item.batchName)),
  //         DataCell(Text(item.unitPrice.toStringAsFixed(2))),
  //         DataCell(Text(item.productName!)),
  //       ],
  //       onSelectChanged: (value) {
  //         Navigator.of(context).pushNamed("/edit_batch",
  //             arguments: {"productList": state.productList, "batch": item});
  //       },
  //     );
  //   }).toList();
  // }
}
