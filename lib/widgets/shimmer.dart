import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmer extends StatelessWidget {
  const CustomShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        itemCount: 12, // Adjust according to your needs
        itemBuilder: (context, index) {
          return ListTile(
            title: Container(
              width: double.infinity,
              height: 20,
              color: Colors.white, // Or any other color you desire
            ),
          );
        },
      ),
    );
  }
}
