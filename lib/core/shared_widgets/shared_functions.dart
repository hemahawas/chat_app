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
  print('$msg: ${time2 - time}');
}
