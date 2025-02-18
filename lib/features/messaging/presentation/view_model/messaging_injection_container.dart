import 'package:chat_app/core/utils/cloudinary_service.dart';
import 'package:chat_app/features/messaging/data/repo/messaging_firebase_remote_repository.dart';
import 'package:chat_app/features/messaging/data/repo/messaging_remote_repository.dart';
import 'package:chat_app/features/messaging/presentation/view_model/cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.asNewInstance();

Future<void> initMessagingSl() async {
  // Blocs
  sl.registerCachedFactory(
      () => MessagingViewModel(messagingFirebaseRemoteRepository: sl()));

  // Repositories
  sl.registerLazySingleton<MessagingRemoteRepository>(
      () => MessagingFirebaseRemoteRepository(
            cloudinaryService: sl(),
            firebaseFirestore: sl(),
            firebaseAuth: sl(),
          ));

  // External
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => CloudinaryService());
}
