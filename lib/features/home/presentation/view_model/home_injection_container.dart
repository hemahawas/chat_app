import 'package:chat_app/core/utils/network_info.dart';
import 'package:chat_app/features/home/data/repo/firebase_home_repository.dart';
import 'package:chat_app/features/home/data/repo/local_home_repository.dart';
import 'package:chat_app/features/home/presentation/view_model/cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

final sl = GetIt.asNewInstance();

Future<void> initHomeSl() async {
  // Blocs
  sl.registerFactory(() => HomeViewModel(
      firebaseHomeRepository: sl(),
      localHomeRepository: sl(),
      networkInfo: sl()));

  // Repositories
  sl.registerLazySingleton(() =>
      FirebaseHomeRepository(firebaseAuth: sl(), firebaseFirestore: sl()));
  sl.registerLazySingleton(() => LocalHomeRepository());

  // Externals
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
  sl.registerLazySingleton(() => NetworkInfo(internetConnectionChecker: sl()));
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
