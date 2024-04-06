import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rastriya_solution_flutter/constants/config.dart';
import 'package:rastriya_solution_flutter/pages/authentication/sign_in/cubit/sign_in_cubit.dart';
import 'package:rastriya_solution_flutter/shared/shared_pre.dart';
import 'package:rastriya_solution_flutter/shared/spacing.dart';
import 'package:rastriya_solution_flutter/shared/text_style.dart';

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
  }

  assignStaticValues() async {
    Config.userAuthenticationToken =
        (await getPreference(key: "userAuthenticationToken"));
    Config.companyInfo = await getSelectedCompany();
    Future.delayed(Duration.zero, () {
      if (Config.userAuthenticationToken != null &&
          Config.companyInfo != null) {
        BlocProvider.of<SignInCubit>(context).userTokenSignIn();
      } else {
        Navigator.of(context).pushReplacementNamed("/sign_in");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInCubit, SignInState>(
      listener: (context, state) {
        if (state is SignInSuccess) {
          if (Config.companyInfo != null) {
            Navigator.pushReplacementNamed(context, '/dashboard',
                arguments: Config.companyInfo);
          } else {
            Navigator.pushNamed(context, '/company_list');
          }
        } else if (state is SignInFailure) {
          Navigator.of(context).pushReplacementNamed("/sign_in");
        }
      },
      child: Scaffold(
        body: const Center(
          child: CircularProgressIndicator(),
        ),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RichText(
              text: TextSpan(
                style: kSubtitleTextStyle,
                children: [
                  TextSpan(
                    text: "Powered by ",
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 12,
                      color: Colors.grey.shade900,
                    ),
                  ),
                  TextSpan(
                    text: "Rastirya Solution",
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      color: Colors.blue.shade800,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              "Contact: RastriyaSolution@gmail.com",
              style: kSmallRegularTextStyle,
            ),
            verticalSpaceRegular,
          ],
        ),
      ),
    );
  }
}
