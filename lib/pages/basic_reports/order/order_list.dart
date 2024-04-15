import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rastriya_solution_flutter/model/order_report_model.dart';
import 'package:rastriya_solution_flutter/pages/basic_reports/order/cubit/order_cubit.dart';
import 'package:rastriya_solution_flutter/widgets/data_table.dart';

class OrderReportPage extends StatefulWidget {
  final bool? showDateFilter;
  const OrderReportPage({
    super.key,
    this.showDateFilter = false,
  });

  @override
  State<OrderReportPage> createState() => _OrderReportPageState();
}

class _OrderReportPageState extends State<OrderReportPage> {
  // picker.NepaliDateTime fromDate = picker.NepaliDateTime.now();
  // picker.NepaliDateTime toDate = picker.NepaliDateTime.now();
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero,
        () => BlocProvider.of<OrderCubit>(context).fetchOrderReport());
  }

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    return BlocBuilder<OrderCubit, OrderState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: const CloseButton(),
            title: const Text("Order Report"),
            elevation: 2,
          ),
          body: state.isLoading == true
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: CustomDataTable(
                      columnNames: const [
                        "Order Number",
                        "Order Date",
                        "Item Name",
                        "Quantity",
                        "Order Note",
                        "Status",
                        "Bill No",
                        "Table No",
                        "Void Reason",
                      ],
                      createRow: createRow(
                          context: context, data: state.orderReportList)),
                ),
        );
      },
    );
  }

  List<DataRow>? createRow(
      {required BuildContext context, required List<OrderReportModel>? data}) {
    if (data!.isEmpty) {
      return null;
    }

    return data.map((OrderReportModel order) {
      return DataRow(
        selected: false,
        cells: [
          DataCell(Text(order.orderNumber ?? "")),
          DataCell(Text(order.orderDate ?? "")),
          DataCell(Text(order.itemName ?? "")),
          DataCell(Text(order.quantity?.toStringAsFixed(2) ?? "")),
          DataCell(Text(order.orderNote ?? "")),
          DataCell(Text(order.status ?? "")),
          DataCell(Text(order.billNo ?? "")),
          DataCell(Text(order.tableNo ?? "")),
          DataCell(Text(order.voidReason ?? "")),
        ],
        onSelectChanged: (value) {},
      );
    }).toList();
  }
}
