import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rastriya_solution_flutter/helper/dialog_utility.dart';
import 'package:rastriya_solution_flutter/helper/toastification.dart';
import 'package:rastriya_solution_flutter/model/category_model.dart';
import 'package:rastriya_solution_flutter/pages/inventory/category/cubit/category_cubit.dart';
import 'package:rastriya_solution_flutter/shared/text_style.dart';
import 'package:rastriya_solution_flutter/widgets/data_table.dart';
import 'package:rastriya_solution_flutter/widgets/list_view_container.dart';
import 'package:rastriya_solution_flutter/widgets/shimmer.dart';
import 'package:toastification/toastification.dart';

class CategoryListScreen extends StatefulWidget {
  const CategoryListScreen({super.key});

  @override
  State<CategoryListScreen> createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoryListScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero,
        () => BlocProvider.of<CategoryCubit>(context).fetchCategory());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoryCubit, CategoryState>(
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
              title: const Text("Categories"),
            ),
            body: state.isFetching == true
                ? const CustomShimmer()
                : ListView.builder(
                    itemCount: state.categoryList.length,
                    itemBuilder: (BuildContext context, int index) {
                      CategoryModel category = state.categoryList[index];
                      return ListViewContainer(
                          child: ListTile(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            "/edit_category",
                            arguments: category,
                          );
                        },
                        leading: CircleAvatar(
                            child: Text(
                                category.name.substring(0, 1).toUpperCase())),
                        title: Text(category.name.toUpperCase()),
                      ));
                    }),
            // : SingleChildScrollView(
            //     child: Padding(
            //       padding: const EdgeInsets.symmetric(horizontal: 10),
            //       child: CustomDataTable(columnNames: const [
            //         "Name",
            //         "Platinum Discount",
            //         "Gold Discount",
            //         "Silver Discount",
            //       ], createRow: createRow(state.categoryList)),
            //     ),
            //   ),
            floatingActionButton: FloatingActionButton.extended(
                icon: const Icon(CupertinoIcons.add),
                label: Text(
                  "Add Category",
                  style: kSubtitleRegularTextStyle,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    "/edit_category",
                  );
                }));
      },
    );
  }

  List<DataRow> createRow(List<CategoryModel> data) {
    return data.map((CategoryModel item) {
      return DataRow(
        selected: false,
        cells: [
          DataCell(Text(
            item.name,
            style: kBodyRegularTextStyle,
          )),
          DataCell(Text(
            item.platinumDiscount.toStringAsFixed(2),
            style: kBodyRegularTextStyle,
          )),
          DataCell(Text(
            item.platinumDiscount.toStringAsFixed(2),
            style: kBodyRegularTextStyle,
          )),
          DataCell(Text(
            item.platinumDiscount.toStringAsFixed(2),
            style: kBodyRegularTextStyle,
          )),
        ],
        onSelectChanged: (value) async {
          Navigator.of(context).pushNamed(
            "/edit_category",
            arguments: item,
          );
        },
      );
    }).toList();
  }
}
