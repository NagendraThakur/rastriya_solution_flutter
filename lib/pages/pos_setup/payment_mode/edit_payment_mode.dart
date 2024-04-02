// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rastriya_solution_flutter/constants/config.dart';
import 'package:rastriya_solution_flutter/helper/dialog_utility.dart';
import 'package:rastriya_solution_flutter/helper/toastification.dart';
import 'package:rastriya_solution_flutter/model/ledger_model.dart';
import 'package:rastriya_solution_flutter/model/payment_mode_image_model.dart';
import 'package:rastriya_solution_flutter/model/payment_mode_model.dart';
import 'package:rastriya_solution_flutter/pages/pos_setup/payment_mode/cubit/payment_mode_cubit.dart';
import 'package:rastriya_solution_flutter/shared/edge_insect.dart';
import 'package:rastriya_solution_flutter/widgets/button.dart';
import 'package:rastriya_solution_flutter/widgets/drop_down_button.dart';
import 'package:rastriya_solution_flutter/widgets/switch.dart';
import 'package:rastriya_solution_flutter/widgets/textfield.dart';
import 'package:toastification/toastification.dart';

class EditPaymentModeScreen extends StatefulWidget {
  final PaymentModeModel? paymentModeInfo;
  const EditPaymentModeScreen({
    Key? key,
    this.paymentModeInfo,
  }) : super(key: key);

  @override
  State<EditPaymentModeScreen> createState() => _EditPaymentModeScreenState();
}

class _EditPaymentModeScreenState extends State<EditPaymentModeScreen> {
  final TextEditingController name = TextEditingController();
  PaymentModeModel? paymentMode;
  bool status = true;

  String? id;
  String? imageId;
  String? imagePath;
  String? assetsUploadUrl;
  String? ledgerCode;
  String? paymentType;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    paymentMode = widget.paymentModeInfo;
    status = paymentMode?.status ?? true;
    id = paymentMode?.id;
    imageId = paymentMode?.image;
    imagePath = paymentMode?.imagePath;
    name.text = paymentMode?.name ?? "";
    ledgerCode = paymentMode?.ledgerCode;
    paymentType = paymentMode?.type;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 1,
        title: const Text("Payment Mode"),
        leading: const CupertinoNavigationBarBackButton(),
      ),
      body: BlocConsumer<PaymentModeCubit, PaymentModeState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state.isLoading == true) {
            Future.delayed(
                Duration.zero, () => DialogUtils.showProcessingDialog(context));
          } else if (state.isLoading == false) {
            Navigator.of(context).pop();
          }
        },
        builder: (context, state) {
          List<LedgerModel> ledgerList = state.ledgerList;

          return Padding(
            padding: kEdgeInsetsHorizontalSmall,
            child: Column(
              children: [
                CustomTextField(
                  labelText: "Name",
                  controller: name,
                ),
                CustomSwitch(
                  values: status,
                  label: "Status",
                  padding: const EdgeInsets.only(top: 20),
                  onChanged: (value) {
                    status = value;
                    setState(() {});
                  },
                ),
                CustomDropDownButton(
                  avatarInitials: "L",
                  hintText: "Select Legder",
                  label: "Ledger",
                  value: ledgerCode,
                  padding: const EdgeInsets.only(top: 20),
                  onChanged: (String value) {
                    ledgerCode = value;
                  },
                  items: ledgerList.map((LedgerModel ledger) {
                    return DropdownMenuItem<String>(
                      value: ledger.code,
                      child: Text(ledger.name),
                    );
                  }).toList(),
                ),
                CustomDropDownButton(
                    avatarInitials: "P",
                    hintText: "Select Payment Type",
                    label: "Type",
                    value: paymentType,
                    padding: const EdgeInsets.only(top: 20),
                    onChanged: (String value) {
                      paymentType = value;
                    },
                    items: const [
                      DropdownMenuItem(value: "CASH", child: Text("CASH")),
                      DropdownMenuItem(
                          value: "CARD/POS", child: Text("CARD/POS")),
                      DropdownMenuItem(
                          value: "E-WALLET", child: Text("E-WALLET"))
                    ]),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: CustomButton(
          buttonText: "Save",
          onPressed: () {
            if (ledgerCode == null || paymentType == null || imageId == null) {
              showToastification(
                  message: "invalid data",
                  context: context,
                  toastificationType: ToastificationType.warning);
            }
            PaymentModeModel paymentMode = PaymentModeModel(
              id: id,
              storeId: Config.storeInfo!.id,
              name: name.text,
              status: status,
              ledgerCode: ledgerCode!,
              type: paymentType!,
              image: imageId,
              imagePath: imagePath,
              amount: null,
            );

            BlocProvider.of<PaymentModeCubit>(context)
                .savePaymentMode(paymentMode: paymentMode);
          }),
    );
  }
}
