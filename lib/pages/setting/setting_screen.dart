import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rastriya_solution_flutter/model/component_button_model.dart';
import 'package:rastriya_solution_flutter/pages/setting/logout/logout.dart';
import 'package:rastriya_solution_flutter/widgets/button.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<ComponentButtonModel> menuList = [
      ComponentButtonModel(
          svgPath: "assets/svg/switch.svg",
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
              leading: SvgPicture.asset(
                item.svgPath,
                width: 50,
              ),
              title: Text(item.label),
              subtitle: Text(item.description),
              trailing: const Icon(CupertinoIcons.chevron_forward),
            );
          }),
      bottomNavigationBar: CustomButton(
          secondaryButton: true,
          horizontalPadding: 10,
          buttonText: "Log Out",
          onPressed: () => showDialog(
                context: context,
                builder: (_) {
                  return const LogOutDialog();
                },
              )),
    );
  }
}
