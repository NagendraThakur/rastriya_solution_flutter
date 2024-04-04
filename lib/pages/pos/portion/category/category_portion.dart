import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rastriya_solution_flutter/model/product_model.dart';
import 'package:rastriya_solution_flutter/pages/pos/cubit/pos_cubit.dart';
import 'package:rastriya_solution_flutter/shared/text_style.dart';

class CategoryPortion extends StatefulWidget {
  const CategoryPortion({super.key});

  @override
  State<CategoryPortion> createState() => _CategoryPortionState();
}

class _CategoryPortionState extends State<CategoryPortion> {
  String? selectedCategory;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PosCubit, PosState>(
      builder: (context, state) {
        return ListView.builder(
            itemCount: state.categoryProductList?.length,
            itemBuilder: (BuildContext context, int index) {
              String categoryKey =
                  state.categoryProductList!.keys.elementAt(index);
              List<ProductModel> productList =
                  state.categoryProductList![categoryKey]!;
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      selectedCategory = categoryKey;
                    });
                    BlocProvider.of<PosCubit>(context)
                        .assignProductList(productList: productList);
                  },
                  child: Container(
                      height: 65,
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                          color: selectedCategory == categoryKey
                              ? Colors.blue.shade400
                              : null,
                          borderRadius: BorderRadius.circular(5)),
                      alignment: Alignment.centerLeft,
                      child: Text(categoryKey,
                          style: kBodyRegularTextStyle.copyWith(
                            color: selectedCategory == categoryKey
                                ? Colors.white
                                : null,
                          ))),
                ),
              );
            });
      },
    );
  }
}
