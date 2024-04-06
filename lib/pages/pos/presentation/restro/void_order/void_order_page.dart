import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rastriya_solution_flutter/pages/pos/cubit/pos_cubit.dart';
import 'package:rastriya_solution_flutter/shared/spacing.dart';
import 'package:rastriya_solution_flutter/shared/text_style.dart';
import 'package:rastriya_solution_flutter/widgets/button.dart';
import 'package:rastriya_solution_flutter/widgets/drop_down_button.dart';

class VoidOrderPage extends StatefulWidget {
  VoidOrderPage({super.key});

  @override
  State<VoidOrderPage> createState() => _VoidOrderPageState();
}

class _VoidOrderPageState extends State<VoidOrderPage> {
  String? voidId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PosCubit, PosState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: const CupertinoNavigationBarBackButton(),
            title: Text("Cancel ${state.selectedProduct?.name}"),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomDropDownButton(
                  avatarInitials: "V",
                  hintText: "Choose Cancel Reason",
                  label: "Cancel Reason",
                  value: voidId,
                  padding: const EdgeInsets.only(top: 20),
                  onChanged: (String value) {
                    setState(() {
                      voidId = value;
                    });
                  },
                  items: state.voidReasonList?.map((reason) {
                    return DropdownMenuItem<String>(
                      value: reason.id,
                      child: Text(reason.reason),
                    );
                  }).toList(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButton(
                        width: 100,
                        buttonText: "",
                        onPressed: () {
                          if (state.quantity > 1) {
                            BlocProvider.of<PosCubit>(context)
                                .assignQuantity(state.quantity - 1);
                          }
                        },
                        child: const Icon(
                          CupertinoIcons.minus,
                          color: Colors.white,
                        )),
                    horizontalSpaceRegular,
                    Text(state.quantity.toStringAsFixed(0),
                        style: kSubtitleTextStyle),
                    horizontalSpaceRegular,
                    CustomButton(
                        width: 100,
                        buttonText: "",
                        onPressed: () {
                          if (state.quantity >=
                              state.selectedProduct!.quantity!) {
                            return;
                          }
                          BlocProvider.of<PosCubit>(context)
                              .assignQuantity(state.quantity + 1);
                        },
                        child: const Icon(
                          CupertinoIcons.add,
                          color: Colors.white,
                        )),
                  ],
                ),
              ],
            ),
          ),
          bottomNavigationBar: CustomButton(
              horizontalPadding: 10,
              buttonText: "Delete",
              enable: voidId != null,
              onPressed: () {
                BlocProvider.of<PosCubit>(context)
                    .voidOrder(voidId: voidId!)
                    .then((value) {
                  if (value) {
                    BlocProvider.of<PosCubit>(context)
                        .salesOrder(requestType: "put", orderStatus: "open")
                        .then((value) {
                      Navigator.of(context).pop();
                    });
                    voidId = null;
                  }
                });
              }),
        );
      },
    );
  }
}
