import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rastriya_solution_flutter/helper/toast.dart';
import 'package:rastriya_solution_flutter/helper/toastification.dart';
import 'package:rastriya_solution_flutter/pages/pos/cubit/pos_cubit.dart';
import 'package:rastriya_solution_flutter/pages/pos/presentation/global/cart/cart_page.dart';
import 'package:rastriya_solution_flutter/pages/pos/presentation/retail/product/product_page.dart';
import 'package:toastification/toastification.dart';

class RetailMainPage extends StatefulWidget {
  const RetailMainPage({super.key});

  @override
  State<RetailMainPage> createState() => _RetailMainPageState();
}

class _RetailMainPageState extends State<RetailMainPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<PosCubit>(context).fetchProductForRetail();
  }

  String? sectionId;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PosCubit, PosState>(
      listener: (context, state) {
        if (state.message != null) {
          showToastification(
              context: context,
              message: state.message!,
              toastificationType: state.message!.contains("Failed")
                  ? ToastificationType.error
                  : ToastificationType.success);
        } else if (state.toastMessage != null) {
          showToast(message: state.toastMessage!);
        } else if (state.billSavedSuccessfully != null) {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        return ProductPage();
      },
    );
  }
}
