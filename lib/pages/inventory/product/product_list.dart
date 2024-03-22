import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rastriya_solution_flutter/helper/dialog_utility.dart';
import 'package:rastriya_solution_flutter/helper/toastification.dart';
import 'package:rastriya_solution_flutter/model/category_model.dart';
import 'package:rastriya_solution_flutter/model/product_model.dart';
import 'package:rastriya_solution_flutter/pages/inventory/category/cubit/category_cubit.dart';
import 'package:rastriya_solution_flutter/pages/inventory/product/cubit/product_cubit.dart';
import 'package:rastriya_solution_flutter/shared/text_style.dart';
import 'package:rastriya_solution_flutter/widgets/data_table.dart';
import 'package:rastriya_solution_flutter/widgets/shimmer.dart';
import 'package:toastification/toastification.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      BlocProvider.of<ProductCubit>(context).fetchProduct();
      BlocProvider.of<ProductCubit>(context).fetchCategory();
      BlocProvider.of<ProductCubit>(context).fetchUnit();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductCubit, ProductState>(
      listener: (context, state) {
        if (state.isLoading == true) {
          Future.delayed(
              Duration.zero, () => DialogUtils.showProcessingDialog(context));
        } else if (state.isLoading == false) {
          Navigator.of(context).pop();
        } else if (state.message != null) {
          showToastification(
              context: context,
              message: state.message!,
              toastificationType: state.message!.contains("Failed")
                  ? ToastificationType.error
                  : ToastificationType.success);
        }
      },
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              leading: const CupertinoNavigationBarBackButton(),
              title: const Text("Products"),
            ),
            body: state.isFetching == true
                ? const CustomShimmer()
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: CustomDataTable(columnNames: const [
                        "Code",
                        "Name",
                        "Unit",
                        "Purchase Cost",
                        "Selling Price",
                        "Category Name"
                      ], createRow: createRow(state.productList, state)),
                    ),
                  ),
            floatingActionButton: FloatingActionButton.extended(
                icon: const Icon(CupertinoIcons.add),
                label: Text(
                  "Add Product",
                  style: kSubtitleRegularTextStyle,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    "/edit_product",
                    arguments: {
                      "categoryList": state.categoryList,
                      "unitList": state.unitList
                    },
                  );
                }));
      },
    );
  }

  List<DataRow> createRow(List<ProductModel> data, ProductState state) {
    return data.map((ProductModel item) {
      return DataRow(
        selected: false,
        cells: [
          DataCell(Text(
            item.productCode ?? "-",
            style: kBodyRegularTextStyle,
          )),
          DataCell(Text(
            item.name,
            style: kBodyRegularTextStyle,
          )),
          DataCell(Text(
            item.baseUnitName ?? "-",
            style: kBodyRegularTextStyle,
          )),
          DataCell(Text(
            item.lastUnitCost!.toStringAsFixed(2),
            style: kBodyRegularTextStyle,
          )),
          DataCell(Text(
            item.lastUnitPrice!.toStringAsFixed(2),
            style: kBodyRegularTextStyle,
          )),
          DataCell(Text(
            item.categoryName ?? "-",
            style: kBodyRegularTextStyle,
          )),
        ],
        onSelectChanged: (value) async {
          Navigator.of(context).pushNamed(
            "/edit_product",
            arguments: {
              "product": item,
              "categoryList": state.categoryList,
              "unitList": state.unitList
            },
          );
        },
      );
    }).toList();
  }
}
