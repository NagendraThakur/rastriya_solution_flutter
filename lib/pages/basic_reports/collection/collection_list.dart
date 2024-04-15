import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart' as picker;
import 'package:rastriya_solution_flutter/helper/nepali_calender_widget.dart';
import 'package:rastriya_solution_flutter/pages/basic_reports/collection/cubit/collection_cubit.dart';
import 'package:rastriya_solution_flutter/shared/spacing.dart';
import 'package:rastriya_solution_flutter/widgets/box_widget.dart';
import 'package:rastriya_solution_flutter/widgets/data_table.dart';

class CollectionListPage extends StatefulWidget {
  final bool? showDateFilter;
  const CollectionListPage({
    super.key,
    this.showDateFilter = false,
  });

  @override
  State<CollectionListPage> createState() => _CollectionListPageState();
}

class _CollectionListPageState extends State<CollectionListPage> {
  picker.NepaliDateTime fromDate = picker.NepaliDateTime.now();
  picker.NepaliDateTime toDate = picker.NepaliDateTime.now();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CollectionCubit>(context)
        .fetchCollectionReport(fromDate: fromDate, toDate: toDate);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return BlocBuilder<CollectionCubit, CollectionState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: const CupertinoNavigationBarBackButton(),
            title: const Text("Collection Report"),
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
                                label: "From"),
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
                                label: "To"),
                          ),
                          InkWell(
                            onTap: () => Future.delayed(
                                Duration.zero,
                                () => BlocProvider.of<CollectionCubit>(context)
                                    .fetchCollectionReport(
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
                          columnNames: const ["Mode", "Amount"],
                          createRow: _buildRows(state.report, width),
                        ),
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }

  List<DataRow>? _buildRows(Map<String, dynamic>? report, double width) {
    if (report == null || report.isEmpty) {
      return null;
    }

    List<DataRow> rows = [];
    double total = 0.0;

    report?.forEach((storeKey, storeValue) {
      if (storeValue is Map<String, dynamic>) {
        storeValue.forEach((counterKey, counterValue) {
          if (counterValue is Map<String, dynamic>) {
            counterValue.forEach((key, value) {
              total += double.parse(value.toString());
              rows.add(DataRow(cells: [
                DataCell(Text(key)),
                DataCell(
                    Text(double.parse(value.toString()).toStringAsFixed(2))),
              ]));
            });
          }
        });
      }
    });

    // Add row for total
    rows.add(DataRow(cells: [
      DataCell(SizedBox(width: width * 0.35, child: const Text("Total"))),
      DataCell(
          SizedBox(width: width * 0.35, child: Text(total.toStringAsFixed(2)))),
    ]));

    return rows;
  }
}
