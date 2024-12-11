import 'package:chat_app/features/messaging/data/repo/messaging_firebase_remote_repository.dart';
import 'package:chat_app/features/messaging/data/repo/messaging_remote_repository.dart';
import 'package:chat_app/features/messaging/presentation/view_model/cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.asNewInstance();

Future<void> initMessagingSl() async {
  // Blocs
  sl.registerCachedFactory(
      () => MessagingViewModel(messagingFirebaseRemoteRepository: sl()));

  // Repositories
  sl.registerLazySingleton<MessagingRemoteRepository>(() =>
      MessagingFirebaseRemoteRepository(
          firebaseFirestore: sl(), firebaseStorage: sl()));

  // External
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
  sl.registerLazySingleton(() => FirebaseStorage.instance);
}
