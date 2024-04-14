import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rastriya_solution_flutter/model/batch_model.dart';
import 'package:rastriya_solution_flutter/model/bill_model.dart';
import 'package:rastriya_solution_flutter/model/brand_model.dart';
import 'package:rastriya_solution_flutter/model/category_model.dart';
import 'package:rastriya_solution_flutter/model/company_model.dart';
import 'package:rastriya_solution_flutter/model/employee_model.dart';
import 'package:rastriya_solution_flutter/model/ledger_model.dart';
import 'package:rastriya_solution_flutter/model/loyalty_member_model.dart';
import 'package:rastriya_solution_flutter/model/payment_mode_model.dart';
import 'package:rastriya_solution_flutter/model/print_station_model.dart';
import 'package:rastriya_solution_flutter/model/product_model.dart';
import 'package:rastriya_solution_flutter/model/purchase_model.dart';
import 'package:rastriya_solution_flutter/model/sales_order_model.dart';
import 'package:rastriya_solution_flutter/model/section_model.dart';
import 'package:rastriya_solution_flutter/model/store_model.dart';
import 'package:rastriya_solution_flutter/model/table_model.dart';
import 'package:rastriya_solution_flutter/model/terminal_model.dart';
import 'package:rastriya_solution_flutter/model/unit_model.dart';
import 'package:rastriya_solution_flutter/pages/account_setup/account_setting/cubit/account_setting_cubit.dart';
import 'package:rastriya_solution_flutter/pages/account_setup/account_setting/edit_account_setting.dart';
import 'package:rastriya_solution_flutter/pages/account_setup/account_setup_screen.dart';
import 'package:rastriya_solution_flutter/pages/account_setup/employee/edit_employee.dart';
import 'package:rastriya_solution_flutter/pages/account_setup/employee/employee_list.dart';
import 'package:rastriya_solution_flutter/pages/account_setup/store_setup/edit_store_setup.dart';
import 'package:rastriya_solution_flutter/pages/account_setup/store_setup/store_setup_list.dart';
import 'package:rastriya_solution_flutter/pages/account_setup/terminal/terminal_edit.dart';
import 'package:rastriya_solution_flutter/pages/account_setup/terminal/terminal_list.dart';
import 'package:rastriya_solution_flutter/pages/advance_reports/advance_report_page.dart';
import 'package:rastriya_solution_flutter/pages/advance_reports/top_selling_products/advance_top_selling_products_list.dart';
import 'package:rastriya_solution_flutter/pages/authentication/sign_in/presentation/sign_in_screen.dart';
import 'package:rastriya_solution_flutter/pages/authentication/sign_up/sign_up_screen.dart';
import 'package:rastriya_solution_flutter/pages/basic_reports/void_product/void_product_list.dart';
import 'package:rastriya_solution_flutter/pages/company/company_list_screen.dart';
import 'package:rastriya_solution_flutter/pages/company/edit_company_screen.dart';
import 'package:rastriya_solution_flutter/pages/dashboard/dashboard_screen.dart';
import 'package:rastriya_solution_flutter/pages/invalid/invalid_page.dart';
import 'package:rastriya_solution_flutter/pages/inventory/Inventory_screen.dart';
import 'package:rastriya_solution_flutter/pages/inventory/batch/batch_list.dart';
import 'package:rastriya_solution_flutter/pages/inventory/batch/edit_batch.dart';
import 'package:rastriya_solution_flutter/pages/inventory/brand/brand_list.dart';
import 'package:rastriya_solution_flutter/pages/inventory/brand/edit_brand.dart';
import 'package:rastriya_solution_flutter/pages/inventory/category/category_list.dart';
import 'package:rastriya_solution_flutter/pages/inventory/category/edit_category.dart';
import 'package:rastriya_solution_flutter/pages/inventory/product/edit_product.dart';
import 'package:rastriya_solution_flutter/pages/inventory/product/product_list.dart';
import 'package:rastriya_solution_flutter/pages/inventory/unit/edit_unit.dart';
import 'package:rastriya_solution_flutter/pages/inventory/unit/unit_list.dart';
import 'package:rastriya_solution_flutter/pages/ledger_accounts/customer/customer_list.dart';
import 'package:rastriya_solution_flutter/pages/ledger_accounts/customer/edit_customer.dart';
import 'package:rastriya_solution_flutter/pages/ledger_accounts/general_ledger/edit_general_ledger.dart';
import 'package:rastriya_solution_flutter/pages/ledger_accounts/general_ledger/general_ledger_list.dart';
import 'package:rastriya_solution_flutter/pages/ledger_accounts/ledger_accounts_screen.dart';
import 'package:rastriya_solution_flutter/pages/ledger_accounts/vendor/edit_vendor.dart';
import 'package:rastriya_solution_flutter/pages/ledger_accounts/vendor/vendor_list.dart';
import 'package:rastriya_solution_flutter/pages/loyalty_member/edit_loyalty_member.dart';
import 'package:rastriya_solution_flutter/pages/loyalty_member/loyalty_meber_list.dart';
import 'package:rastriya_solution_flutter/pages/pos/presentation/global/pay/pay_page.dart';
import 'package:rastriya_solution_flutter/pages/pos/presentation/restro/category_product/category_product_page.dart';
import 'package:rastriya_solution_flutter/pages/pos/presentation/global/review_order/review_order_page.dart';
import 'package:rastriya_solution_flutter/pages/pos/presentation/global/cart/cart_page.dart';
import 'package:rastriya_solution_flutter/pages/pos/presentation/restro/kot/kot_page.dart';
import 'package:rastriya_solution_flutter/pages/pos/presentation/restro/main/restro_main.dart';
import 'package:rastriya_solution_flutter/pages/pos/presentation/restro/void_order/void_order_page.dart';
import 'package:rastriya_solution_flutter/pages/pos/presentation/retail/main/retail_main.dart';
import 'package:rastriya_solution_flutter/pages/pos/presentation/retail/product/product_page.dart';
import 'package:rastriya_solution_flutter/pages/pos_setup/payment_mode/edit_payment_mode.dart';
import 'package:rastriya_solution_flutter/pages/pos_setup/payment_mode/payment_mode_list.dart';
import 'package:rastriya_solution_flutter/pages/pos_setup/pos_setup_screen.dart';
import 'package:rastriya_solution_flutter/pages/pos_setup/print_station/edit_print_station.dart';
import 'package:rastriya_solution_flutter/pages/pos_setup/print_station/print_station_list.dart';
import 'package:rastriya_solution_flutter/pages/pos_setup/section/edit_section.dart';
import 'package:rastriya_solution_flutter/pages/pos_setup/section/section_list.dart';
import 'package:rastriya_solution_flutter/pages/pos_setup/table_setup/edit_table_setup.dart';
import 'package:rastriya_solution_flutter/pages/pos_setup/table_setup/table_setup_list.dart';
import 'package:rastriya_solution_flutter/pages/basic_reports/basic_reports_page.dart';
import 'package:rastriya_solution_flutter/pages/basic_reports/top_selling_products/top_selling_products_list.dart';
import 'package:rastriya_solution_flutter/pages/purchase_module/product/purchase_production_search.dart';
import 'package:rastriya_solution_flutter/pages/purchase_module/purchase_module_main.dart';
import 'package:rastriya_solution_flutter/pages/purchase_module/purchase_order/edit_purchase_order.dart';
import 'package:rastriya_solution_flutter/pages/purchase_module/purchase_order/purchase_order_list.dart';
import 'package:rastriya_solution_flutter/pages/sales_module/sale_return/edit_sales_return.dart';
import 'package:rastriya_solution_flutter/pages/sales_module/sale_return/sales_return_list.dart';
import 'package:rastriya_solution_flutter/pages/sales_module/sales_bill/edit_sales_bill.dart';
import 'package:rastriya_solution_flutter/pages/sales_module/sales_bill/sales_bill_list.dart';
import 'package:rastriya_solution_flutter/pages/sales_module/sales_module_main.dart';
import 'package:rastriya_solution_flutter/pages/search_return/loyalty_member/loyalty_member_search.dart';
import 'package:rastriya_solution_flutter/pages/setting/setting_screen.dart';
import 'package:rastriya_solution_flutter/pages/splash-screen/splash_screen.dart';

