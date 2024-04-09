// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rastriya_solution_flutter/helper/nepali_calender_widget.dart';
import 'package:rastriya_solution_flutter/model/void_report_model.dart';
import 'package:rastriya_solution_flutter/pages/basic_reports/void_product/cubit/void_product_cubit.dart';
import 'package:rastriya_solution_flutter/shared/spacing.dart';
import 'package:rastriya_solution_flutter/shared/text_style.dart';
import 'package:rastriya_solution_flutter/widgets/box_widget.dart';
import 'package:rastriya_solution_flutter/widgets/data_table.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart' as picker;

class VoidProductListPage extends StatefulWidget {
  final bool? showDateFilter;
  const VoidProductListPage({
    Key? key,
    this.showDateFilter = false,
  }) : super(key: key);

  @override
  State<VoidProductListPage> createState() => _VoidProductListPageState();
}

class _VoidProductListPageState extends State<VoidProductListPage> {
  picker.NepaliDateTime fromDate = picker.NepaliDateTime.now();
  picker.NepaliDateTime toDate = picker.NepaliDateTime.now();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(
        Duration.zero,
        () => BlocProvider.of<VoidProductCubit>(context)
            .fetchVoidReport(fromDate: fromDate, toDate: toDate));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return BlocBuilder<VoidProductCubit, VoidProductState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: const CupertinoNavigationBarBackButton(),
            title: const Text("Cancel Products"),
          ),
          body: state.isLoading == true
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    verticalSpaceSmall,
                    widget.showDateFilter == true
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              horizontalSpaceTiny,
                              InkWell(
                                onTap: () async {
                                  fromDate = await nepaliCalender(
                                      context: context, initalDate: fromDate);
                                  setState(() {});
                                },
                                child: BoxWidget(
                                    width: width * 0.4,
                                    value: fromDate.toString().split(" ").first,
                                    label: "Start"),
                              ),
                              InkWell(
                                onTap: () async {
                                  toDate = await nepaliCalender(
                                      context: context, initalDate: toDate);
                                  setState(() {});
                                },
                                child: BoxWidget(
                                    width: width * 0.4,
                                    value: toDate.toString().split(" ").first,
                                    label: "End"),
                              ),
                              InkWell(
                                onTap: () => Future.delayed(
                                    Duration.zero,
                                    () => BlocProvider.of<VoidProductCubit>(
                                            context)
                                        .fetchVoidReport(
                                            fromDate: fromDate,
                                            toDate: toDate)),
                                child: SvgPicture.asset(
                                  "assets/svg/search.svg",
                                  width: 45,
                                  height: 45,
                                ),
                              ),
                              horizontalSpaceTiny,
                            ],
                          )
                        : const SizedBox.shrink(),
                    verticalSpaceSmall,
                    Expanded(
                      child: SingleChildScrollView(
                        child: CustomDataTable(
                            columnNames: const [
                              "Particulars",
                              "Qty",
                              "Amount",
                              "Cancel Reason",
                              "Authorized By"
                            ],
                            createRow: createRow(
                                context: context, data: state.voidReportList)),
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }

  List<DataRow>? createRow({
    required BuildContext context,
    required List<VoidReportModel>? data,
  }) {
    if (data!.isEmpty) {
      return null;
    }

    // Initialize variables to hold the totals
    int totalSalesQuantity = 0;
    double totalAmount = 0;

    // Calculate totals
    data.forEach((productInfo) {
      totalSalesQuantity += productInfo.qty ?? 0;
      totalAmount += productInfo.amount ?? 0.0;
    });

    // Create data rows for each product
    List<DataRow> rows = data.map((productInfo) {
      return DataRow(
        selected: false,
        cells: [
          DataCell(Text(productInfo.productName ?? "")),
          DataCell(Text(productInfo.qty.toString())),
          DataCell(Text(productInfo.amount!.toStringAsFixed(2))),
          DataCell(Text(productInfo.reason ?? "")),
          DataCell(Text(productInfo.userInfo?.username ?? "")),
        ],
        onSelectChanged: (value) {},
      );
    }).toList();

    // Add a row for displaying totals
    rows.add(DataRow(
        color:
            MaterialStateProperty.resolveWith((states) => Colors.blue.shade100),
        cells: [
          DataCell(Text(
            '',
            style: kSubtitleTextStyle,
          )),
          DataCell(Text(
            totalSalesQuantity.toStringAsFixed(2),
            style: kSubtitleTextStyle,
          )),
          DataCell(Text(
            totalAmount.toStringAsFixed(2),
            textAlign: TextAlign.end,
            style: kSubtitleTextStyle,
          )),
          DataCell(Text(
            '',
            style: kSubtitleTextStyle,
          )),
          DataCell(Text(
            '',
            style: kSubtitleTextStyle,
          )),
        ]));

    return rows;
  }
}
