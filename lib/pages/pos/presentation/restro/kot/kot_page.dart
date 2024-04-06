import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rastriya_solution_flutter/helper/dialog_utility.dart';
import 'package:rastriya_solution_flutter/helper/toastification.dart';
import 'package:rastriya_solution_flutter/model/sales_order_model.dart';
import 'package:rastriya_solution_flutter/pages/pos/cubit/pos_cubit.dart';
import 'package:rastriya_solution_flutter/pages/pos/presentation/restro/kot/portion/kot_widget.dart';
import 'package:rastriya_solution_flutter/shared/spacing.dart';
import 'package:rastriya_solution_flutter/shared/text_style.dart';
import 'package:rastriya_solution_flutter/widgets/button.dart';
import 'package:rastriya_solution_flutter/widgets/two_row_component.dart';
import 'package:toastification/toastification.dart';

class KotPage extends StatefulWidget {
  final OrderBillModel orderBill;
  const KotPage({
    Key? key,
    required this.orderBill,
  }) : super(key: key);

  @override
  State<KotPage> createState() => _KotPageState();
}

class _KotPageState extends State<KotPage> {
  List<OrderBillLineModel> orderBillList = [];
  List<OrderBillLineModel> notFiredList = [];
  List<OrderBillLineModel> firedList = [];

  @override
  void initState() {
    super.initState();
    orderBillList = widget.orderBill.orderBillLine;

    firedList = orderBillList.where((product) {
      if (product.fired == 1) {
        product.selected = false;
        return true;
      }
      return false;
    }).toList();
    notFiredList = orderBillList.where((product) {
      if (product.fired == 0) {
        product.fired = 1;
        return true;
      }
      return false;
    }).toList();
  }

  void closeFunction() {
    BlocProvider.of<PosCubit>(context).clearOrder();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PosCubit, PosState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: CupertinoNavigationBarBackButton(
              onPressed: () => closeFunction(),
            ),
            title: const Text("KOT"),
            actions: const [
              Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        CupertinoIcons.checkmark_seal_fill,
                        color: Colors.green,
                      ),
                      Text("  Printed    "),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        CupertinoIcons.checkmark_seal_fill,
                        color: Colors.blue,
                      ),
                      Text(" Selected    "),
                    ],
                  ),
                ],
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (notFiredList.isNotEmpty)
                    Text(
                      "Pending KOT",
                      style: kHeading3TextStyle,
                    ),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 400.0,
                      mainAxisExtent: 58,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 10,
                    ),
                    itemCount: notFiredList.length,
                    itemBuilder: (BuildContext context, int index) {
                      OrderBillLineModel item = notFiredList[index];
                      return InkWell(
                        onTap: () {
                          setState(() {
                            item.selected =
                                item.selected == false ? true : false;
                            item.fired = item.selected == false ? 0 : 1;
                          });
                        },
                        child: kotWidget(
                          orderBillLine: item,
                          selected: item.selected!,
                          printed: false,
                        ),
                      );
                    },
                  ),
                  Text(
                    "Printed KOT",
                    style: kHeading3TextStyle,
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 400.0,
                      mainAxisExtent: 58,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 10,
                    ),
                    itemCount: firedList.length,
                    itemBuilder: (BuildContext context, int index) {
                      OrderBillLineModel item = firedList[index];
                      return InkWell(
                        onTap: () {
                          setState(() {
                            item.selected =
                                item.selected == false ? true : false;
                            item.fired = item.selected == false ? 0 : 1;
                          });
                        },
                        child: kotWidget(
                            orderBillLine: item,
                            selected: item.selected!,
                            printed: true),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: TwoRowComponent(
            firstComponent: CustomButton(
                secondaryButton: true,
                buttonText: "Cancel KOT",
                onPressed: () {
                  closeFunction();
                }),
            secondComponent: CustomButton(
                buttonText: "Print KOT",
                onPressed: () async {
                  Future.delayed(Duration.zero,
                      () => DialogUtils.showProcessingDialog(context));
                  List<OrderBillLineModel> finalFireList = [];
                  finalFireList.addAll(firedList);
                  finalFireList.addAll(notFiredList);

                  Map<int, List<OrderBillLineModel>> regroupedMap = {};
                  for (var billLine in finalFireList) {
                    if (billLine.printStationId != null &&
                        billLine.selected == true) {
                      if (!regroupedMap.containsKey(billLine.printStationId)) {
                        regroupedMap[billLine.printStationId!] = [];
                      }
                      regroupedMap[billLine.printStationId]?.add(billLine);
                    }
                  }

                  bool firedOrder = await BlocProvider.of<PosCubit>(context)
                      .fireOrder(
                          orderBill: widget.orderBill,
                          orderLineList: finalFireList);
                  Future.delayed(
                      Duration.zero, () => Navigator.of(context).pop());
                  closeFunction();
                  if (firedOrder == true) {
                    // regroupedMap.forEach((printStationId, billLineList) async {
                    //   await networkOrderPrinting(
                    //       context: context,
                    //       orderBill: widget.orderBill,
                    //       billLineList: billLineList);
                    // });
                  } else {
                    Future.delayed(
                        Duration.zero,
                        () => showToastification(
                            message: "something went wrong",
                            context: context,
                            toastificationType: ToastificationType.warning));
                  }
                }),
          ),
        );
      },
    );
  }
}
