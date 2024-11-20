import 'package:chat_app/core/constants/app_strings.dart';
import 'package:chat_app/features/auth/presentation/view/login_view.dart';
import 'package:chat_app/features/auth/presentation/view/register_view.dart';
import 'package:chat_app/features/auth/presentation/view_model/cubit.dart';
import 'package:chat_app/features/home/presentation/view/home_view.dart';
import 'package:chat_app/features/home/presentation/view/settings_view.dart';
import 'package:chat_app/features/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_app/features/auth/presentation/view_model/auth_injection_container.dart'
    as auth_di;

class Routes {
  static const String initialRoute = '/';
  static const String loginRoute = '/loginRoute';
  static const String registerRoute = '/registerRoute';
  static const String homeRoute = '/homeRoute';
  static const String settingsRoute = '/ettingsRoute';
}

class AppRoutes {
  static Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.initialRoute:
        return MaterialPageRoute(builder: (context) {
          return const HomeView();
        });

      case Routes.loginRoute:
        return MaterialPageRoute(builder: ((context) {
          return BlocProvider(
              create: ((context) => auth_di.sl<AuthViewModel>()),
              child: const LoginView());
        }));
      case Routes.registerRoute:
        return MaterialPageRoute(builder: ((context) {
          return BlocProvider(
              create: ((context) => auth_di.sl<AuthViewModel>()),
              child: const RegisterView());
        }));
      case Routes.homeRoute:
        return MaterialPageRoute(builder: ((context) {
          return const HomeView();
        }));
      case Routes.settingsRoute:
        return MaterialPageRoute(builder: ((context) {
          return BlocProvider(
            create: ((context) => auth_di.sl<AuthViewModel>()),
            child: const SettingsView(),
          );
        }));
      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
        builder: ((context) => const Scaffold(
              body: Center(
                child: Text(AppStrings.noRouteFound),
              ),
            )));
  }
}
