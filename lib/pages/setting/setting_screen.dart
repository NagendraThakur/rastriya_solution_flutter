import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rastriya_solution_flutter/model/component_button_model.dart';
import 'package:rastriya_solution_flutter/widgets/button.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<ComponentButtonModel> menuList = [
      ComponentButtonModel(
          svgPath: "svgPath",
          label: "Switch Company",
          description: "Switch Company Description",
          pushNamed: "/company_list"),
    ];
    return Scaffold(
      appBar: AppBar(
        leading: const CupertinoNavigationBarBackButton(),
        title: const Text("Setting"),
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
      bottomNavigationBar: CustomButton(
          secondaryButton: true,
          horizontalPadding: 10,
          buttonText: "Log Out",
          onPressed: () {}),
    );
  }
}
