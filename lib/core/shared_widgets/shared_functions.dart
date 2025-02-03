import 'package:fluttertoast/fluttertoast.dart';

showToast({
  required String msg,
}) =>
    Fluttertoast.showToast(msg: msg);

showTimeExcecution({
  required String msg,
  required Function function,
}) {
  var time = DateTime.now().millisecondsSinceEpoch;
  function();
  var time2 = DateTime.now().millisecondsSinceEpoch;
  print('$msg: ${time2 - time}');
}
