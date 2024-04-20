import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart' as picker;
import 'package:rastriya_solution_flutter/helper/nepali_calender_widget.dart';
import 'package:rastriya_solution_flutter/model/ledger_model.dart';
import 'package:rastriya_solution_flutter/model/purchase_model.dart';
import 'package:rastriya_solution_flutter/pages/purchase_module/cubit/purchase_cubit.dart';
import 'package:rastriya_solution_flutter/shared/spacing.dart';
import 'package:rastriya_solution_flutter/shared/text_style.dart';
import 'package:rastriya_solution_flutter/widgets/border_container.dart';
import 'package:rastriya_solution_flutter/widgets/box_widget.dart';
import 'package:rastriya_solution_flutter/widgets/drop_down_button.dart';
import 'package:rastriya_solution_flutter/widgets/textfield.dart';
import 'package:rastriya_solution_flutter/widgets/two_row_component.dart';

class EditPurchaseBillPage extends StatefulWidget {
  final PurchaseModel? purchaseInfo;
  const EditPurchaseBillPage({
    Key? key,
    this.purchaseInfo,
  }) : super(key: key);

  @override
  State<EditPurchaseBillPage> createState() => _EditPurchaseBillPageState();
}

class _EditPurchaseBillPageState extends State<EditPurchaseBillPage> {
  String? vendorId;
  LedgerModel? vendor;
  TextEditingController vendorBillController = TextEditingController();
  picker.NepaliDateTime vendorBillDate = picker.NepaliDateTime.now();
  picker.NepaliDateTime expiryDate = picker.NepaliDateTime.now();

  @override
  void initState() {
    super.initState();
    if (widget.purchaseInfo != null) {
      vendor = widget.purchaseInfo?.vendorInfo;
      vendorId = widget.purchaseInfo?.vendorInfo?.id;
      vendorBillController.text = widget.purchaseInfo?.vendorBillNo ?? "";
      vendorBillDate = widget.purchaseInfo!.vendorBillDate!.toNepaliDateTime();
      expiryDate = widget.purchaseInfo!.poExpiryDate!.toNepaliDateTime();
    }
    BlocProvider.of<PurchaseCubit>(context)
        .assignPurchaseLine(line: widget.purchaseInfo?.lines ?? []);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return BlocBuilder<PurchaseCubit, PurchaseState>(
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              leading: const CupertinoNavigationBarBackButton(),
              title:
                  Text(widget.purchaseInfo == null ? "Create PO" : "Edit PO"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed("/purchase_product_Search");
                    },
                    child: const Text("Add Product"))
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  CustomDropDownButton(
                    avatarInitials: "C",
                    hintText: "Choose Vendor",
                    label: "Vendor",
                    value: vendorId,
                    padding: const EdgeInsets.only(top: 20),
                    onChanged: (String value) {
                      setState(() {
                        vendorId = value;
                        vendor = state.venderList
                            .where((element) => element.id == value)
                            .firstOrNull;
                      });
                    },
                    items: state.venderList.map((vendor) {
                      return DropdownMenuItem<String>(
                        value: vendor.id,
                        child: Text("${vendor.name} (${vendor.code})"),
                      );
                    }).toList(),
                  ),
                  CustomTextField(
                    hintText: "Enter Vendor Bill No",
                    labelText: "Vender Bill No",
                    controller: vendorBillController,
                  ),
                  verticalSpaceSmall,
                  TwoRowComponent(
                    horizontalPadding: 0,
                    middleSpace: true,
                    firstComponent: InkWell(
                      onTap: () async {
                        vendorBillDate = await nepaliCalender(
                            context: context, initalDate: vendorBillDate);
                        setState(() {});
                      },
                      child: BoxWidget(
                          width: width * 0.4,
                          value: vendorBillDate.toString().split(" ").first,
                          label: "Vendor Bill"),
                    ),
                    secondComponent: InkWell(
                      onTap: () async {
                        expiryDate = await nepaliCalender(
                            context: context, initalDate: expiryDate);
                        setState(() {});
                      },
                      child: BoxWidget(
                          width: width * 0.4,
                          value: expiryDate.toString().split(" ").first,
                          label: "PO Expire"),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.productList.length,
                        itemBuilder: (BuildContext context, int index) {
                          PurchaseLine line = state.productList[index];
                          return BorderContainer(
                              outerPadding: const EdgeInsets.only(top: 5),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ListTile(
                                    title: Text(
                                        "${line.productInfo?.name}(${line.productCode})"),
                                    subtitle: Text(
                                      "${line.productInfo?.batch?.batchName ?? ""}@${line.rate}",
                                      style: kBodyRegularTextStyle,
                                    ),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          "X ${line.quantity!.toStringAsFixed(2)}",
                                          style: kSubtitleRegularTextStyle,
                                        ),
                                        horizontalSpaceMedium,
                                        SizedBox(
                                          width: width * 0.2,
                                          child: Text(
                                            line.netAmount!.toStringAsFixed(2),
                                            style: kSubtitleRegularTextStyle,
                                            textAlign: TextAlign.right,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ));
                        }),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                BorderContainer(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Gross Total"),
                            Text("X ${state.quantity.toStringAsFixed(2)}"),
                            Text(state.totalAmount.toStringAsFixed(2))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Discount Amount"),
                            Text(state.totalDiscountAmount.toStringAsFixed(2))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Net Amount"),
                            Text(state.totalNetAmount.toStringAsFixed(2))
                          ],
                        ),
                      ],
                    )),
              ],
            ));
      },
    );
  }
}
