// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rastriya_solution_flutter/model/batch_model.dart';
import 'package:rastriya_solution_flutter/model/product_model.dart';
import 'package:rastriya_solution_flutter/shared/spacing.dart';
import 'package:rastriya_solution_flutter/widgets/drop_down_button.dart';
import 'package:rastriya_solution_flutter/widgets/switch.dart';
import 'package:rastriya_solution_flutter/widgets/textfield.dart';
import 'package:rastriya_solution_flutter/widgets/two_row_component.dart';

class EditBatchScreen extends StatefulWidget {
  final List<ProductModel> productList;
  final BatchModel? batch;
  EditBatchScreen({
    Key? key,
    required this.productList,
    this.batch,
  }) : super(key: key);

  @override
  State<EditBatchScreen> createState() => _EditBatchScreenState();
}

class _EditBatchScreenState extends State<EditBatchScreen> {
  TextEditingController batchName = TextEditingController();

  String? productId;

  TextEditingController lastUnitPrice = TextEditingController();

  TextEditingController lastUnitCost = TextEditingController();

  bool status = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CupertinoNavigationBarBackButton(),
        title: const Text("Create Batch"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            CustomTextField(
              labelText: "Name",
              hintText: "Your Batch Name",
              controller: batchName,
            ),
            CustomDropDownButton(
              hintText: "Choose Product",
              label: "Product",
              value: productId,
              padding: const EdgeInsets.only(top: 20),
              onChanged: (String value) {
                setState(() {
                  productId = value;
                });
              },
              items: widget.productList.map((product) {
                return DropdownMenuItem<String>(
                  value: product.id,
                  child: Text(product.name),
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
                labelText: "Selling Price",
                hintText: "Your Selling Price",
                controller: lastUnitPrice,
              ),
            ),
            verticalSpaceRegular,
            CustomSwitch(
                onChanged: (bool value) {
                  setState(() {
                    status = value;
                  });
                },
                values: status,
                label: "Blocked"),
          ],
        ),
      ),
    );
  }
}
