import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rastriya_solution_flutter/model/component_button_model.dart';
import 'package:rastriya_solution_flutter/pages/inventory/product/cubit/product_cubit.dart';
import 'package:rastriya_solution_flutter/shared/spacing.dart';
import 'package:rastriya_solution_flutter/shared/text_style.dart';
import 'package:rastriya_solution_flutter/widgets/border_container.dart';
import 'package:rastriya_solution_flutter/widgets/button.dart';
import 'package:rastriya_solution_flutter/widgets/two_row_component.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
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
    List<ComponentButtonModel> menuList = [
      ComponentButtonModel(
          svgPath: "assets/svg/category.svg",
          label: "Category",
          description: "Category Description",
          pushNamed: "/category_list"),
      ComponentButtonModel(
          svgPath: "assets/svg/product.svg",
          label: "Product",
          description: "Product Description",
          pushNamed: "/product_list"),
      ComponentButtonModel(
          svgPath: "assets/svg/unit.svg",
          label: "Unit",
          description: "Unit Description",
          pushNamed: "/unit_list"),
      ComponentButtonModel(
          svgPath: "assets/svg/brand.svg",
          label: "Brand",
          description: "Brand Description",
          pushNamed: "/brand_list"),
      ComponentButtonModel(
          svgPath: "assets/svg/batch.svg",
          label: "Batch",
          description: "Batch Description",
          pushNamed: "/batch_list"),
    ];
    return Scaffold(
        appBar: AppBar(
          leading: const CupertinoNavigationBarBackButton(),
          title: const Text("Inventory"),
        ),
        body: Column(
          children: [
            BlocBuilder<ProductCubit, ProductState>(builder: (context, state) {
              return BorderContainer(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Summary",
                        style: kSubtitleTextStyle,
                      ),
                      BlocBuilder<ProductCubit, ProductState>(
                        builder: (context, state) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              summaryWidth(
                                  length: state.productList.length,
                                  label: "Product"),
                              summaryWidth(
                                  length: state.unitList.length, label: "Unit"),
                              summaryWidth(
                                  length: state.categoryList.length,
                                  label: "Category"),
                            ],
                          );
                        },
                      ),
                      verticalSpaceSmall,
                      TwoRowComponent(
                          horizontalPadding: 0,
                          middleSpace: true,
                          firstComponent: CustomButton(
                              verticalPadding: 5,
                              buttonText: "Create Product",
                              onPressed: () {
                                Navigator.of(context).pushNamed(
                                  "/edit_product",
                                  arguments: {
                                    "categoryList": state.categoryList,
                                    "unitList": state.unitList
                                  },
                                );
                              }),
                          secondComponent: CustomButton(
                              verticalPadding: 0,
                              buttonText: "Category Unit",
                              onPressed: () {
                                Navigator.of(context).pushNamed("/edit_unit");
                              })),
                      CustomButton(
                          verticalPadding: 5,
                          buttonText: "Create Category",
                          onPressed: () {
                            Navigator.of(context).pushNamed(
                              "/edit_category",
                            );
                          }),
                    ],
                  ));
            }),
            ListView.builder(
                shrinkWrap: true,
                itemCount: menuList.length,
                itemBuilder: (BuildContext context, int index) {
                  ComponentButtonModel item = menuList[index];
                  return ListTile(
                    onTap: () =>
                        Navigator.of(context).pushNamed(item.pushNamed),
                    leading: SvgPicture.asset(
                      item.svgPath,
                      width: 50,
                    ),
                    title: Text(item.label),
                    subtitle: Text(item.description),
                    trailing: const Icon(CupertinoIcons.chevron_forward),
                  );
                }),
          ],
        ));
  }

  Widget summaryWidth({
    required int length,
    required String label,
  }) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: kSubtitleTextStyle,
        children: [
          TextSpan(
            text: "$length\n",
            style: const TextStyle(
              color: Colors.blue,
            ),
          ),
          TextSpan(
            text: label,
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
