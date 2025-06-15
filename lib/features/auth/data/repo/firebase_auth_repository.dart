import 'package:chat_app/core/constants/app_strings.dart';
import 'package:chat_app/core/utils/cache_helper.dart';
import 'package:chat_app/core/utils/user_model.dart';
import 'package:chat_app/features/auth/data/repo/auth_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthRepository extends AuthRepository {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;

  FirebaseAuthRepository(
      {required this.firebaseFirestore, required this.firebaseAuth});

  @override
  Future<void> logIn(String email, String password) async {
    await firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((userCredential) {
      CacheHelper.saveData(
          key: AppStrings.uId, value: userCredential.user!.uid);
    });
  }

  @override
  Future<void> logOut() async {
    await firebaseAuth.signOut().then((_) {
      CacheHelper.removeData(key: AppStrings.uId);
      CacheHelper.removeData(key: AppStrings.currentUser);
    });
  }

  // Create user with its features
  @override
  Future<void> register(UserModel model, String password) async {
    // Create user
    await firebaseAuth
        .createUserWithEmailAndPassword(email: model.email, password: password)
        .then((userCredential) async {
      model.uId = userCredential.user!.uid;
      CacheHelper.saveData(
          key: AppStrings.uId, value: userCredential.user!.uid);

      // Add the new user to firestore
      await firebaseFirestore
          .collection('users')
          .doc(model.uId!)
          .set(model.toJson());
    });
  }
}
