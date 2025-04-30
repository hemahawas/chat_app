import 'package:chat_app/features/home/data/model/chat_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;

  FirebaseDataSource(
      {required this.firebaseAuth, required this.firebaseFirestore});

  Future<List<ChatModel>> getChats() async {
    List<ChatModel> chats = [];
    // get chats from firebase
    await firebaseFirestore.collection('chats').get().then((value) {
      // get only the chats that connected with current user
      for (var doc in value.docs) {
        // Not Professional: convert all chats to model then pick only connected chat
        var chat = ChatModel.fromJson(doc.data());

        chats.add(chat);
      }
    });

    return chats;
  }
}
