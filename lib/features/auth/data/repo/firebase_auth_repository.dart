import 'package:chat_app/core/utils/user_model.dart';
import 'package:chat_app/features/auth/data/repo/auth_repository.dart';
import 'package:chat_app/features/home/data/model/chat_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthRepository extends AuthRepository {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;

  FirebaseAuthRepository(
      {required this.firebaseFirestore, required this.firebaseAuth});

  @override
  Future<void> logIn(String email, String password) async {
    await firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  @override
  Future<void> logOut() async {
    await firebaseAuth.signOut();
  }

  // Create user with its features
  @override
  Future<void> register(UserModel model, String password) async {
    // Create user
    await firebaseAuth
        .createUserWithEmailAndPassword(email: model.email!, password: password)
        .then((userCredential) async {
      model.uId = userCredential.user!.uid;
      _createUserFeatures(model);
    });
  }

  // Create user features
  // Chat - Status - Call
  _createUserFeatures(model) async {
    // Add user in firestore
    await firebaseFirestore
        .collection('users')
        .doc(model.uId!)
        .set(model.toMap());
    // Create new Chat for new user
    ChatModel chatModel =
        ChatModel(userModel: model, lastMessage: null, messages: null);
    // Add the chat to firestore
    await firebaseFirestore
        .collection('chats')
        .doc(model.uId!)
        .set(chatModel.toMap());
  }
}
