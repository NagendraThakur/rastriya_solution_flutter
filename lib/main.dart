import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rastriya_solution_flutter/pages/account_setup/employee/cubit/employee_cubit.dart';
import 'package:rastriya_solution_flutter/pages/account_setup/store_setup/cubit/store_setup_cubit.dart';
import 'package:rastriya_solution_flutter/pages/account_setup/terminal/cubit/terminal_cubit.dart';
import 'package:rastriya_solution_flutter/pages/authentication/sign_in/cubit/sign_in_cubit.dart';
import 'package:rastriya_solution_flutter/pages/company/cubit/company_cubit.dart';
import 'package:rastriya_solution_flutter/pages/inventory/batch/cubit/batch_cubit.dart';
import 'package:rastriya_solution_flutter/pages/inventory/brand/cubit/brand_cubit.dart';
import 'package:rastriya_solution_flutter/pages/inventory/category/cubit/category_cubit.dart';
import 'package:rastriya_solution_flutter/pages/inventory/product/cubit/product_cubit.dart';
import 'package:rastriya_solution_flutter/pages/ledger_accounts/cubit/ledger_cubit.dart';
import 'package:rastriya_solution_flutter/pages/loyalty_member/cubit/loyalty_member_cubit.dart';
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
