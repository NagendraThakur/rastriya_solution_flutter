import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rastriya_solution_flutter/model/component_button_model.dart';

class PurchaseModuleMainPage extends StatelessWidget {
  const PurchaseModuleMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<ComponentButtonModel> salesModules = [
      ComponentButtonModel(
          svgPath: "assets/svg/purchase_order.svg",
          label: "Purchase Order",
          description: "Purchase Order Description",
          pushNamed: "/purchase_order_list"),
      ComponentButtonModel(
          svgPath: "assets/svg/purchase_bill.svg",
          label: "Purchase Bill",
          description: "Purchase Bill Description",
          pushNamed: "/purchase_order_bill"),
      ComponentButtonModel(
          svgPath: "assets/svg/purchase_return.svg",
          label: "Purchase Return",
          description: "Purchase Return Description",
          pushNamed: "/sales_return_list"),
    ];
    return Scaffold(
      appBar: AppBar(
        leading: const CupertinoNavigationBarBackButton(),
        title: const Text("Purchase Module"),
      ),
      body: ListView.builder(
          itemCount: salesModules.length,
          itemBuilder: (BuildContext context, int index) {
            ComponentButtonModel item = salesModules[index];
            return ListTile(
              onTap: () => Navigator.of(context).pushNamed(item.pushNamed),
              leading: SvgPicture.asset(
                item.svgPath,
                width: 50,
              ),
              title: Text(item.label),
              subtitle: Text(item.description),
              trailing: const Icon(
                CupertinoIcons.chevron_forward,
                size: 40,
              ),
            );
          }),
    );
  }
}
