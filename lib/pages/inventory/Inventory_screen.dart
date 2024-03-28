import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rastriya_solution_flutter/model/component_button_model.dart';

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<ComponentButtonModel> menuList = [
      ComponentButtonModel(
          svgPath: "assets/svg/category.svg",
          label: "Category",
          description: "Category Description",
          pushNamed: "/category_list"),
      ComponentButtonModel(
          svgPath: "assets/svg/product.svg",
          label: "Product",
          description: "Product Description",
          pushNamed: "/product_list"),
      ComponentButtonModel(
          svgPath: "assets/svg/unit.svg",
          label: "Unit",
          description: "Unit Description",
          pushNamed: "/unit_list"),
      ComponentButtonModel(
          svgPath: "assets/svg/brand.svg",
          label: "Brand",
          description: "Brand Description",
          pushNamed: "/brand_list"),
      ComponentButtonModel(
          svgPath: "assets/svg/batch.svg",
          label: "Batch",
          description: "Batch Description",
          pushNamed: "/batch_list"),
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
