import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AppNameShimmer extends StatelessWidget {
  const AppNameShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Shimmer.fromColors(
        baseColor: const Color.fromARGB(255, 39, 134, 26),
        highlightColor: const Color.fromARGB(255, 95, 242, 87),
        period: Duration(seconds: 5),
        child: Text(
          'Kalemni',
          style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
