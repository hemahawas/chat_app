import 'package:chat_app/core/config/routes.dart';
import 'package:chat_app/core/themes/color_app.dart';
import 'package:chat_app/core/utils/app_observer.dart';
import 'package:chat_app/core/utils/hive_helper.dart';
import 'package:chat_app/core/utils/messaging_config.dart';
import 'package:chat_app/features/splash_screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'firebase_options.dart';
import 'injection_container.dart' as di;

final navigatorKey = GlobalKey<NavigatorState>();

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

  // Messaging Config
  MessagingConfig.initFirebaseMessaging();
  FirebaseMessaging.onBackgroundMessage(MessagingConfig.messageHandler);

  // Hive config
  await Hive.initFlutter();
  HiveHelper.init();

  // Restrict the orientation
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // Run App
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    debugInvertOversizedImages = true;

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
