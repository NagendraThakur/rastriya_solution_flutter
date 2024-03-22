import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rastriya_solution_flutter/data/repository/post_repository.dart';
import 'package:rastriya_solution_flutter/helper/dialog_utility.dart';
import 'package:rastriya_solution_flutter/helper/toastification.dart';
import 'package:rastriya_solution_flutter/pages/authentication/sign_in/cubit/sign_in_cubit.dart';
import 'package:rastriya_solution_flutter/shared/spacing.dart';
import 'package:rastriya_solution_flutter/shared/text_style.dart';
import 'package:rastriya_solution_flutter/widgets/button.dart';
import 'package:rastriya_solution_flutter/widgets/textfield.dart';
import 'package:toastification/toastification.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool isPasswordVisible = false;

  Future<void> registerUser() async {
    DialogUtils.showPleaseWaitProcessingDialog(context);
    final response = await PostRepository().authPostRequest(
        path: PostRepository.registerUser,
        body: {
          "email": emailController.text,
          "password": passwordController.text
        });

    Future.delayed(Duration.zero, () => Navigator.of(context).pop());
    if (response["status"] == "success") {
      String message = response["message"];
      Future.delayed(
          Duration.zero,
          () => showToastification(
              context: context,
              message: message,
              toastificationType: ToastificationType.success));
      Future.delayed(Duration.zero, () => Navigator.of(context).pop());
    } else if (response["status"] == "error") {
      Map<String, dynamic>? error = response["error"];
      if (error != null) {
        error.forEach((key, value) {
          if (value is List && value.isNotEmpty) {
            String message = value.first.toString();
            Future.delayed(
                Duration.zero,
                () => showToastification(
                    context: context,
                    message: message,
                    toastificationType: ToastificationType.error));
          }
        });
      } else {
        String message = response["message"];
        Future.delayed(
            Duration.zero,
            () => showToastification(
                context: context,
                message: message,
                toastificationType: ToastificationType.error));
      }
    } else {
      Future.delayed(
          Duration.zero,
          () => showToastification(
              context: context,
              message: "Server error. Try again later",
              toastificationType: ToastificationType.error));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CupertinoNavigationBarBackButton(),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                verticalSpaceLarge,
                Text(
                  "Let's start,",
                  style: kHeading2TextStyle,
                ),
                RichText(
                  text: TextSpan(
                    style: kHeading2TextStyle,
                    children: const [
                      TextSpan(
                        text: "with ",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      TextSpan(
                        text: "Registration!",
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                      TextSpan(
                        text: ".",
                      ),
                    ],
                  ),
                ),
                CustomTextField(
                  labelText: "Email",
                  hintText: "Enter Email",
                  controller: emailController,
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
                  suffixIcon: IconButton(
                    icon: Icon(
                      isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: () => setState(() {
                      isPasswordVisible = !isPasswordVisible;
                    }),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Password cannot be empty";
                    }
                    return null;
                  },
                ),
                verticalSpaceRegular,
                Text(
                  "By creating an account you agree to our Terms & Conditions",
                  style: kBodyRegularTextStyle,
                ),
                CustomButton(
                    buttonText: "Register",
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        registerUser();
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
              "Already have an account? ",
              style: kSubtitleRegularTextStyle,
            ),
            TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  "Log In",
                  style: kSubtitleTextStyle,
                ))
          ],
        ),
      ),
    );
  }
}
