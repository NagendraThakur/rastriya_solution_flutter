import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rastriya_solution_flutter/constants/config.dart';
import 'package:rastriya_solution_flutter/helper/dialog_utility.dart';
import 'package:rastriya_solution_flutter/helper/toastification.dart';
import 'package:rastriya_solution_flutter/pages/authentication/sign_in/cubit/sign_in_cubit.dart';
import 'package:rastriya_solution_flutter/shared/spacing.dart';
import 'package:rastriya_solution_flutter/shared/text_style.dart';
import 'package:rastriya_solution_flutter/widgets/button.dart';
import 'package:rastriya_solution_flutter/widgets/textfield.dart';
import 'package:toastification/toastification.dart';

class SignInScreen extends StatefulWidget {
  SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      if (Config.userAuthenticationToken != null &&
          Config.companyInfo != null) {
        BlocProvider.of<SignInCubit>(context).userTokenSignIn();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInCubit, SignInState>(
      listener: (context, state) {
        if (state is SignInLoading) {
          return DialogUtils.showProcessingDialog(context);
        } else if (state is SignInSuccess) {
          Navigator.pop(context); // Dismiss loading dialog
          if (Config.companyInfo != null) {
            Navigator.pushReplacementNamed(context, '/dashboard',
                arguments: Config.companyInfo);
          } else {
            Navigator.pushNamed(context, '/company_list');
          }
        } else if (state is SignInFailure) {
          Navigator.pop(context); // Dismiss loading dialog
          showToastification(
              context: context,
              message: "Login failed: ${state.error}",
              toastificationType: ToastificationType.error);
        } else if (state is PasswordVisibilityState) {
          isPasswordVisible = state.isVisible;
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
          ),
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    verticalSpaceRegular,
                    Text(
                      "Hey",
                      style: kHeading1TextStyle,
                    ),
                    RichText(
                      text: TextSpan(
                        style: kHeading2TextStyle,
                        children: const [
                          TextSpan(
                            text: "Welcome ",
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                          TextSpan(
                            text: "Back",
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          TextSpan(
                            text: ".",
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "SignIn to your account",
                      style: kSubtitleRegularTextStyle,
                    ),
                    CustomTextField(
                      labelText: "Email",
                      hintText: "Enter Email",
                      controller: emailController,
                      // inputBorder: InputBorder.none,
                      filled: false,
                      prefixIcon: const Icon(CupertinoIcons.mail),
                      validator: (value) {
                        final emailRegex = RegExp(
                            r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');
                        if (value!.isEmpty) {
                          return "Email cannot be empty";
                        } else if (!emailRegex.hasMatch(value)) {
                          return "Email must be valid";
                        }
                        return null;
                      },
                    ),
                    CustomTextField(
                      labelText: "Password",
                      hintText: "Enter Password",
                      controller: passwordController,
                      obscureText: !isPasswordVisible,
                      filled: false,
                      prefixIcon: const Icon(CupertinoIcons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onPressed: () => BlocProvider.of<SignInCubit>(context)
                            .togglePasswordVisibility(),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Password cannot be empty";
                        }
                        return null;
                      },
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Forget Password ?",
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ),
                    CustomButton(
                        buttonText: "Log in",
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            BlocProvider.of<SignInCubit>(context)
                                .signInButtonPressed(
                                    username: emailController.text,
                                    password: passwordController.text);
                          }
                        })
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "New on our platform? ",
                  style: kSubtitleRegularTextStyle,
                ),
                TextButton(
                    onPressed: () =>
                        Navigator.of(context).pushNamed("/sign_up"),
                    child: Text(
                      "Create an account",
                      style: kSubtitleTextStyle,
                    ))
              ],
            ),
          ),
        );
      },
    );
  }
}
