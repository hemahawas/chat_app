import 'package:flutter/material.dart';

showToast({
  required String msg,
}) =>
    SnackBar(content: Text(msg));
