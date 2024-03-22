import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rastriya_solution_flutter/model/component_button_model.dart';

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<ComponentButtonModel> menuList = [
      ComponentButtonModel(
          svgPath: "svgPath",
          label: "Category",
          description: "Category Description",
          pushNamed: "/category_list"),
      ComponentButtonModel(
          svgPath: "svgPath",
          label: "Product",
          description: "Product Description",
          pushNamed: "/product_list"),
      ComponentButtonModel(
          svgPath: "svgPath",
          label: "Brand",
          description: "Brand Description",
          pushNamed: "/brand_list"),
    ];
    return Scaffold(
      appBar: AppBar(
        leading: const CupertinoNavigationBarBackButton(),
        title: const Text("Inventory"),
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
