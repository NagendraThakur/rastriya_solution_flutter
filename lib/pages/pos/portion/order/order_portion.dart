import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rastriya_solution_flutter/constants/config.dart';
import 'package:rastriya_solution_flutter/model/product_model.dart';
import 'package:rastriya_solution_flutter/pages/pos/cubit/pos_cubit.dart';
import 'package:rastriya_solution_flutter/pages/pos/portion/order/portion/order_appbar_action_portion.dart';
import 'package:rastriya_solution_flutter/shared/edge_insect.dart';
import 'package:rastriya_solution_flutter/shared/spacing.dart';
import 'package:rastriya_solution_flutter/shared/text_style.dart';
import 'package:rastriya_solution_flutter/widgets/button.dart';
import 'package:rastriya_solution_flutter/widgets/container.dart';
import 'package:rastriya_solution_flutter/widgets/textfield.dart';
import 'package:rastriya_solution_flutter/widgets/two_row_component.dart';

class OrderPortion extends StatelessWidget {
  final bool enableEditProduct;
  final bool enableEditProductNavigation;
  final bool enbaleButtons;
  final bool enbalAppbarActions;
  final bool? leading;
  final bool? enableOrderInfo;
  final Widget? bottomNavigationBar;
  final bool? enableClear;
  final bool? enableCancelOrder;
  OrderPortion({
    super.key,
    required this.enableEditProduct,
    required this.enableEditProductNavigation,
    required this.enbaleButtons,
    required this.enbalAppbarActions,
    this.leading = false,
    this.enableOrderInfo = true,
    this.bottomNavigationBar,
    this.enableClear = true,
    this.enableCancelOrder = false,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return BlocBuilder<PosCubit, PosState>(
      builder: (context, state) {
        return CustomContainer(
          rightBorder: true,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: Text(state.selectedTable?.tableName ?? "Orders"),
              // title: Column(
              //   mainAxisSize: MainAxisSize.min,
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     Text(state.selectedTable?.tableName ?? "Orders"),
              //     Text(
              //       state.loyaltyMember?.memberName ??
              //           state.customer?.name ??
              //           "",
              //       style: kBodyRegularTextStyle,
              //     ),
              //   ],
              // ),
              leading: leading == true
                  ? const CupertinoNavigationBarBackButton()
                  : null,
              automaticallyImplyLeading: leading!,
              actions: [
                enbalAppbarActions
                    ? OrderAppBarActions(
                        enableClear: enableClear!,
                        enableCancelOrder: enableCancelOrder!,
                      )
                    : const SizedBox.shrink()
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.orderList?.length ?? 0,
                      itemBuilder: ((context, index) {
                        ProductModel product = state.orderList![index];

                        return InkWell(
                            onTap: () {
                              if (enableEditProduct) {
                                BlocProvider.of<PosCubit>(context)
                                    .selectProduct(product: product);
                              }
                              if (enableEditProductNavigation) {
                                editProductBottomSheet(
                                    context: context,
                                    product: product,
                                    width: width);
                              }
                            },
                            child: orderWidget(
                                product: product,
                                width: width,
                                showNotePortion: true));
                      }),
                    ),
                  ),
                  enableOrderInfo!
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total",
                              style: kBodyRegularTextStyle1,
                            ),
                            Text(
                              "x  ${state.orderQuantity.toStringAsFixed(3)}",
                              style: kBodyRegularTextStyle1,
                            ),
                            Text(
                              "Rs ${state.subtotal.toStringAsFixed(2)}",
                              style: kBodyRegularTextStyle1,
                              textAlign: TextAlign.end,
                            ),
                          ],
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            ),
            // bottomNavigationBar: bottomNavigationBar ??
            //     (enbaleButtons
            //         ? CustomButton(
            //             verticalPadding: 5,
            //             buttonText: "Pay",
            //             enable: Config.permissionInfo?.documentPostingLevel ==
            //                     "posting" &&
            //                 state.orderList != null &&
            //                 state.orderList!.isNotEmpty,
            //             onPressed: () {
            //               // if (state.loyaltyMember != null) {
            //               //   await BlocProvider.of<PosCubit>(context)
            //               //       .fetchLoyaltyMemberDiscount();
            //               //   Navigator.of(context).pop();
            //               // } else {
            //               //   BlocProvider.of<PosCubit>(context)
            //               //       .assignDiscountForOrder();
            //               // }
            //               Navigator.of(context).pushNamed("/pay");
            //             })
            //         : null),
          ),
        );
      },
    );
  }
}

