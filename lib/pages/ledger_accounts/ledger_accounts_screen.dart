import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rastriya_solution_flutter/model/component_button_model.dart';

class LedgerAccountScreen extends StatelessWidget {
  const LedgerAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<ComponentButtonModel> menuList = [
      ComponentButtonModel(
          svgPath: "svgPath",
          label: "General Ledger",
          description: "General Ledger Description",
          pushNamed: "/general_ledger_list"),
      ComponentButtonModel(
          svgPath: "svgPath",
          label: "Customer",
          description: "Customer Description",
          pushNamed: "/customer_list"),
      ComponentButtonModel(
          svgPath: "svgPath",
          label: "Vendor",
          description: "Vendor Description",
          pushNamed: "/vendor_list"),
    ];
    return Scaffold(
      appBar: AppBar(
        leading: const CupertinoNavigationBarBackButton(),
        title: const Text("Ledger Accounts"),
      ),
      body: ListView.builder(
          itemCount: menuList.length,
          itemBuilder: (BuildContext context, int index) {
            ComponentButtonModel item = menuList[index];
            return ListTile(
              onTap: () => Navigator.of(context).pushNamed(item.pushNamed),
              leading: const Icon(Icons.abc),
              title: Text(item.label),
              subtitle: Text(item.description),
              trailing: const Icon(CupertinoIcons.chevron_forward),
            );
          }),
    );
  }
}
