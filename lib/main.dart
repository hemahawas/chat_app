import 'package:chat_app/core/config/routes.dart';
import 'package:chat_app/core/themes/color_app.dart';
import 'package:chat_app/core/utils/app_observer.dart';
import 'package:chat_app/core/utils/firebase_notification.dart';
import 'package:chat_app/core/utils/hive_helper.dart';
import 'package:chat_app/features/splash_screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'firebase_options.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Screen util config
  await ScreenUtil.ensureScreenSize();

  // Dependency injection config
  di.init();

  // Bloc observer config
  Bloc.observer = AppBlocObserver();

  // Firebase config
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  NotificationService.instance.initialize();

  // Hive config
  await Hive.initFlutter();
  HiveHelper.init();

  // Run App
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    debugInvertOversizedImages = true;

    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: ColorApp.primaryColor),
          scaffoldBackgroundColor: ColorApp.appBackgroundColor,
          useMaterial3: true,
        ),
        home: const SplashScreen(),
        onGenerateRoute: AppRoutes.onGenerateRoute,
      ),
    );
  }
}
