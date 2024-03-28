import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rastriya_solution_flutter/constants/config.dart';
import 'package:rastriya_solution_flutter/data/repository/get_repository.dart';
import 'package:rastriya_solution_flutter/model/company_model.dart';
import 'package:rastriya_solution_flutter/model/grid_item_model.dart';
import 'package:rastriya_solution_flutter/model/permission_model.dart';
import 'package:rastriya_solution_flutter/model/terminal_response_model.dart';
import 'package:rastriya_solution_flutter/model/user_model.dart';
import 'package:rastriya_solution_flutter/pages/authentication/sign_in/cubit/sign_in_cubit.dart';
import 'package:rastriya_solution_flutter/pages/dashboard/portion/menu_card.dart';
import 'package:rastriya_solution_flutter/shared/shared_pre.dart';
import 'package:rastriya_solution_flutter/shared/text_style.dart';

class DashboardScreen extends StatefulWidget {
  final CompanyModel companyInfo;

  const DashboardScreen({super.key, required this.companyInfo});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  void fetchAccountPermission() async {
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
    fetchTerminal(terminalId: permissionResponse.terminalId);
  }

  void fetchTerminal({required String? terminalId}) async {
    if (terminalId!.isNotEmpty) {
      final response = await GetRepository().getRequest(
          path: "${GetRepository.posTerminal}/$terminalId/edit",
          additionalHeader: {"company-id": Config.companyInfo!.id});

      final TerminalResponse terminalResponse =
          TerminalResponse.fromJson(response);
      if (terminalResponse.terminal != null) {
        Config.terminalInfo = terminalResponse.terminal;
        if (terminalResponse.storeLists != null) {
          for (var element in terminalResponse.storeLists!) {
            if (element.id == Config.terminalInfo!.storeId) {
              Config.storeInfo = element;
            }
          }
        }
      }
      setState(() {});
    }
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
          permission: true,
          navigationPath: "/account_setup",
          imagePath: "assets/svg/company_setup.svg",
          label: "Company Setup"),
      DashboardMenuModel(
          permission: true,
          navigationPath: "/inventory",
          imagePath: "assets/svg/inventory.svg",
          label: "Inventory"),
      DashboardMenuModel(
          permission: true,
          navigationPath: "/loyalty_member_list",
          imagePath: "assets/svg/loyalty_member.svg",
          label: "Loyalty Member"),
      DashboardMenuModel(
          permission: true,
          navigationPath: "/ledger_accounts",
          imagePath: "assets/svg/ledger_account.svg",
          label: "Ledger Account"),
      DashboardMenuModel(
          permission: true,
          navigationPath: "/pos_setup",
          imagePath: "assets/svg/pos_setup.svg",
          label: "Pos Setup"),
      DashboardMenuModel(
          permission: true,
          navigationPath: "/setting",
          imagePath: "assets/svg/setting.svg",
          label: "Setting"),
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
              const TextSpan(
                text: "Welcome\n",
                style: TextStyle(
                  fontFamily: 'Manrope',
                  color: Colors.blue,
                ),
              ),
              TextSpan(
                text: "${userInfo.username}\n",
                style: const TextStyle(
                  fontFamily: 'Manrope',
                  color: Colors.grey,
                ),
              ),
              TextSpan(
                text: Config.storeInfo?.name ?? "",
                style: const TextStyle(
                  fontFamily: 'Manrope',
                  color: Colors.grey,
                ),
              ),
              TextSpan(
                text: "\n${Config.companyInfo?.companyName}",
                style: const TextStyle(
                  fontFamily: 'Manrope',
                  color: Colors.grey,
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
                style: kSmallRegularTextStyle,
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: GridView.builder(
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
      ),
    );
  }
}
