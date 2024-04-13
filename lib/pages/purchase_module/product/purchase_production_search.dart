import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rastriya_solution_flutter/model/product_model.dart';
import 'package:rastriya_solution_flutter/pages/purchase_module/cubit/purchase_cubit.dart';
import 'package:rastriya_solution_flutter/pages/purchase_module/product/portion/add_product_to_purchase_line.dart';
import 'package:rastriya_solution_flutter/shared/spacing.dart';
import 'package:rastriya_solution_flutter/widgets/data_table.dart';
import 'package:rastriya_solution_flutter/widgets/textfield.dart';

class PurchaseProductSearchPage extends StatefulWidget {
  const PurchaseProductSearchPage({super.key});

  @override
  State<PurchaseProductSearchPage> createState() =>
      _PurchaseProductSearchPageState();
}

class _PurchaseProductSearchPageState extends State<PurchaseProductSearchPage> {
  TextEditingController productController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PurchaseCubit, PurchaseState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Products"),
            leading: const CupertinoNavigationBarBackButton(),
          ),
          body: Column(
            children: [
              CustomTextField(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                hintText: "Search Product",
                controller: productController,
              ),
              verticalSpaceSmall,
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: CustomDataTable(columnNames: const [
                      "Code",
                      "Name",
                      "Unit",
                      "Batch",
                      "Category",
                      "Purchase Cost",
                      "Selling Price",
                      "Vat Percentage",
                      "Previous Vendor Code"
                    ], createRow: createRow(state.searchProductList, state)),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  createRow(List<ProductModel> productList, PurchaseState state) {
    return productList.map((productInfo) {
      return DataRow(
        selected: false,
        cells: [
          DataCell(Text(productInfo.productCode ?? "")),
          DataCell(Text(productInfo.name)),
          DataCell(Text(productInfo.baseUnitName ?? "")),
          DataCell(Text(productInfo.batch?.batchName ?? "")),
          DataCell(Text(productInfo.categoryName ?? "")),
          DataCell(Text(productInfo.lastUnitCost?.toStringAsFixed(2) ?? "")),
          DataCell(Text(productInfo.lastUnitPrice?.toStringAsFixed(2) ?? "")),
          DataCell(Text(productInfo.vatPercent?.toStringAsFixed(2) ?? "")),
          DataCell(Text(productInfo.lastVendorCode ?? "")),
        ],
        onSelectChanged: (value) {
          addProuductToPurchaseLine(context: context, product: productInfo);
        },
      );
    }).toList();
  }
}