void editProductBottomSheet(
    {required BuildContext context,
    required ProductModel product,
    required double width}) {
  showModalBottomSheet(
      context: context,
      scrollControlDisabledMaxHeightRatio: 0.9,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        // <-- SEE HERE
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10.0),
        ),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              verticalSpaceSmall,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Edit Product",
                    style: kHeading3TextStyle,
                  ),
                  const CloseButton()
                ],
              ),
              verticalSpaceSmall,
              orderWidget(
                  product: product, width: width, showNotePortion: false),
              const CustomTextField(
                maxLine: 4,
                hintText:
                    "Do you want to add anything as remarks for future reference?",
              ),
              verticalSpaceRegular,
              TwoRowComponent(
                  firstComponent: CustomButton(
                      secondaryButton: true,
                      buttonText: "Delete",
                      onPressed: () {}),
                  secondComponent:
                      CustomButton(buttonText: "Save", onPressed: () {}))
            ],
          ),
        );
      });
}

Widget orderWidget(
    {required ProductModel product,
    required double width,
    required bool showNotePortion}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: Container(
      decoration: BoxDecoration(border: Border.all()),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text(product.name),
            subtitle: Text(
              "${product.batch?.batchName ?? ""} @ ${product.lastUnitPrice!.toStringAsFixed(2)}",
              style: kBodyRegularTextStyle,
            ),
            trailing: Text(
              (product.quantity! * product.lastUnitPrice!).toStringAsFixed(2),
              style: kSubtitleRegularTextStyle,
            ),
          ),
          showNotePortion
              ? Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomTextField(
                        enabled: false,
                        filled: false,
                        width: width * 0.6,
                        topPadding: 0,
                        prefixIcon: const Icon(CupertinoIcons.doc_text),
                        hintText: "Enter Remarks to Product",
                      ),
                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.blue.shade800,
                            borderRadius: BorderRadius.circular(5)),
                        width: 50,
                        height: 50,
                        child: Text(
                          product.quantity!.toStringAsFixed(0),
                          style:
                              kHeading3TextStyle.copyWith(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                )
              : const SizedBox.shrink(),
          const SizedBox(
            height: 15,
          )
        ],
      ),
    ),
  );
}

// Widget orderWiget(
//     {required ProductModel product,
//     required double width,
//     required BuildContext context}) {
//   return Padding(
//     padding: const EdgeInsets.only(bottom: 4, left: 8, right: 8),
//     child: Container(
//       child: Row(
//         children: [
         
//           Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(
//                   width:
//                       MediaQuery.of(context).orientation == Orientation.portrait
//                           ? width * 0.3
//                           : width * 0.13,
//                   child: Text(
//                     product.name,
//                     overflow: TextOverflow.ellipsis,
//                   )),
//               product.batch?.batchName != null
//                   ? Text(
//                       product.batch!.batchName,
//                       style: kSmallRegularTextStyle,
//                     )
//                   : const SizedBox.shrink(),
//             ],
//           ),
//           Text("  x   ${product.quantity!.toStringAsFixed(3)}"),
//           const Spacer(),
//           Text(
//             product.lastUnitPrice!.toStringAsFixed(2),
//             textAlign: TextAlign.end,
//           ),
//         ],
//       ),
//     ),
//   );
// }
