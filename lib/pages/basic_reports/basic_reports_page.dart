import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rastriya_solution_flutter/model/component_button_model.dart';

class BasicReportPage extends StatefulWidget {
  const BasicReportPage({super.key});

  @override
  State<BasicReportPage> createState() => _BasicReportPageState();
}

class _BasicReportPageState extends State<BasicReportPage> {
  @override
  Widget build(BuildContext context) {
    List<ComponentButtonModel> reportList = [
      ComponentButtonModel(
          svgPath: "assets/svg/top_selling_product.svg",
          label: "Today Top Selling Products",
          description: "Today Top Selling Products Report",
          pushNamed: "/top_selling_products_report"),
      ComponentButtonModel(
          svgPath: "assets/svg/cancel_product.svg",
          label: "Today Cancel Products",
          description: "Today Cancel Products Report",
          pushNamed: "/void_product_report"),
    ];
    return Scaffold(
      appBar: AppBar(
        leading: const CupertinoNavigationBarBackButton(),
        title: const Text("Reports"),
      ),
      body: ListView.builder(
          itemCount: reportList.length,
          itemBuilder: (BuildContext context, int index) {
            ComponentButtonModel item = reportList[index];
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
