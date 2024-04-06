import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rastriya_solution_flutter/model/component_button_model.dart';

class PosSetupScreen extends StatelessWidget {
  const PosSetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<ComponentButtonModel> menuList = [
      ComponentButtonModel(
          svgPath: "assets/svg/print_station.svg",
          label: "Printers",
          description: "Printers Description",
          pushNamed: "/print_station_list"),
      ComponentButtonModel(
          svgPath: "assets/svg/payment_mode.svg",
          label: "Payment Mode",
          description: "Payment Mode Description",
          pushNamed: "/payment_mode_list"),
      ComponentButtonModel(
          svgPath: "assets/svg/table.svg",
          label: "Table",
          description: "Table Description",
          pushNamed: "/table_list"),
    ];
    return Scaffold(
      appBar: AppBar(
        leading: const CupertinoNavigationBarBackButton(),
        title: const Text("POS Setup"),
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
