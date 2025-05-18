import 'package:chat_app/core/config/routes.dart';
import 'package:chat_app/core/themes/color_app.dart';
import 'package:chat_app/core/utils/app_observer.dart';
import 'package:chat_app/core/utils/global_variables.dart';
import 'package:chat_app/features/splash_screen/splash_screen.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'firebase_options.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Dependency injection config
  di.init();

  // Bloc observer config
  Bloc.observer = AppBlocObserver();

  // Firebase config
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Restrict the orientation
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // Run App
  runApp(DevicePreview(
      enabled: false,
      builder: (context) {
        return const MyApp();
      }));
  networkMonitor.stopMonitoring();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    networkMonitor.startMonitoring();
    //debugRepaintRainbowEnabled = true;
    return MaterialApp(
      //showPerformanceOverlay: true,
      builder: DevicePreview.appBuilder,
      locale: DevicePreview.locale(context),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: ColorApp.primaryColor),
        scaffoldBackgroundColor: ColorApp.appBackgroundColor,
        useMaterial3: true,
      ),
      home: const SplashScreen(),
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}
