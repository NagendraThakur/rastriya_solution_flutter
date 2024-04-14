import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rastriya_solution_flutter/model/loyalty_member_model.dart';
import 'package:rastriya_solution_flutter/pages/pos/cubit/pos_cubit.dart';
import 'package:rastriya_solution_flutter/shared/spacing.dart';
import 'package:rastriya_solution_flutter/shared/text_style.dart';
import 'package:rastriya_solution_flutter/widgets/button.dart';
import 'package:rastriya_solution_flutter/widgets/textfield.dart';
import 'package:rastriya_solution_flutter/widgets/two_row_component.dart';

void loyaltyMemberBottomSheet({
  required BuildContext context,
  required LoyaltyMemberModel loyaltyMember,
  // required double width
}) {
  showModalBottomSheet(
      context: context,
      scrollControlDisabledMaxHeightRatio: 0.9,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
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
                    "Loyalty Member (${loyaltyMember.memberCode})",
                    style: kHeading3TextStyle,
                  ),
                  const CloseButton()
                ],
              ),
              verticalSpaceRegular,
              CustomTextField(
                enabled: false,
                labelText: "Name",
                hintText: loyaltyMember.memberName,
              ),
              TwoRowComponent(
                horizontalPadding: 0,
                middleSpace: true,
                firstComponent: CustomTextField(
                  enabled: false,
                  labelText: "Phone",
                  hintText: loyaltyMember.mobileNumber,
                ),
                secondComponent: CustomTextField(
                  enabled: false,
                  labelText: "Email",
                  hintText: loyaltyMember.emailAddress,
                ),
              ),
              TwoRowComponent(
                  horizontalPadding: 0,
                  middleSpace: true,
                  firstComponent: CustomButton(
                      secondaryButton: true,
                      buttonText: "Cancel",
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                  secondComponent: CustomButton(
                      buttonText: "Save",
                      onPressed: () {
                        BlocProvider.of<PosCubit>(context)
                            .assignLoyaltyMember(loyaltyMember: loyaltyMember);
                        Navigator.of(context).pop();
                      }))
            ],
          ),
        );
      });
}
