// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rastriya_solution_flutter/pages/pos/cubit/pos_cubit.dart';
import 'package:rastriya_solution_flutter/pages/pos/portion/category/category_portion.dart';
import 'package:rastriya_solution_flutter/pages/pos/portion/restro_product/restro_product_portion.dart';
import 'package:rastriya_solution_flutter/pages/pos/portion/quantity/quantity_portion.dart';
import 'package:rastriya_solution_flutter/shared/spacing.dart';
import 'package:rastriya_solution_flutter/shared/text_style.dart';
import 'package:rastriya_solution_flutter/widgets/textfield.dart';

class CategoryProductPage extends StatefulWidget {
  final bool? payCart;
  const CategoryProductPage({
    Key? key,
    this.payCart = false,
  }) : super(key: key);

  @override
  State<CategoryProductPage> createState() => _CategoryProductPageState();
}

class _CategoryProductPageState extends State<CategoryProductPage> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return BlocBuilder<PosCubit, PosState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: const CupertinoNavigationBarBackButton(),
            title: Text(state.selectedTable?.tableName ?? ""),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(45),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: width * 0.76,
                      child: CustomTextField(
                        topPadding: 0,
                        controller: searchController,
                        prefixIcon: const Icon(CupertinoIcons.search),
                        hintText: "Search For Products",
                        filled: false,
                      ),
                    ),
                    horizontalSpaceTiny,
                    GestureDetector(
                      onTap: () {
                        if (state.orderQuantity.toStringAsFixed(0) != "0") {
                          Navigator.of(context)
                              .pushNamed("/cart", arguments: widget.payCart);
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(5)),
                        alignment: Alignment.center,
                        child: Stack(
                          children: [
                            const IconButton(
                              onPressed: null,
                              icon: Icon(
                                CupertinoIcons.bag,
                                size: 25,
                              ),
                            ),
                            Positioned(
                              right: 0,
                              child: SizedBox(
                                width: 25,
                                height: 25,
                                child: state.orderQuantity.toStringAsFixed(0) ==
                                        "0"
                                    ? null
                                    : CircleAvatar(
                                        backgroundColor: Colors.red,
                                        child: Text(
                                          state.orderQuantity
                                              .toStringAsFixed(0),
                                          style: kSmallBoldTextStyle,
                                        ),
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: const Column(
            children: [
              verticalSpaceSmall,
              QuantityPortion(),
              verticalSpaceSmall,
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 2, child: CategoryPortion()),
                    Expanded(flex: 4, child: RestroProductPage())
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
