import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PurchaseModuleMainPage extends StatelessWidget {
  const PurchaseModuleMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CupertinoNavigationBarBackButton(),
        title: const Text("Purchase Module"),
      ),
    );
  }
}
