import 'package:chat_app/core/themes/color_app.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class DateTitle extends StatelessWidget {
  const DateTitle({super.key, required this.date});
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          color: ColorApp.appBackgroundColor,
          borderRadius: BorderRadius.circular(20.0)),
      child: Text(_getDate()),
    );
  }

  _getDate() {
    if (date.subtract(Duration(days: 1)).day == DateTime.now().day) {
      return 'Yesterday';
    }
    if (date.day == DateTime.now().day) {
      return 'Today';
    }
    return DateFormat.MMMMEEEEd().format(date);
  }
}
