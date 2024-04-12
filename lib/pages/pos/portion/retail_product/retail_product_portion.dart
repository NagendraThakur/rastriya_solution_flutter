import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rastriya_solution_flutter/model/product_model.dart';
import 'package:rastriya_solution_flutter/pages/pos/cubit/pos_cubit.dart';
import 'package:rastriya_solution_flutter/shared/text_style.dart';
import 'package:rastriya_solution_flutter/widgets/border_container.dart';

class RestroProductPage extends StatelessWidget {
  const RestroProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PosCubit, PosState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(right: 15),
          child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 400,
                mainAxisExtent: 70,
                mainAxisSpacing: 10,
                crossAxisSpacing: 5,
              ),
              itemCount: state.productList.length,
              itemBuilder: (BuildContext context, int index) {
                ProductModel product = state.productList[index];
                return InkWell(
                  onTap: () {
                    BlocProvider.of<PosCubit>(context).addProductToOrder(
                        product: product, quantity: state.quantity);
                  },
                  child: BorderContainer(
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
              }),
        );
      },
    );
  }
}
