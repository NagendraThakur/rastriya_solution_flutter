// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rastriya_solution_flutter/model/category_model.dart';
import 'package:rastriya_solution_flutter/model/product_model.dart';
import 'package:rastriya_solution_flutter/model/unit_model.dart';
import 'package:rastriya_solution_flutter/pages/inventory/product/cubit/product_cubit.dart';
import 'package:rastriya_solution_flutter/shared/spacing.dart';
import 'package:rastriya_solution_flutter/widgets/button.dart';
import 'package:rastriya_solution_flutter/widgets/container.dart';
import 'package:rastriya_solution_flutter/widgets/drop_down_button.dart';
import 'package:rastriya_solution_flutter/widgets/switch.dart';
import 'package:rastriya_solution_flutter/widgets/textfield.dart';
import 'package:rastriya_solution_flutter/widgets/two_row_component.dart';

class EditProductScreen extends StatefulWidget {
  final ProductModel? product;
  final List<CategoryModel> categoryList;
  final List<UnitModel> unitList;

  const EditProductScreen({
    Key? key,
    this.product,
    required this.categoryList,
    required this.unitList,
  }) : super(key: key);

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  TextEditingController name = TextEditingController();
  String? categoryId;
  String? unitId;
  String? vatPercentage;
  TextEditingController lastUnitCost = TextEditingController(text: "0");
  TextEditingController lastUnitPrice = TextEditingController();
  TextEditingController barcode1 = TextEditingController();
  TextEditingController remark1 = TextEditingController();
  TextEditingController maxRetailPrice = TextEditingController(text: "0");
  TextEditingController profitPercentage = TextEditingController(text: "0");
  TextEditingController description = TextEditingController();
  bool showInPos = true;
  bool blocked = false;
  bool discountable = true;
  bool inventoryItem = true;
  bool sellableItem = true;
  bool batchLot = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.product != null) {
      name.text = widget.product!.name;
      unitId = widget.product?.baseUnit;
      categoryId = widget.product?.productGroup;
      vatPercentage = widget.product?.vatPercent?.toStringAsFixed(0);
      lastUnitCost.text = widget.product!.lastUnitCost!.toStringAsFixed(2);
      lastUnitPrice.text = widget.product!.lastUnitPrice!.toStringAsFixed(2);
      barcode1.text = widget.product!.barcode1 ?? "";
      remark1.text = widget.product!.remarks1 ?? "";
      maxRetailPrice.text = widget.product!.mrp ?? "0";
      profitPercentage.text = widget.product!.profitPercent ?? "0";
      description.text = widget.product!.productDetail ?? "";
      showInPos = widget.product?.isPos == "1" ? true : false;
      blocked = widget.product?.blocked == "1" ? true : false;
      discountable = widget.product?.discountable == "1" ? true : false;
      inventoryItem = widget.product?.inventoryItem == "1" ? true : false;
      sellableItem = widget.product?.sellableItem == "1" ? true : false;
      batchLot = widget.product?.batchLot == "1" ? true : false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CupertinoNavigationBarBackButton(),
        title: Text(widget.product == null ? "Create Product" : "Edit Product"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomTextField(
                required: true,
                labelText: "Name",
                hintText: "Your Product Name",
                controller: name,
              ),
              TwoRowComponent(
                horizontalPadding: 0,
                middleSpace: true,
                firstComponent: CustomDropDownButton(
                  avatarInitials: "U",
                  hintText: "Choose Unit",
                  label: "Unit",
                  value: unitId,
                  padding: const EdgeInsets.only(top: 20),
                  onChanged: (String value) {
                    setState(() {
                      unitId = value;
                    });
                  },
                  items: widget.unitList.map((unit) {
                    return DropdownMenuItem<String>(
                      value: unit.id,
                      child: Text(unit.name),
                    );
                  }).toList(),
                ),
                secondComponent: CustomDropDownButton(
                    avatarInitials: "V",
                    hintText: "Choose Vat",
                    label: "VAT Percentage",
                    value: vatPercentage,
                    padding: const EdgeInsets.only(top: 20),
                    onChanged: (String value) {
                      setState(() {
                        vatPercentage = value;
                      });
                    },
                    items: const [
                      DropdownMenuItem(value: "0", child: Text("0 %")),
                      DropdownMenuItem(value: "14", child: Text("14 %")),
                    ]),
              ),
              CustomDropDownButton(
                avatarInitials: "C",
                hintText: "Choose Category",
                label: "Category",
                value: categoryId,
                padding: const EdgeInsets.only(top: 20),
                onChanged: (String value) {
                  setState(() {
                    categoryId = value;
                  });
                },
                items: widget.categoryList.map((category) {
                  return DropdownMenuItem<String>(
                    value: category.id,
                    child: Text(category.name),
                  );
                }).toList(),
              ),
              TwoRowComponent(
                horizontalPadding: 0,
                middleSpace: true,
                firstComponent: CustomTextField(
                  labelText: "Purchase Cost",
                  hintText: "Your Purchase Cost",
                  controller: lastUnitCost,
                ),
                secondComponent: CustomTextField(
                  required: true,
                  labelText: "Selling Price",
                  hintText: "Your Selling Price",
                  controller: lastUnitPrice,
                ),
              ),
              verticalSpaceSmall,
              ExpansionTile(
                tilePadding: EdgeInsets.zero,
                title: const Text(
                  'Additional Details',
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    color: Colors.blue,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.left,
                ),
                children: [
                  TwoRowComponent(
                    horizontalPadding: 0,
                    middleSpace: true,
                    firstComponent: CustomTextField(
                      labelText: "Barcode",
                      hintText: "Your Barcode",
                      controller: barcode1,
                    ),
                    secondComponent: CustomTextField(
                      labelText: "Note",
                      hintText: "Your Note",
                      controller: remark1,
                    ),
                  ),
                  TwoRowComponent(
                    horizontalPadding: 0,
                    middleSpace: true,
                    firstComponent: CustomTextField(
                      labelText: "Mrp",
                      hintText: "Proudct MRP",
                      controller: maxRetailPrice,
                    ),
                    secondComponent: CustomTextField(
                      labelText: "Profit %",
                      hintText: "Your Profit %",
                      controller: profitPercentage,
                    ),
                  ),
                  CustomTextField(
                    labelText: "Description",
                    hintText: "Your Description",
                    controller: description,
                  ),
                  verticalSpaceSmall,
                ],
              ),
              ExpansionTile(
                tilePadding: EdgeInsets.zero,
                title: const Text(
                  'Permission Details',
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    color: Colors.blue,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.left,
                ),
                children: [
                  verticalSpaceSmall,
                  TwoRowComponent(
                    horizontalPadding: 0,
                    middleSpace: true,
                    firstComponent: CustomSwitch(
                        onChanged: (bool value) {
                          setState(() {
                            showInPos = value;
                          });
                        },
                        values: showInPos,
                        label: "Pos Product"),
                    secondComponent: CustomSwitch(
                        onChanged: (bool value) {
                          setState(() {
                            blocked = value;
                          });
                        },
                        values: blocked,
                        label: "Blocked"),
                  ),
                  verticalSpaceRegular,
                  TwoRowComponent(
                    horizontalPadding: 0,
                    middleSpace: true,
                    firstComponent: CustomSwitch(
                        onChanged: (bool value) {
                          setState(() {
                            discountable = value;
                          });
                        },
                        values: discountable,
                        label: "Discountable"),
                    secondComponent: CustomSwitch(
                        onChanged: (bool value) {
                          setState(() {
                            inventoryItem = value;
                          });
                        },
                        values: inventoryItem,
                        label: "Inventory Item"),
                  ),
                  verticalSpaceRegular,
                  TwoRowComponent(
                    horizontalPadding: 0,
                    middleSpace: true,
                    firstComponent: CustomSwitch(
                        onChanged: (bool value) {
                          setState(() {
                            sellableItem = value;
                          });
                        },
                        values: sellableItem,
                        label: "Sellable Item"),
                    secondComponent: CustomSwitch(
                        onChanged: (bool value) {
                          setState(() {
                            batchLot = value;
                          });
                        },
                        values: batchLot,
                        label: "Batch Lot"),
                  ),
                  verticalSpaceSmall,
                ],
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomButton(
          horizontalPadding: 10,
          buttonText: "Save",
          onPressed: () {
            double vatPer =
                vatPercentage != null ? double.parse(vatPercentage!) : 0.0;
            double unitCost = lastUnitCost.text.isNotEmpty
                ? double.parse(lastUnitCost.text)
                : 0.0;
            double unitPrice = lastUnitPrice.text.isNotEmpty
                ? double.parse(lastUnitPrice.text)
                : 0.0;
            ProductModel product = ProductModel(
              id: widget.product?.id,
              name: name.text,
              baseUnit: unitId,
              productGroup: categoryId,
              vatPercent: vatPer,
              lastUnitCost: unitCost,
              lastUnitPrice: unitPrice,
              barcode1: barcode1.text,
              remarks1: remark1.text,
              mrp: maxRetailPrice.text,
              profitPercent: profitPercentage.text,
              productDetail: description.text,
              isPos: showInPos == true ? "1" : "0",
              blocked: blocked == true ? "1" : "0",
              discountable: discountable == true ? "1" : "0",
              inventoryItem: inventoryItem == true ? "1" : "0",
              sellableItem: sellableItem == true ? "1" : "0",
              batchLot: batchLot == true ? "1" : "0",
            );
            BlocProvider.of<ProductCubit>(context)
                .saveProduct(product: product);
          }),
    );
  }
}
