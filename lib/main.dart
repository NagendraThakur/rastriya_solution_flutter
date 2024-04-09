import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rastriya_solution_flutter/pages/account_setup/employee/cubit/employee_cubit.dart';
import 'package:rastriya_solution_flutter/pages/account_setup/store_setup/cubit/store_setup_cubit.dart';
import 'package:rastriya_solution_flutter/pages/account_setup/terminal/cubit/terminal_cubit.dart';
import 'package:rastriya_solution_flutter/pages/authentication/sign_in/cubit/sign_in_cubit.dart';
import 'package:rastriya_solution_flutter/pages/basic_reports/top_selling_products/cubit/top_selling_products_cubit.dart';
import 'package:rastriya_solution_flutter/pages/basic_reports/void_product/cubit/void_product_cubit.dart';
import 'package:rastriya_solution_flutter/pages/company/cubit/company_cubit.dart';
import 'package:rastriya_solution_flutter/pages/inventory/batch/cubit/batch_cubit.dart';
import 'package:rastriya_solution_flutter/pages/inventory/brand/cubit/brand_cubit.dart';
import 'package:rastriya_solution_flutter/pages/inventory/category/cubit/category_cubit.dart';
import 'package:rastriya_solution_flutter/pages/inventory/product/cubit/product_cubit.dart';
import 'package:rastriya_solution_flutter/pages/inventory/unit/cubit/unit_cubit.dart';
import 'package:rastriya_solution_flutter/pages/ledger_accounts/cubit/ledger_cubit.dart';
import 'package:rastriya_solution_flutter/pages/loyalty_member/cubit/loyalty_member_cubit.dart';
import 'package:rastriya_solution_flutter/pages/pos/cubit/pos_cubit.dart';
import 'package:rastriya_solution_flutter/pages/pos_setup/payment_mode/cubit/payment_mode_cubit.dart';
import 'package:rastriya_solution_flutter/pages/pos_setup/print_station/cubit/print_station_cubit.dart';
import 'package:rastriya_solution_flutter/pages/pos_setup/section/cubit/section_cubit.dart';
import 'package:rastriya_solution_flutter/pages/pos_setup/table_setup/cubit/table_cubit.dart';
import 'package:rastriya_solution_flutter/pages/sales_module/sale_return/cubit/sales_return_cubit.dart';
import 'package:rastriya_solution_flutter/pages/sales_module/sales_bill/cubit/sales_bill_cubit.dart';
import 'package:rastriya_solution_flutter/routes/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SignInCubit(),
        ),
        BlocProvider(
          create: (context) => CompanyCubit(),
        ),
        BlocProvider(
          create: (context) => TerminalCubit(),
        ),
        BlocProvider(
          create: (context) => StoreSetupCubit(),
        ),
        BlocProvider(
          create: (context) => EmployeeCubit(),
        ),
        BlocProvider(
          create: (context) => CategoryCubit(),
        ),
        BlocProvider(
          create: (context) => ProductCubit(),
        ),
        BlocProvider(
          create: (context) => LoyaltyMemberCubit(),
        ),
        BlocProvider(
          create: (context) => LedgerCubit(),
        ),
        BlocProvider(
          create: (context) => BrandCubit(),
        ),
        BlocProvider(
          create: (context) => BatchCubit(),
        ),
        BlocProvider(
          create: (context) => UnitCubit(),
        ),
        BlocProvider(
          create: (context) => PrintStationCubit(),
        ),
        BlocProvider(
          create: (context) => PaymentModeCubit(),
        ),
        BlocProvider(
          create: (context) => SectionCubit(),
        ),
        BlocProvider(
          create: (context) => TableCubit(),
        ),
        BlocProvider(
          create: (context) => PosCubit(),
        ),
        BlocProvider(
          create: (context) => TopSellingProductsCubit(),
        ),
        BlocProvider(
          create: (context) => VoidProductCubit(),
        ),
        BlocProvider(
          create: (context) => SalesBillCubit(),
        ),
        BlocProvider(
          create: (context) => SalesReturnCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme:
              const ColorScheme.highContrastLight(primary: Colors.blue),
          useMaterial3: true,
        ),
        onGenerateRoute: Routes.onGenerateRoute,
        initialRoute: "/splash",
      ),
    );
  }
}
