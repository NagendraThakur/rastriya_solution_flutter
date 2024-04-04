import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rastriya_solution_flutter/model/product_model.dart';
import 'package:rastriya_solution_flutter/pages/pos/cubit/pos_cubit.dart';
import 'package:rastriya_solution_flutter/shared/text_style.dart';

class ProductPortion extends StatelessWidget {
  const ProductPortion({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PosCubit, PosState>(
      builder: (context, state) {
        return GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 150,
              mainAxisExtent: 100,
              mainAxisSpacing: 10,
              crossAxisSpacing: 5,
            ),
            itemCount: state.productList.length,
            itemBuilder: (BuildContext context, int index) {
              ProductModel product = state.productList[index];
              return InkWell(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(5)),
                  child: ListTile(
                    title: Text(
                      product.name,
                      style: kSubtitleRegularTextStyle,
                    ),
                    subtitle: Text(
                      "Rs ${product.lastUnitPrice!.toStringAsFixed(2)}",
                      style: kSubtitleRegularTextStyle,
                    ),
                  ),
                ),
              );
            });
      },
    );
  }
}
