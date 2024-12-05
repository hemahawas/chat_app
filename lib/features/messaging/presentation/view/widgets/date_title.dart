import 'package:chat_app/core/themes/color_app.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class DateTitle extends StatelessWidget {
  const DateTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Offstage(
      offstage: false,
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Text('3 Sep 2023'),
        decoration: BoxDecoration(
            color: ColorApp.appBackgroundColor,
            borderRadius: BorderRadius.circular(20.0)),
      ),
    );
  }
}
