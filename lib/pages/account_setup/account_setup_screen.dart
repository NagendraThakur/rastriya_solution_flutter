import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rastriya_solution_flutter/model/component_button_model.dart';

class AccountSetupScreen extends StatelessWidget {
  const AccountSetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<ComponentButtonModel> menuList = [
      ComponentButtonModel(
          svgPath: "svgPath",
          label: "Terminal",
          description: "Terminal Description",
          pushNamed: "/terminal_list"),
      ComponentButtonModel(
          svgPath: "svgPath",
          label: "Store Setup",
          description: "Store Description",
          pushNamed: "/store_setup_list"),
      ComponentButtonModel(
          svgPath: "svgPath",
          label: "Account Setting",
          description: "Account Setting Description",
          pushNamed: "/account_setting"),
      ComponentButtonModel(
          svgPath: "svgPath",
          label: "Staff",
          description: "Staff Description",
          pushNamed: "/employee_list"),
    ];
    return Scaffold(
      appBar: AppBar(
        leading: const CupertinoNavigationBarBackButton(),
        title: const Text("Company Setup"),
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
