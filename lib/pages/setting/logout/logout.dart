import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rastriya_solution_flutter/data/repository/get_repository.dart';
import 'package:rastriya_solution_flutter/pages/authentication/sign_in/cubit/sign_in_cubit.dart';
import 'package:rastriya_solution_flutter/shared/spacing.dart';
import 'package:rastriya_solution_flutter/shared/text_style.dart';
import 'package:rastriya_solution_flutter/widgets/button.dart';

class LogOutDialog extends StatefulWidget {
  const LogOutDialog({super.key});

  @override
  State<LogOutDialog> createState() => _LogOutDialogState();
}

class _LogOutDialogState extends State<LogOutDialog> {
  bool? logoutAllDevice = false;

  void logoutFunction() {
    if (logoutAllDevice!) {
      GetRepository().getRequest(path: GetRepository.logoutAllDevices);
    }
    BlocProvider.of<SignInCubit>(context).logout();
    Navigator.pushNamedAndRemoveUntil(context, '/sign_in', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 1,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircleAvatar(
              radius: 22,
              child: Icon(
                Icons.logout,
              )),
          verticalSpaceRegular,
          Text(
            "Log Out ?",
            style: TextStyle(
              fontFamily: 'Manrope',
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade500,
              fontSize: 24,
              height: 1.5,
            ),
          ),
          Text(
            "Are you sure you want to log out ?",
            style: kSubtitleRegularTextStyle,
          ),
          verticalSpaceRegular,
          CustomButton(
              verticalPadding: 0,
              buttonText: "Logout",
              onPressed: () => logoutFunction()),
          TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("No Thanks!")),
        ],
      ),
    );
  }
}
