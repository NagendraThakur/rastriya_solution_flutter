// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:rastriya_solution_flutter/model/grid_item_model.dart';
import 'package:rastriya_solution_flutter/shared/spacing.dart';
import 'package:rastriya_solution_flutter/shared/text_style.dart';
import 'package:rastriya_solution_flutter/widgets/container.dart';

class MenuCard extends StatelessWidget {
  final DashboardMenuModel menuItem;
  const MenuCard({
    Key? key,
    required this.menuItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).pushNamed(menuItem.navigationPath),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          verticalSpaceSmall,
          CustomContainer(
            color: Colors.blue.shade300,
            radius: 20,
            width: 45,
            height: 45,
            child: SvgPicture.asset(
              menuItem.imagePath,
              height: 40,
              fit: BoxFit.contain,
            ),
          ),
          verticalSpaceTiny,
          Text(
            menuItem.label,
            style: kSmallBoldTextStyle,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
