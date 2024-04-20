import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rastriya_solution_flutter/helper/dialog_utility.dart';
import 'package:rastriya_solution_flutter/helper/toastification.dart';
import 'package:rastriya_solution_flutter/model/product_model.dart';
import 'package:rastriya_solution_flutter/pages/inventory/product/cubit/product_cubit.dart';
import 'package:rastriya_solution_flutter/helper/check_box_filter_bottom_sheet.dart';
import 'package:rastriya_solution_flutter/pages/pos/cubit/pos_cubit.dart';
import 'package:rastriya_solution_flutter/shared/spacing.dart';
import 'package:rastriya_solution_flutter/shared/text_style.dart';
import 'package:rastriya_solution_flutter/widgets/data_table.dart';
import 'package:rastriya_solution_flutter/widgets/list_view_container.dart';
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
              title: Text(
                "Products",
                style: kHeading3TextStyle,
              ),
              actions: [
                Text(
                  "Length: ${state.productList.length}   ",
                  style: kSubtitleTextStyle.copyWith(color: Colors.blue),
                ),
                InkWell(
                  onTap: () {
                    checkBoxFilterBottomSheet(
                      context: context,
                      label: 'Product Filter',
                      checkBoxItems: [
                        'Inventory',
                        'Discountable',
                        'Disabled',
                        'POS Product',
                        'Sellable',
                      ],
                      onSearchPressed: (selectedItems) {
                        print('Selected Items: $selectedItems');
                      },
                    );
                  },
                  child: SvgPicture.asset(
                    "assets/svg/filter.svg",
                    width: 25,
                  ),
                ),
                horizontalSpaceTiny
              ],
            ),
            body: state.isFetching == true
                ? const CustomShimmer()
                : OrientationBuilder(
                    builder: (context, orientation) {
                      if (orientation == Orientation.portrait) {
                        return _buildListView(state: state);
                      } else {
                        return _buildDataTable(state: state);
                      }
                    },
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
                      "unitList": state.unitList,
                    },
                  );
                }));
      },
    );
  }

  Widget _buildListView({required ProductState state}) {
    return ListView.builder(
        itemCount: state.productList.length,
        itemBuilder: (BuildContext context, int index) {
          ProductModel product = state.productList[index];
          return ListViewContainer(
              child: ListTile(
            onTap: () {
              Navigator.of(context).pushNamed(
                "/edit_product",
                arguments: {
                  "product": product,
                  "categoryList": state.categoryList,
                  "unitList": state.unitList,
                },
              );
            },
            leading: CircleAvatar(
                child: Text(product.name.substring(0, 1).toUpperCase())),
            title: Text("${product.name}(${product.baseUnitName ?? "-"})"),
            subtitle: Text(product.categoryName ?? ""),
            trailing: Text(
              "${product.productCode ?? ""}\nNrp${product.lastUnitPrice?.toStringAsFixed(2)}",
              textAlign: TextAlign.end,
            ),
          ));
        });
  }

  Widget _buildDataTable({required ProductState state}) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: CustomDataTable(columnNames: const [
          "Code",
          "Name",
          "Unit",
          "Stock",
          "Category Name",
          "Purchase Cost",
          "Selling Price",
        ], createRow: createRow(state.productList, state)),
      ),
    );
  }

  createRow(List<ProductModel> productList, ProductState state) {
    return productList.map((productInfo) {
      return DataRow(
        selected: false,
        cells: [
          DataCell(Text(productInfo.productCode ?? "")),
          DataCell(Text(productInfo.name)),
          DataCell(Text(productInfo.baseUnitName ?? "")),
          DataCell(
              Text(productInfo.stockInfo?.quantity.toStringAsFixed(2) ?? "")),
          DataCell(Text(productInfo.categoryName ?? "")),
          DataCell(Text(productInfo.lastUnitCost?.toStringAsFixed(2) ?? "")),
          DataCell(Text(productInfo.lastUnitPrice?.toStringAsFixed(2) ?? "")),
        ],
        onSelectChanged: (value) {
          Navigator.of(context).pushNamed(
            "/edit_product",
            arguments: {
              "product": productInfo,
              "categoryList": state.categoryList,
              "unitList": state.unitList,
            },
          );
        },
      );
    }).toList();
  }
}
