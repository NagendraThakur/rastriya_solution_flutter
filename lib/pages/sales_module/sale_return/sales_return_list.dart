import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:rastriya_solution_flutter/helper/nepali_calender_widget.dart';
import 'package:rastriya_solution_flutter/model/bill_model.dart';
import 'package:rastriya_solution_flutter/pages/sales_module/sale_return/cubit/sales_return_cubit.dart';
import 'package:rastriya_solution_flutter/pages/sales_module/sales_bill/cubit/sales_bill_cubit.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart' as picker;
import 'package:rastriya_solution_flutter/shared/spacing.dart';
import 'package:rastriya_solution_flutter/widgets/border_container.dart';
import 'package:rastriya_solution_flutter/widgets/box_widget.dart';
import 'package:rastriya_solution_flutter/widgets/textfield.dart';

class SalesReturnListScreen extends StatefulWidget {
  const SalesReturnListScreen({super.key});

  @override
  State<SalesReturnListScreen> createState() => _SalesReturnListScreenState();
}

class _SalesReturnListScreenState extends State<SalesReturnListScreen> {
  picker.NepaliDateTime fromDate = picker.NepaliDateTime.now();
  picker.NepaliDateTime toDate = picker.NepaliDateTime.now();
  @override
  void initState() {
    super.initState();
    Future.delayed(
        Duration.zero,
        () => BlocProvider.of<SalesReturnCubit>(context)
            .fetchSalesBill(fromDate: fromDate, toDate: toDate));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return BlocBuilder<SalesReturnCubit, SalesReturnState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: const CupertinoNavigationBarBackButton(),
            title: const Text("Sales Return"),
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
                        () => BlocProvider.of<SalesReturnCubit>(context)
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
                                      "/edit_sales_return",
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
