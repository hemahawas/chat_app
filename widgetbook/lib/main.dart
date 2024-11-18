import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:widgetbook_workspace/cool_button.dart';
// This file does not exist yet,
// it will be generated in the next step
import 'main.directories.g.dart';

void main() {
  runApp(const WidgetbookApp());
}

@widgetbook.App()
class WidgetbookApp extends StatelessWidget {
  const WidgetbookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
        addons: [
          DeviceFrameAddon(
            devices: [
              Devices.ios.iPhoneSE,
              Devices.ios.iPhone13,
            ],
            initialDevice: Devices.ios.iPhone13,
          ),
        ],
        // The [directories] variable does not exist yet,
        // it will be generated in the next step
        directories: directories,
        appBuilder: (context, child) {
          return ScreenUtilInit(
            designSize: const Size(375, 812),
            minTextAdapt: true,
            splitScreenMode: true,
            useInheritedMediaQuery: true,
            builder: (context, child) {
              return const MaterialApp(
                debugShowCheckedModeBanner: false,
                home: CoolButton(),
              );
            },
          );
        });
  }
}
