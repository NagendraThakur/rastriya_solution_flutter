import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rastriya_solution_flutter/pages/pos/cubit/pos_cubit.dart';
import 'package:rastriya_solution_flutter/pages/pos/portion/order/order_portion.dart';
import 'package:rastriya_solution_flutter/widgets/button.dart';
import 'package:rastriya_solution_flutter/widgets/two_row_component.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OrderPortion(
          leading: true,
          enableEditProduct: true,
          enableEditProductNavigation: true,
          enbaleButtons: false,
          enbalAppbarActions: false),
      bottomNavigationBar: TwoRowComponent(
          firstComponent: CustomButton(
              secondaryButton: true,
              buttonText: "Clear",
              onPressed: () {
                BlocProvider.of<PosCubit>(context).clearOrder();
                Navigator.of(context).pop();
              }),
          secondComponent: CustomButton(buttonText: "Save", onPressed: () {})),
    );
  }
}
