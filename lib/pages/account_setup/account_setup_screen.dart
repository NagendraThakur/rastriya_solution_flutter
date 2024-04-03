import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:rastriya_solution_flutter/model/component_button_model.dart';

class AccountSetupScreen extends StatelessWidget {
  const AccountSetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<ComponentButtonModel> menuList = [
      ComponentButtonModel(
          svgPath: "assets/svg/terminal.svg",
          label: "Terminal",
          description: "Terminal Description",
          pushNamed: "/terminal_list"),
      ComponentButtonModel(
          svgPath: "assets/svg/store.svg",
          label: "Store Setup",
          description: "Store Description",
          pushNamed: "/store_setup_list"),
      ComponentButtonModel(
          svgPath: "assets/svg/account_setting.svg",
          label: "Company Setting",
          description: "Company Setting Description",
          pushNamed: "/edit_account_setting"),
      ComponentButtonModel(
          svgPath: "assets/svg/employee.svg",
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
              leading: SvgPicture.asset(
                item.svgPath,
                width: 50,
              ),
              title: Text(item.label),
              subtitle: Text(item.description),
              trailing: const Icon(CupertinoIcons.chevron_forward),
            );
          }),
    );
  }
}
