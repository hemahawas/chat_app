import 'dart:ui';

import 'package:chat_app/core/config/routes.dart';
import 'package:chat_app/core/themes/color_app.dart';
import 'package:chat_app/core/utils/app_observer.dart';
import 'package:chat_app/core/utils/global_variables.dart';
import 'package:chat_app/features/splash_screen/splash_screen.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'firebase_options.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Dependency injection config
  di.init();

  // Security Config
  await dotenv.load(fileName: ".env");

  // Bloc observer config
  Bloc.observer = AppBlocObserver();

  // Firebase config
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.playIntegrity,
  );

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  // Restrict the orientation
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // Run App
  runApp(const MyApp());
  networkMonitor.stopMonitoring();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    networkMonitor.startMonitoring();

    return MaterialApp(
      //showPerformanceOverlay: true,
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
