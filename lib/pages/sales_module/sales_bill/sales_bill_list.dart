// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart' as picker;
import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:rastriya_solution_flutter/helper/nepali_calender_widget.dart';
import 'package:rastriya_solution_flutter/model/bill_model.dart';
import 'package:rastriya_solution_flutter/pages/sales_module/sales_bill/cubit/sales_bill_cubit.dart';
import 'package:rastriya_solution_flutter/shared/spacing.dart';
import 'package:rastriya_solution_flutter/shared/text_style.dart';
import 'package:rastriya_solution_flutter/widgets/border_container.dart';
import 'package:rastriya_solution_flutter/widgets/box_widget.dart';
import 'package:rastriya_solution_flutter/widgets/summary_widget.dart';
import 'package:rastriya_solution_flutter/widgets/textfield.dart';

class SalesBillListScreen extends StatefulWidget {
  final bool? showSummary;
  const SalesBillListScreen({
    Key? key,
    this.showSummary = false,
  }) : super(key: key);

  @override
  State<SalesBillListScreen> createState() => _SalesBillListScreenState();
}

class _SalesBillListScreenState extends State<SalesBillListScreen> {
  picker.NepaliDateTime fromDate = picker.NepaliDateTime.now();
  picker.NepaliDateTime toDate = picker.NepaliDateTime.now();
  @override
  void initState() {
    super.initState();
    Future.delayed(
        Duration.zero,
        () => BlocProvider.of<SalesBillCubit>(context)
            .fetchSalesBill(fromDate: fromDate, toDate: toDate));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return BlocBuilder<SalesBillCubit, SalesBillState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: const CupertinoNavigationBarBackButton(),
            title: const Text("Sales Bill"),
          ),
          body: Column(
            children: [
              verticalSpaceSmall,
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
                        () => BlocProvider.of<SalesBillCubit>(context)
                            .fetchSalesBill(
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
              CustomTextField(
                hintText: "Search Sales Bill",
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                onChanged: (String? value) {
                  if (value != null) {
                    BlocProvider.of<SalesBillCubit>(context)
                        .salesBillSearch(value: value);
                  }
                },
              ),
              widget.showSummary == true
                  ? BorderContainer(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Summary",
                            style: kHeading3TextStyle,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              summaryWidth(
                                  value: state.salesBillSearchResult?.length
                                          .toString() ??
                                      "0",
                                  label: "Sale Bills"),
                              summaryWidth(
                                  value: state.totalDiscountAmount
                                      .toStringAsFixed(2),
                                  label: "Discounts Amt"),
                              summaryWidth(
                                  value:
                                      state.totalBillsAmount.toStringAsFixed(2),
                                  label: "Bills Amt"),
                            ],
                          )
                        ],
                      ))
                  : const SizedBox.shrink(),
              state.salesBillSearchResult == null
                  ? const Center(child: CircularProgressIndicator())
                  : Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: state.salesBillSearchResult?.length,
                          itemBuilder: (BuildContext context, int index) {
                            BillModel bill =
                                state.salesBillSearchResult![index];
                            return BorderContainer(
                              outerPadding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: ListTile(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                      "/edit_sales_bill",
                                      arguments: bill);
                                },
                                leading: const CircleAvatar(
                                  child: Text("SB"),
                                ),
                                title: Text(bill.billNo),
                                subtitle: Text(bill.billDate!
                                    .toNepaliDateTime()
                                    .toString()
                                    .split(" ")
                                    .first),
                                trailing:
                                    Text(bill.billAmount!.toStringAsFixed(2)),
                              ),
                            );
                          }),
                    ),
            ],
          ),
        );
      },
    );
  }
}
