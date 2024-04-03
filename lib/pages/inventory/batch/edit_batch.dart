// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rastriya_solution_flutter/helper/toastification.dart';
import 'package:rastriya_solution_flutter/model/batch_model.dart';
import 'package:rastriya_solution_flutter/model/product_model.dart';
import 'package:rastriya_solution_flutter/pages/inventory/batch/cubit/batch_cubit.dart';
import 'package:rastriya_solution_flutter/shared/spacing.dart';
import 'package:rastriya_solution_flutter/widgets/button.dart';
import 'package:rastriya_solution_flutter/widgets/drop_down_button.dart';
import 'package:rastriya_solution_flutter/widgets/switch.dart';
import 'package:rastriya_solution_flutter/widgets/textfield.dart';
import 'package:rastriya_solution_flutter/widgets/two_row_component.dart';
import 'package:toastification/toastification.dart';

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

  TextEditingController lastUnitCost = TextEditingController(text: "0");

  bool status = false;

  @override
  void initState() {
    super.initState();
    if (widget.batch != null) {
      batchName.text = widget.batch!.batchName;
      lastUnitPrice.text = widget.batch?.unitPrice.toStringAsFixed(2) ?? "0";
      lastUnitCost.text = widget.batch?.unitCost?.toStringAsFixed(2) ?? "0";
      productId = widget.batch!.productId;
      status = widget.batch?.status == "1" ? true : false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CupertinoNavigationBarBackButton(),
        title: Text(widget.batch == null ? "Create Batch" : "Edit Batch"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            CustomTextField(
              required: true,
              labelText: "Name",
              hintText: "Your Batch Name",
              controller: batchName,
            ),
            CustomDropDownButton(
              avatarInitials: "P",
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
                required: true,
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
      bottomNavigationBar: CustomButton(
          horizontalPadding: 10,
          buttonText: "Save",
          onPressed: () {
            if (productId == null) {
              showToastification(
                  context: context,
                  message: "Product Not Selected",
                  toastificationType: ToastificationType.warning);
              return;
            }
            double unitCost = lastUnitCost.text.isNotEmpty
                ? double.parse(lastUnitCost.text)
                : 0.0;
            double unitPrice = lastUnitPrice.text.isNotEmpty
                ? double.parse(lastUnitPrice.text)
                : 0.0;
            BatchModel batch = BatchModel(
                id: widget.batch?.id,
                productId: productId!,
                batchName: batchName.text,
                unitCost: unitCost,
                unitPrice: unitPrice,
                manufacturingDate: DateTime.now().toString(),
                expirationDate: DateTime.now().toString(),
                status: status == true ? "1" : "0");
            BlocProvider.of<BatchCubit>(context).saveBatch(batch: batch);
          }),
    );
  }
}
