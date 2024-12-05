import 'package:chat_app/core/utils/user_model.dart';
import 'package:chat_app/features/home/data/model/chat_model.dart';
import 'package:chat_app/features/home/data/repo/home_remote_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeRemoteFirebaseRepository extends HomeRemoteRepository {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;

  HomeRemoteFirebaseRepository(
      {required this.firebaseAuth, required this.firebaseFirestore});
  @override
  Future<List<ChatModel>> getChats() async {
    List<ChatModel> chats = [];
    await firebaseFirestore.collection('chats').get().then((value) {
      for (var doc in value.docs) {
        chats.add(ChatModel.fromJson(doc.data()));
      }
    });
    chats.removeWhere((chat) {
      return chat.userModel!.uId == firebaseAuth.currentUser!.uid;
    });

    print('**************************************');
    print(chats.toString());
    print('**************************************');
    return chats;
  }

  @override
  Future<UserModel> getUserInfo() async {
    UserModel user = UserModel(email: 'email');
    await firebaseFirestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .get()
        .then((value) {
      user = UserModel.fromJson(value.data());
    });
    return user;
  }
}
