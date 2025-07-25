import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rastriya_solution_flutter/constants/config.dart';
import 'package:rastriya_solution_flutter/data/repository/get_repository.dart';
import 'package:rastriya_solution_flutter/model/company_model.dart';
import 'package:rastriya_solution_flutter/model/grid_item_model.dart';
import 'package:rastriya_solution_flutter/model/permission_model.dart';
import 'package:rastriya_solution_flutter/model/store_model.dart';
import 'package:rastriya_solution_flutter/model/terminal_response_model.dart';
import 'package:rastriya_solution_flutter/model/user_model.dart';
import 'package:rastriya_solution_flutter/pages/authentication/sign_in/cubit/sign_in_cubit.dart';
import 'package:rastriya_solution_flutter/pages/dashboard/portion/menu_card.dart';
import 'package:rastriya_solution_flutter/shared/shared_pre.dart';
import 'package:rastriya_solution_flutter/shared/text_style.dart';
import 'package:rastriya_solution_flutter/widgets/textfield.dart';

class DashboardScreen extends StatefulWidget {
  final CompanyModel companyInfo;

  const DashboardScreen({super.key, required this.companyInfo});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  void fetchAccountPermission() async {
    Config.terminalInfo = null;
    Config.storeInfo = null;
    final response = await GetRepository().getRequest(
        path: GetRepository.accountPermission,
        additionalHeader: {"company-id": Config.companyInfo!.id});
    handlePermissionResponse(response: response);
    assignAssetsUpload();
  }

  void assignAssetsUpload() async {
    Config.assetsUpload = await getPreference(key: "assetsUpload");
  }

  void handlePermissionResponse({required dynamic response}) {
    final PermissionModel permissionResponse =
        PermissionModel.fromJson(response);
    Config.permissionInfo = permissionResponse;
    fetchTerminal(
        terminalId: permissionResponse.terminalId,
        storeId: permissionResponse.storeId);
  }

  void fetchTerminal(
      {required String? terminalId, required String? storeId}) async {
    if (terminalId!.isNotEmpty && terminalId != "0") {
      final response = await GetRepository().getRequest(
          path: "${GetRepository.posTerminal}/$terminalId/edit",
          additionalHeader: {"company-id": Config.companyInfo!.id});

      final TerminalResponse terminalResponse =
          TerminalResponse.fromJson(response);
      if (terminalResponse.terminal != null) {
        Config.terminalInfo = terminalResponse.terminal;
      }
      if (terminalResponse.storeLists != null) {
        for (var store in terminalResponse.storeLists!) {
          if (store.id == storeId) {
            Config.storeInfo = store;
          }
        }
      }
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchAccountPermission();
  }

  @override
  Widget build(BuildContext context) {
    List<DashboardMenuModel> menuList = [
      DashboardMenuModel(
          permission: Config.permissionInfo?.posUser == "1" ? true : false,
          navigationPath: Config.companyInfo?.industryId == "1"
              ? "/restro_main"
              : "/retail_main",
          imagePath: "assets/svg/pos.svg",
          label: "POS"),
      DashboardMenuModel(
          permission: Config.permissionInfo?.isAdmin == "1" ? true : false,
          navigationPath: "/account_setup",
          imagePath: "assets/svg/company_setup.svg",
          label: "Company Setup"),
      DashboardMenuModel(
          permission: Config.permissionInfo?.isAdmin == "1" ? true : false,
          navigationPath: "/inventory",
          imagePath: "assets/svg/inventory.svg",
          label: "Inventory"),
      DashboardMenuModel(
          permission: Config.permissionInfo?.isAdmin == "1" ? true : false,
          navigationPath: "/loyalty_member_list",
          imagePath: "assets/svg/loyalty_member.svg",
          label: "Loyalty Member"),
      DashboardMenuModel(
          permission: Config.permissionInfo?.isAdmin == "1" ? true : false,
          navigationPath: "/ledger_accounts",
          imagePath: "assets/svg/ledger_account.svg",
          label: "Ledger Account"),
      DashboardMenuModel(
          permission: Config.permissionInfo?.isAdmin == "1" ? true : false,
          navigationPath: "/pos_setup",
          imagePath: "assets/svg/pos_setup.svg",
          label: "Pos Setup"),
      DashboardMenuModel(
          permission: Config.permissionInfo?.isAdmin == "1" ? true : false,
          navigationPath: "/sales_module_main",
          imagePath: "assets/svg/purchase.svg",
          label: "Sales Module"),
      DashboardMenuModel(
          permission: Config.permissionInfo?.isAdmin == "1" ? true : false,
          navigationPath: "/purchase_module_main",
          imagePath: "assets/svg/purchase.svg",
          label: "Purchase Module"),
      DashboardMenuModel(
          permission: Config.permissionInfo?.isAdmin == "1" ? true : false,
          navigationPath: "/basic_reports",
          imagePath: "assets/svg/advance_report.svg",
          label: "Basic Reports"),
      DashboardMenuModel(
          permission: Config.permissionInfo?.isAdmin == "1" ? true : false,
          navigationPath: "/advance_report",
          imagePath: "assets/svg/report.svg",
          label: "Advance Report"),
      DashboardMenuModel(
          permission: true,
          navigationPath: "/setting",
          imagePath: "assets/svg/setting.svg",
          label: "Setting"),
      DashboardMenuModel(
          permission: false,
          navigationPath: "/",
          imagePath: "assets/svg/help_desk.svg",
          label: "Help"),
    ];
    final loginData =
        (BlocProvider.of<SignInCubit>(context).state as SignInSuccess)
            .authModel;
    final User userInfo = loginData.user;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120,
        title: RichText(
          text: TextSpan(
            style: kHeading2TextStyle,
            children: [
              TextSpan(
                text: "Welcome\n",
                style: TextStyle(
                  fontFamily: 'Manrope',
                  color: Colors.blue.shade800,
                ),
              ),
              TextSpan(
                text: "${userInfo.username}\n",
                style: TextStyle(
                  fontFamily: 'Manrope',
                  color: Colors.grey.shade900,
                ),
              ),
              TextSpan(
                text: Config.storeInfo?.name ?? "",
                style: TextStyle(
                  fontFamily: 'Manrope',
                  color: Colors.grey.shade900,
                ),
              ),
              TextSpan(
                text: "\n${Config.companyInfo?.companyName}",
                style: TextStyle(
                  fontFamily: 'Manrope',
                  color: Colors.grey.shade900,
                  fontSize: 8,
                ),
              ),
            ],
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          Column(
            children: [
              Text(
                Config.companyInfo?.fiscalYearInfo?.name ?? "Fiscal Year: N/A",
                style: kSubtitleTextStyle,
              ),
              Text(
                Config.terminalInfo?.terminalName ?? "Terminal: N/A",
                style: kSmallRegularTextStyle.copyWith(color: Colors.black),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: const Border(
                  bottom: BorderSide(
                    color: Colors.blue,
                    width: 2.0,
                  ),
                ),
              ),
              child: null,
            ),
            const CustomTextField(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              prefixIcon: Icon(CupertinoIcons.search),
              hintText: "Search For Everything",
              filled: false,
              enabled: false,
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 100.0,
                mainAxisExtent: 90,
                mainAxisSpacing: 2,
                crossAxisSpacing: 10,
              ),
              itemCount: menuList.length,
              itemBuilder: (BuildContext context, int index) {
                final menuItem = menuList[index];
                return MenuCard(menuItem: menuItem);
              },
            ),
          ],
        ),
      ),
    );
  }
}
