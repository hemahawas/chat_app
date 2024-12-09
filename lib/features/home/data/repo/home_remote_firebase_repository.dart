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

    // get chats from firebase
    await firebaseFirestore.collection('chats').get().then((value) {
      // get only the chats that connected with current user
      for (var doc in value.docs) {
        // Not Professional: convert all chats to model then pick only connected chat
        var chat = ChatModel.fromJson(doc.data());

        if (chat.chatId!
            // ignore: collection_methods_unrelated_type
            .contains(firebaseAuth.currentUser!.uid.toString())) {
          print("TRUEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE");
          chats.add(chat);
        }
      }
    });

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

  @override
  Future<List<UserModel>> getUsers() async {
    List<UserModel> users = [];
    await firebaseFirestore.collection('users').get().then((value) {
      for (var doc in value.docs) {
        users.add(UserModel.fromJson(doc.data()));
      }
    });

    // Remove the current user
    users.removeWhere((user) {
      return user.uId == firebaseAuth.currentUser!.uid;
    });
    return users;
  }

  @override
  Future<ChatModel?> addNewChatThenGet(
      UserModel currentUser, UserModel anotherUser) async {
    // check if the chat between the current and the other exists or not
    await firebaseFirestore.collection('chats').get().then((value) {
      for (var doc in value.docs) {
        if (doc.id == '${currentUser.uId}-${anotherUser.uId}' ||
            doc.id == '${anotherUser.uId}-${currentUser.uId}') {
          return null;
        }
      }
    });

    // Then create new chat
    var chat = ChatModel(
        participants: [currentUser, anotherUser],
        chatId: '${currentUser.uId}-${anotherUser.uId}',
        lastMessage: null,
        messages: []);

    // Add the new chat to firestore
    await firebaseFirestore
        .collection('chats')
        .doc('${currentUser.uId}-${anotherUser.uId}')
        .set(chat.toMap());

    // Update the users to add new chats
    currentUser.addedChats ??= [];
    currentUser.addedChats!.add(anotherUser.uId.toString());
    anotherUser.addedChats ??= [];
    anotherUser.addedChats!.add(currentUser.uId.toString());

    await firebaseFirestore
        .collection('users')
        .doc(currentUser.uId)
        .set(currentUser.toMap());

    await firebaseFirestore
        .collection('users')
        .doc(anotherUser.uId)
        .set(anotherUser.toMap());
    // return the new chat
    return chat;
  }
}
