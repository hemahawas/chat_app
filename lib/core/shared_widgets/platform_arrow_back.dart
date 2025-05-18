import 'dart:io';

import 'package:flutter/material.dart';

class CustomPlatform {
  static IconData arrowBack =
      Platform.isIOS ? Icons.arrow_back_ios_rounded : Icons.arrow_back;
}
