import 'package:chat_app/core/utils/network_info.dart';
import 'package:chat_app/features/home/data/repo/home_remote_firebase_repository.dart';
import 'package:chat_app/features/home/data/repo/home_local_hive_repository.dart';
import 'package:chat_app/features/home/data/repo/home_remote_repository.dart';
import 'package:chat_app/features/home/data/repo/home_local_reopsitory.dart';
import 'package:chat_app/features/home/presentation/view_model/cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

final sl = GetIt.asNewInstance();

Future<void> initHomeSl() async {
  // Blocs

  // There is a problem found when using registerFactory()
  // - the cubit invoke each time I open it, although the data is loaded
  // Solution: use registerCachedFactory()
  // Warning the profileview uses existing blocprovider
  sl.registerCachedFactory(() => HomeViewModel(
      firebaseHomeRepository: sl(),
      localHomeRepository: sl(),
      networkInfo: sl()));

  // Repositories
  sl.registerLazySingleton<HomeRemoteRepository>(() =>
      HomeRemoteFirebaseRepository(
          firebaseAuth: sl(), firebaseFirestore: sl()));
  sl.registerLazySingleton<HomeLocalReopsitory>(
      () => HomeLocalHiveRepository());

  // Externals
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
  sl.registerLazySingleton(() => NetworkInfo(internetConnectionChecker: sl()));
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
