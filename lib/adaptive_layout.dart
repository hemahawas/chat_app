import 'package:chat_app/core/utils/size_config.dart';
import 'package:flutter/material.dart';

class AdaptiveLayout extends StatelessWidget {
  const AdaptiveLayout(
      {super.key, required this.mobilelayout, required this.tabletLayout});

  final WidgetBuilder mobilelayout, tabletLayout;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth <= SizeConfig.mobileBreakpoint) {
          return mobilelayout(context);
        } else {
          return tabletLayout(context);
        }
      },
    );
  }
}
