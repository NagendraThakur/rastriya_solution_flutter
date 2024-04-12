import 'package:flutter/material.dart';
import 'package:rastriya_solution_flutter/pages/pos/portion/order/order_portion.dart';
import 'package:rastriya_solution_flutter/widgets/button.dart';

class ReviewOrderPage extends StatefulWidget {
  ReviewOrderPage({super.key});

  @override
  State<ReviewOrderPage> createState() => _ReviewOrderPageState();
}

class _ReviewOrderPageState extends State<ReviewOrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: OrderPortion(
          leading: true,
          enableEditProduct: false,
          enbaleButtons: false,
          enableCancelOrder: true,
        ),
        bottomNavigationBar: CustomButton(
            horizontalPadding: 10,
            buttonText: "Pay",
            onPressed: () {
              Navigator.of(context).pushNamed("/pay");
            }));
  }
}
