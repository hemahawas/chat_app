import 'dart:async';

import 'package:chat_app/core/utils/cloudinary_service.dart';
import 'package:chat_app/core/utils/network_info.dart';
import 'package:chat_app/features/group/presentation/view_model/cubit.dart';

import 'package:chat_app/features/home/data/repo/home_remote_firebase_repository.dart';
import 'package:chat_app/features/home/presentation/view_model/cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

final sl = GetIt.instance;

Future<void> initHomeSl() async {
  // Bloc
  sl.registerFactory(
      () => HomeViewModel(firebaseHomeRepository: sl(), networkInfo: sl()));

  sl.registerFactory(() => GroupViewModel());
  // Repositories
  sl.registerLazySingleton<HomeRemoteFirebaseRepository>(() =>
      HomeRemoteFirebaseRepository(
          cloudinaryService: sl(),
          firebaseAuth: sl(),
          firebaseFirestore: sl()));

  // Externals
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
  sl.registerLazySingleton(() => CloudinaryService());
  sl.registerLazySingleton(() => NetworkInfo(internetConnectionChecker: sl()));
  sl.registerLazySingleton(() => InternetConnectionChecker.createInstance());
}
