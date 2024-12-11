import 'package:chat_app/core/constants/app_strings.dart';
import 'package:chat_app/features/auth/presentation/view/login_view.dart';
import 'package:chat_app/features/auth/presentation/view/register_view.dart';
import 'package:chat_app/features/auth/presentation/view_model/cubit.dart';
import 'package:chat_app/features/home/presentation/view/home_view.dart';
import 'package:chat_app/features/home/presentation/view/profile_view.dart';
import 'package:chat_app/features/home/presentation/view/settings_view.dart';
import 'package:chat_app/features/home/presentation/view_model/cubit.dart';
import 'package:chat_app/features/messaging/presentation/view/messaging_view.dart';
import 'package:chat_app/features/messaging/presentation/view_model/cubit.dart';
import 'package:chat_app/features/messaging/presentation/view_model/messaging_arguments.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_app/features/auth/presentation/view_model/auth_injection_container.dart'
    as auth_di;

import 'package:chat_app/features/home/presentation/view_model/home_injection_container.dart'
    as home_di;

import 'package:chat_app/features/messaging/presentation/view_model/messaging_injection_container.dart'
    as messaging_di;

class Routes {
  static const String initialRoute = '/';
  static const String loginRoute = '/loginRoute';
  static const String registerRoute = '/registerRoute';
  static const String homeRoute = '/homeRoute';
  static const String settingsRoute = '/settingsRoute';
  static const String profileRoute = '/profileRoute';
  static const String messagingRoute = '/messagingRoute';
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
          return BlocProvider(
            // This invokation order may be critical
            create: ((context) => home_di.sl<HomeViewModel>()
              ..getUsers()
              ..getCurrentUser()
              ..getChats()),
            child: const HomeView(),
          );
        }));
      case Routes.profileRoute:
        return MaterialPageRoute(builder: ((context) {
          return BlocProvider.value(
            value: home_di.sl<HomeViewModel>(),
            child: const ProfileView(),
          );
        }));
      case Routes.settingsRoute:
        return MaterialPageRoute(builder: ((context) {
          return BlocProvider(
            create: ((context) => auth_di.sl<AuthViewModel>()),
            child: const SettingsView(),
          );
        }));
      case Routes.messagingRoute:
        return MaterialPageRoute(builder: (context) {
          return BlocProvider(
            create: (context) => messaging_di.sl<MessagingViewModel>()
              // Here we got the arguments from routing then pass it to messaging view model
              // I did this to avoid cascading in passing arguments.
              // For more: https://www.geeksforgeeks.org/flutter-arguments-in-named-routes/
              ..getMessagingArguments(context),
            child: const MessagingView(),
          );
        });
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
