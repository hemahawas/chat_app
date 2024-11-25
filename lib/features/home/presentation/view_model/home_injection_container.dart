import 'package:chat_app/features/home/data/repo/firebase_home_repository.dart';
import 'package:chat_app/features/home/data/repo/local_home_repository.dart';
import 'package:chat_app/features/home/presentation/view_model/cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initHomeSl() async {
  // Blocs
  sl.registerFactory(() => HomeViewModel(
      firebaseHomeRepository: sl<FirebaseHomeRepository>(),
      localHomeRepository: sl<LocalHomeRepository>()));

  // Repositories
  sl.registerLazySingleton(() =>
      FirebaseHomeRepository(firebaseAuth: sl(), firebaseFirestore: sl()));
  sl.registerLazySingleton(() => LocalHomeRepository());

  // Externals
  sl.registerSingleton(() => FirebaseAuth.instance);
  sl.registerSingleton(() => FirebaseFirestore.instance);
}
