import 'package:flutter/material.dart';
import 'package:rastriya_solution_flutter/constants/config.dart';
import 'package:rastriya_solution_flutter/shared/shared_pre.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    assignStaticValues();
    Future.delayed(const Duration(seconds: 2),
        () => Navigator.of(context).pushReplacementNamed("/sign_in"));
  }

  assignStaticValues() async {
    Config.userAuthenticationToken =
        (await getPreference(key: "userAuthenticationToken"));
    Config.companyInfo = await getSelectedCompany();
  }

  @override
  Widget build(BuildContext context) {
    return Placeholder(
      child: Image.asset("assets/jpg/mountain.jpg"),
    );
  }
}