class Routes {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      //Sales Module
      case "/sales_module_main":
        return MaterialPageRoute(
            builder: (context) => const SalesModuleMainPage());
      case "/sales_bill_list":
        final bool? showSummary = settings.arguments as bool?;
        return MaterialPageRoute(
            builder: (context) => SalesBillListScreen(
                  showSummary: showSummary,
                ));
      case "/edit_sales_bill":
        final BillModel bill = settings.arguments as BillModel;
        return MaterialPageRoute(
            builder: (context) => EditSalesBill(
                  bill: bill,
                ));
      case "/sales_return_list":
        final bool? showSummary = settings.arguments as bool?;
        return MaterialPageRoute(
            builder: (context) => SalesReturnListScreen(
                  showSummary: showSummary,
                ));
      case "/edit_sales_return":
        final BillModel bill = settings.arguments as BillModel;
        return MaterialPageRoute(
            builder: (context) => EditSalesReturn(
                  bill: bill,
                ));
      //Purchase Module
      case "/purchase_module_main":
        return MaterialPageRoute(
            builder: (context) => const PurchaseModuleMainPage());

      case "/purchase_product_Search":
        return MaterialPageRoute(
            builder: (context) => const PurchaseProductSearchPage());

      case "/purchase_order_list":
        final bool? showSummary = settings.arguments as bool?;
        return MaterialPageRoute(
            builder: (context) => PurchaseOrderListPage(
                  showSummary: showSummary,
                ));
      case "/edit_purchase_order":
        PurchaseModel? purchaseInfo = settings.arguments as PurchaseModel?;
        return MaterialPageRoute(
            builder: (context) => EditPurchaseOrder(
                  purchaseInfo: purchaseInfo,
                ));
      case "/dashboard":
        final CompanyModel companyInfo = settings.arguments as CompanyModel;
        return MaterialPageRoute(
          builder: (context) => DashboardScreen(
            companyInfo: companyInfo,
          ),
        );
      case "/company_list":
        return MaterialPageRoute(
            builder: (context) => const CompanyListScreen());
      case "/edit_company":
        return MaterialPageRoute(builder: (context) => EditCompanyScreen());
      case "/edit_account_setting":
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => AccountSettingCubit(),
                  child: const EditAccountSetting(),
                ));
      case "/splash":
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case "/sign_in":
        return MaterialPageRoute(builder: (context) => SignInScreen());
      case "/sign_up":
        return MaterialPageRoute(builder: (context) => SignUpScreen());
      case "/account_setup":
        return MaterialPageRoute(
            builder: (context) => const AccountSetupScreen());
      case "/terminal_list":
        return MaterialPageRoute(
            builder: (context) => const TerminalListScreen());
      case "/terminal_edit":
        final Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;

        final TerminalModel? terminal = arguments['terminal'];
        final List<StoreModel> storeList = arguments['storeList'];

        return MaterialPageRoute(
            builder: (context) => TerminalEditScreen(
                  terminal: terminal,
                  storeList: storeList,
                ));

      case "/store_setup_list":
        return MaterialPageRoute(
            builder: (context) => const StoreSetupListScreen());

      case "/edit_store_setup":
        final StoreModel? store = settings.arguments as StoreModel?;
        return MaterialPageRoute(
            builder: (context) => EditStoreSetupScreen(
                  store: store,
                ));

      case "/employee_list":
        return MaterialPageRoute(
            builder: (context) => const EmployeeListScreen());

      case "/edit_employee":
        final Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        final EmployeeModel? employee = arguments['employee'];
        final List<TerminalModel> terminalList = arguments['terminalList'];
        final List<StoreModel> storeList = arguments['storeList'];
        return MaterialPageRoute(
            builder: (context) => EditEmployeeScreen(
                  employee: employee,
                  terminalList: terminalList,
                  storeList: storeList,
                ));

      case "/inventory":
        return MaterialPageRoute(builder: (context) => const InventoryScreen());
      case "/edit_category":
        final Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        final CategoryModel? category = arguments['category'];
        final List<PrintStationModel> printerList = arguments['printerList'];
        return MaterialPageRoute(
            builder: (context) => EditCategoryScreen(
                  category: category,
                  printerList: printerList,
                ));
      case "/category_list":
        return MaterialPageRoute(
            builder: (context) => const CategoryListScreen());
      case "/edit_product":
        final Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        final ProductModel? product = arguments['product'];
        final List<CategoryModel> categoryList = arguments['categoryList'];
        final List<UnitModel> unitList = arguments['unitList'];

        return MaterialPageRoute(
            builder: (context) => EditProductScreen(
                  product: product,
                  categoryList: categoryList,
                  unitList: unitList,
                ));
      case "/product_list":
        return MaterialPageRoute(
            builder: (context) => const ProductListScreen());
      case "/brand_list":
        return MaterialPageRoute(builder: (context) => const BrandListScreen());
      case "/edit_brand":
        final BrandModel? brand = settings.arguments as BrandModel?;
        return MaterialPageRoute(
            builder: (context) => EditBrandScreen(
                  brand: brand,
                ));
      case "/edit_batch":
        final Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        final List<ProductModel> productList = arguments['productList'];
        final BatchModel? batch = arguments['batch'];
        return MaterialPageRoute(
            builder: (context) => EditBatchScreen(
                  productList: productList,
                  batch: batch,
                ));
      case "/batch_list":
        return MaterialPageRoute(builder: (context) => const BatchListScreen());

      case "/unit_list":
        return MaterialPageRoute(builder: (context) => const UnitListScreen());
      case "/edit_unit":
        final UnitModel? unit = settings.arguments as UnitModel?;
        return MaterialPageRoute(
            builder: (context) => EditUnitScreen(
                  unit: unit,
                ));
      case "/edit_loyalty_member":
        final LoyaltyMemberModel? loyaltyMember =
            settings.arguments as LoyaltyMemberModel?;
        return MaterialPageRoute(
            builder: (context) => EditLoyaltyMemberScreen(
                  loyaltyMember: loyaltyMember,
                ));
      case "/loyalty_member_list":
        return MaterialPageRoute(
            builder: (context) => const LoyaltyMemberList());

      case "/loyalty_member_search":
        return MaterialPageRoute(
            builder: (context) => const LoyaltyMemberSearch());

      case "/ledger_accounts":
        return MaterialPageRoute(
            builder: (context) => const LedgerAccountScreen());

      case "/customer_list":
        return MaterialPageRoute(builder: (context) => const CustomerList());
      case "/edit_customer":
        final LedgerModel? ledger = settings.arguments as LedgerModel?;
        return MaterialPageRoute(
            builder: (context) => EditCustomer(
                  ledger: ledger,
                ));

      case "/vendor_list":
        return MaterialPageRoute(builder: (context) => const VendorList());
      case "/edit_vendor":
        final LedgerModel? ledger = settings.arguments as LedgerModel?;
        return MaterialPageRoute(
            builder: (context) => EditVendor(
                  ledger: ledger,
                ));
      case "/general_ledger_list":
        return MaterialPageRoute(
            builder: (context) => const GeneralLedgerList());
      case "/edit_general_ledger":
        final LedgerModel? ledger = settings.arguments as LedgerModel?;
        return MaterialPageRoute(
            builder: (context) => EditGeneralLedger(
                  ledger: ledger,
                ));
      case "/pos_setup":
        return MaterialPageRoute(
          builder: (context) => const PosSetupScreen(),
        );
      case "/print_station_list":
        return MaterialPageRoute(
          builder: (context) => const PrintStationList(),
        );
      case "/edit_print_station":
        final PrintStationModel? printStation =
            settings.arguments as PrintStationModel?;
        return MaterialPageRoute(
          builder: (context) => EditPrintStation(
            printstation: printStation,
          ),
        );
      case "/payment_mode_list":
        return MaterialPageRoute(
          builder: (context) => const PaymentModeListScreen(),
        );
      case "/edit_payment_mode":
        final PaymentModeModel? paymentMode =
            settings.arguments as PaymentModeModel?;
        return MaterialPageRoute(
          builder: (context) => EditPaymentModeScreen(
            paymentModeInfo: paymentMode,
          ),
        );
      case "/section_list":
        return MaterialPageRoute(
          builder: (context) => const SectionListScreen(),
        );
      case "/edit_section":
        final SectionModel? section = settings.arguments as SectionModel?;
        return MaterialPageRoute(
          builder: (context) => EditSectionScreen(
            section: section,
          ),
        );

      case "/table_list":
        return MaterialPageRoute(
          builder: (context) => const TableSetupList(),
        );
      case "/edit_table":
        final TableModel? table = settings.arguments as TableModel?;
        return MaterialPageRoute(
          builder: (context) => EditTableSetup(
            table: table,
          ),
        );
      case "/setting":
        return MaterialPageRoute(builder: (context) => const SettingPage());

      //Reports Modules
      case "/basic_reports":
        return MaterialPageRoute(builder: (context) => const BasicReportPage());
      case "/top_selling_products_report":
        return MaterialPageRoute(
            builder: (context) => const TopSellingProductsListPage());
      case "/void_product_report":
        bool? showDateFilter = settings.arguments as bool?;
        return MaterialPageRoute(
            builder: (context) => VoidProductListPage(
                  showDateFilter: showDateFilter,
                ));
      case "/advance_report":
        return MaterialPageRoute(
            builder: (context) => const AdvanceReportPage());
      case "/advance_top_selling_products_report":
        return MaterialPageRoute(
            builder: (context) => const AdvanceTopSellingProductsListPage());

      //POS Routes
      case "/restro_main":
        return MaterialPageRoute(
          builder: (context) => const RestroMainPage(),
        );
      case "/retail_main":
        return MaterialPageRoute(
          builder: (context) => const RetailMainPage(),
        );
      case "/category_product":
        bool? payCart = settings.arguments as bool?;
        return MaterialPageRoute(
          builder: (context) => CategoryProductPage(
            payCart: payCart,
          ),
        );
      case "/product":
        return MaterialPageRoute(
          builder: (context) => const ProductPage(),
        );
      case "/cart":
        bool? payButton = settings.arguments as bool?;
        return MaterialPageRoute(
          builder: (context) => CartPage(
            payButton: payButton,
          ),
        );
      case "/kot":
        OrderBillModel orderBill = settings.arguments as OrderBillModel;
        return MaterialPageRoute(
          builder: (context) => KotPage(
            orderBill: orderBill,
          ),
        );
      case "/review_order":
        return MaterialPageRoute(
          builder: (context) => ReviewOrderPage(),
        );
      case "/void_order":
        return MaterialPageRoute(
          builder: (context) => VoidOrderPage(),
        );
      case "/pay":
        return MaterialPageRoute(
          builder: (context) => const PayPage(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const InvalidPage(),
        );
    }
  }
}
