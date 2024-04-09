import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rastriya_solution_flutter/model/component_button_model.dart';

class SalesModuleMainPage extends StatelessWidget {
  const SalesModuleMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<ComponentButtonModel> salesModules = [
      ComponentButtonModel(
          svgPath: "assets/svg/top_selling_product.svg",
          label: "Sales Bill",
          description: "Sales Bill Description",
          pushNamed: "/sales_bill_list"),
    ];
    return Scaffold(
      appBar: AppBar(
        leading: const CupertinoNavigationBarBackButton(),
        title: const Text("Sales Module"),
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
