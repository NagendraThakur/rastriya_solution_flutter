import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rastriya_solution_flutter/helper/nepali_calender_widget.dart';
import 'package:rastriya_solution_flutter/model/top_selling_products_model.dart';
import 'package:rastriya_solution_flutter/pages/basic_reports/top_selling_products/cubit/top_selling_products_cubit.dart';
import 'package:rastriya_solution_flutter/shared/spacing.dart';
import 'package:rastriya_solution_flutter/shared/text_style.dart';
import 'package:rastriya_solution_flutter/widgets/box_widget.dart';
import 'package:rastriya_solution_flutter/widgets/data_table.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart' as picker;

class TopSellingProductsListPage extends StatefulWidget {
  final bool? showDateFilter;
  const TopSellingProductsListPage({
    super.key,
    this.showDateFilter = false,
  });

  @override
  State<TopSellingProductsListPage> createState() =>
      _TopSellingProductsListPageState();
}

class _TopSellingProductsListPageState
    extends State<TopSellingProductsListPage> {
  picker.NepaliDateTime fromDate = picker.NepaliDateTime.now();
  picker.NepaliDateTime toDate = picker.NepaliDateTime.now();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<TopSellingProductsCubit>(context)
        .fetchTopSellingProducts(fromDate: fromDate, toDate: toDate);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return BlocBuilder<TopSellingProductsCubit, TopSellingProductsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: const CupertinoNavigationBarBackButton(),
            title: const Text("Top Selling Products"),
          ),
          body: state.isLoading == true
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    verticalSpaceSmall,
                    if (widget.showDateFilter == true)
                      Row(
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
                                () => BlocProvider.of<TopSellingProductsCubit>(
                                        context)
                                    .fetchTopSellingProducts(
                                        fromDate: fromDate, toDate: toDate)),
                            child: SvgPicture.asset(
                              "assets/svg/search.svg",
                              width: 45,
                              height: 45,
                            ),
                          ),
                          horizontalSpaceTiny,
                        ],
                      ),
                    verticalSpaceSmall,
                    Expanded(
                      child: SingleChildScrollView(
                        child: CustomDataTable(
                            columnNames: const [
                              "Particulars",
                              "Sales Qty",
                              "Sales Return Qty",
                              "Net Sales Qty",
                              // "Gross Amount",
                              // "Discount Amount",
                              "Amount",
                              // "Vat Amount",
                              // "Net Amount",
                            ],
                            createRow: createRow(
                                context: context,
                                data: state.topSellingProductsList)),
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
    required List<TopSellingProductsModel>? data,
  }) {
    if (data!.isEmpty) {
      return null;
    }

    // Initialize variables to hold the totals
    double totalSalesQuantity = 0;
    double totalSalesReturnQuantity = 0;
    double totalNetQuantity = 0;
    double totalAmount = 0;

    // Calculate totals
    data.forEach((productInfo) {
      totalSalesQuantity += productInfo.salesQuantity;
      totalSalesReturnQuantity += productInfo.salesReturnQuantity;
      totalNetQuantity += productInfo.netQuantity;
      totalAmount += productInfo.amount;
    });

    // Create data rows for each product
    List<DataRow> rows = data.map((productInfo) {
      return DataRow(
        selected: false,
        cells: [
          DataCell(Text(productInfo.productName)),
          DataCell(Text(productInfo.salesQuantity.toStringAsFixed(2))),
          DataCell(Text(productInfo.salesReturnQuantity.toStringAsFixed(2))),
          DataCell(Text(productInfo.netQuantity.toStringAsFixed(2))),
          DataCell(Text(productInfo.amount.toStringAsFixed(2))),
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
            'Total',
            style: kSubtitleTextStyle,
          )),
          DataCell(Text(
            totalSalesQuantity.toStringAsFixed(2),
            style: kSubtitleTextStyle,
          )),
          DataCell(Text(
            totalSalesReturnQuantity.toStringAsFixed(2),
            style: kSubtitleTextStyle,
          )),
          DataCell(Text(
            totalNetQuantity.toStringAsFixed(2),
            style: kSubtitleTextStyle,
          )),
          DataCell(Text(
            totalAmount.toStringAsFixed(2),
            textAlign: TextAlign.end,
            style: kSubtitleTextStyle,
          )),
        ]));

    return rows;
  }
}
