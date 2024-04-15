import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rastriya_solution_flutter/model/component_button_model.dart';

class AdvanceReportPage extends StatefulWidget {
  const AdvanceReportPage({super.key});

  @override
  State<AdvanceReportPage> createState() => _AdvanceReportPageState();
}

class _AdvanceReportPageState extends State<AdvanceReportPage> {
  @override
  Widget build(BuildContext context) {
    List<ComponentButtonModel> reportList = [
      ComponentButtonModel(
          svgPath: "assets/svg/sales_bill.svg",
          label: "Sales Bill",
          description: "Sales Bill Report",
          pushNamed: "/sales_bill_list"),
      ComponentButtonModel(
          svgPath: "assets/svg/sales_return.svg",
          label: "Sales Return",
          description: "Sales Return Report",
          pushNamed: "/sales_return_list"),
      ComponentButtonModel(
          svgPath: "assets/svg/top_selling_product.svg",
          label: "Top Selling Products",
          description: "Top Selling Products Report",
          pushNamed: "/top_selling_products_report"),
      ComponentButtonModel(
          svgPath: "assets/svg/cancel_product.svg",
          label: "Cancel Products",
          description: "Cancel Products Report",
          pushNamed: "/void_product_report"),
      ComponentButtonModel(
          svgPath: "assets/svg/collection.svg",
          label: "Advance Collection Report",
          description: "Collection Report Description",
          pushNamed: "/collection_report"),
      ComponentButtonModel(
          svgPath: "assets/svg/order_report.svg",
          label: "Advance Order Report",
          description: "Order Report Description",
          pushNamed: "/order_report"),
    ];
    return Scaffold(
      appBar: AppBar(
        leading: const CupertinoNavigationBarBackButton(),
        title: const Text("Advance Reports"),
      ),
      body: ListView.builder(
          itemCount: reportList.length,
          itemBuilder: (BuildContext context, int index) {
            ComponentButtonModel item = reportList[index];
            return ListTile(
              onTap: () => Navigator.of(context)
                  .pushNamed(item.pushNamed, arguments: true),
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
