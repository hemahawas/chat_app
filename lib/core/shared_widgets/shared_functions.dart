import 'package:flutter/material.dart';

showToast({
  required String msg,
}) =>
    null;

showTimeExcecution({
  required String msg,
  required Function function,
}) {
  var time = DateTime.now().millisecondsSinceEpoch;
  function();
  var time2 = DateTime.now().millisecondsSinceEpoch;
  debugPrint('$msg: ${time2 - time}');
}
