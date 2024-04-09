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
          svgPath: "assets/svg/top_selling_product.svg",
          label: "Top Selling Products",
          description: "Top Selling Products Report",
          pushNamed: "/advance_top_selling_products_report"),
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
