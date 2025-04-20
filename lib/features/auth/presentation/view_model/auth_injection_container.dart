import 'package:chat_app/core/utils/network_info.dart';
import 'package:chat_app/features/auth/data/repo/auth_repository.dart';
import 'package:chat_app/features/auth/data/repo/firebase_auth_repository.dart';
import 'package:chat_app/features/auth/presentation/view_model/cubit.dart';
import 'package:chat_app/injection_container.dart' as di;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

final sl = GetIt.asNewInstance();

Future<void> initAuthSl() async {
  // Bloc
  sl.registerFactory(() => AuthViewModel(authRepository: sl()));

  // Repositories
  sl.registerLazySingleton<AuthRepository>(() =>
      FirebaseAuthRepository(firebaseFirestore: sl(), firebaseAuth: sl()));

  //External
  
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
  sl.registerLazySingleton(() => NetworkInfo(internetConnectionChecker: sl()));
  sl.registerLazySingleton(() => InternetConnectionChecker.createInstance());
}
