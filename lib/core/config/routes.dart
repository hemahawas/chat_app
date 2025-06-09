import 'package:chat_app/core/constants/app_strings.dart';
import 'package:chat_app/features/auth/presentation/view/login_view.dart';
import 'package:chat_app/features/auth/presentation/view/register_view.dart';
import 'package:chat_app/features/auth/presentation/view_model/auth_injection_container.dart'
    as auth_di;
import 'package:chat_app/features/auth/presentation/view_model/cubit.dart';
import 'package:chat_app/features/group/presentation/view/group_content_preview.dart';
import 'package:chat_app/features/group/presentation/view_model/cubit.dart';
import 'package:chat_app/features/group/presentation/view_model/group_arguments.dart';
import 'package:chat_app/features/home/presentation/view/home_view.dart';
import 'package:chat_app/features/home/presentation/view/profile_view.dart';
import 'package:chat_app/features/home/presentation/view/settings_view.dart';
import 'package:chat_app/features/home/presentation/view_model/cubit.dart';
import 'package:chat_app/features/home/presentation/view_model/home_injection_container.dart'
    as home_di;
import 'package:chat_app/features/messaging/presentation/view/messaging_view.dart';
import 'package:chat_app/features/messaging/presentation/view_model/cubit.dart';
import 'package:chat_app/features/messaging/presentation/view_model/messaging_arguments.dart';
import 'package:chat_app/features/messaging/presentation/view_model/messaging_injection_container.dart'
    as messaging_di;
import 'package:chat_app/features/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Routes {
  static const String initialRoute = '/';
  static const String loginRoute = '/loginRoute';
  static const String registerRoute = '/registerRoute';
  static const String homeRoute = '/homeRoute';
  static const String settingsRoute = '/settingsRoute';
  static const String profileRoute = '/profileRoute';
  static const String messagingRoute = '/messagingRoute';
  static const String chatSearch = '/chatSearch';
  static const String newGroupRoute = '/newGroupRoute';
}

class AppRoutes {
  static Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.initialRoute:
        return MaterialPageRoute(builder: (context) {
          return const SplashScreen();
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
          return BlocProvider<HomeViewModel>(
            create: (context) => home_di.sl<HomeViewModel>()
              ..getCurrentUser()
              ..getUsers(),
            child: HomeView(),
          );
        }));
      case Routes.profileRoute:
        return MaterialPageRoute(
            builder: ((context) {
              return const ProfileView();
            }),
            settings: RouteSettings(arguments: routeSettings.arguments));
      case Routes.settingsRoute:
        return MaterialPageRoute(builder: ((context) {
          return BlocProvider(
            create: ((context) => auth_di.sl<AuthViewModel>()),
            child: const SettingsView(),
          );
        }));
      case Routes.messagingRoute:
        return MaterialPageRoute(builder: (context) {
          return BlocProvider<MessagingViewModel>(
            create: (context) => messaging_di.sl<MessagingViewModel>()
              ..getMessagingArguments(
                  routeSettings.arguments as MessagingArguments),
            child: const MessagingView(),
          );
        });
      case Routes.newGroupRoute:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => home_di.sl<GroupViewModel>()
                    ..getArguments(routeSettings.arguments as GroupArguments),
                  child: GroupContentPreview(),
                ));
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
