import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rastriya_solution_flutter/helper/dialog_utility.dart';
import 'package:rastriya_solution_flutter/helper/toastification.dart';
import 'package:rastriya_solution_flutter/model/brand_model.dart';
import 'package:rastriya_solution_flutter/pages/inventory/brand/cubit/brand_cubit.dart';
import 'package:rastriya_solution_flutter/shared/text_style.dart';
import 'package:rastriya_solution_flutter/widgets/data_table.dart';
import 'package:rastriya_solution_flutter/widgets/list_view_container.dart';
import 'package:rastriya_solution_flutter/widgets/shimmer.dart';
import 'package:toastification/toastification.dart';

class BrandListScreen extends StatefulWidget {
  const BrandListScreen({super.key});

  @override
  State<BrandListScreen> createState() => _BrandListScreenState();
}

class _BrandListScreenState extends State<BrandListScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero,
        () => BlocProvider.of<BrandCubit>(context).fetchBrands());
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return BlocConsumer<BrandCubit, BrandState>(
      listener: (context, state) {
        if (state.isLoading == true) {
          Future.delayed(
              Duration.zero, () => DialogUtils.showProcessingDialog(context));
        } else if (state.isLoading == false) {
          Navigator.of(context).pop();
        } else if (state.message != null) {
          showToastification(
              context: context,
              message: state.message!,
              toastificationType: state.message!.contains("Failed")
                  ? ToastificationType.error
                  : ToastificationType.success);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: const CupertinoNavigationBarBackButton(),
            title: const Text("Brands"),
          ),
          body: state.isFetching == true
              ? const CustomShimmer()
              : ListView.builder(
                  itemCount: state.brandList!.length,
                  itemBuilder: (BuildContext context, int index) {
                    BrandModel brand = state.brandList![index];
                    return ListViewContainer(
                        child: ListTile(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed("/edit_brand", arguments: brand);
                      },
                      leading: CircleAvatar(
                          child:
                              Text(brand.name.substring(0, 1).toUpperCase())),
                      title: Text(brand.name.toUpperCase()),
                    ));
                  }),
          // : SingleChildScrollView(
          //     child: CustomDataTable(
          //         columnNames: const ["Name"],
          //         createRow: createRow(data: state.brandList)),
          //   ),
          floatingActionButton: FloatingActionButton.extended(
              icon: const Icon(CupertinoIcons.add),
              label: Text(
                "Add Brand",
                style: kSubtitleRegularTextStyle,
              ),
              onPressed: () => Navigator.of(context).pushNamed("/edit_brand")),
        );
      },
    );
  }

  List<DataRow>? createRow({required List<BrandModel>? data}) {
    if (data!.isEmpty) {
      return null;
    }

    return data.map((BrandModel item) {
      return DataRow(
        selected: false,
        cells: [
          DataCell(Text(item.name)),
        ],
        onSelectChanged: (value) {
          Navigator.of(context).pushNamed("/edit_brand", arguments: item);
        },
      );
    }).toList();
  }
}
