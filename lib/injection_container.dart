import 'package:chat_app/core/utils/cloudinary_service.dart';
import 'package:chat_app/core/utils/network_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'features/auth/presentation/view_model/auth_injection_container.dart'
    as auth_di;
import 'features/home/presentation/view_model/home_injection_container.dart'
    as home_di;
import 'features/messaging/presentation/view_model/messaging_injection_container.dart'
    as messaging_di;

final sl = GetIt.instance;

// Init the features' service locator
Future<void> init() async {
  auth_di.initAuthSl();
  home_di.initHomeSl();
  messaging_di.initMessagingSl();

  // External
  //External
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
  sl.registerLazySingleton(() => NetworkInfo(internetConnectionChecker: sl()));
  sl.registerLazySingleton(() => InternetConnectionChecker.createInstance());
  sl.registerLazySingleton(() => CloudinaryService());
}
