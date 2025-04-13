import 'package:chat_app/core/utils/cloudinary_service.dart';
import 'package:chat_app/features/group/data/model/group_model.dart';
import 'package:chat_app/features/home/data/model/chat_model.dart';
import 'package:chat_app/features/messaging/data/model/message_model.dart';
import 'package:chat_app/features/messaging/data/repo/messaging_remote_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MessagingFirebaseRemoteRepository extends MessagingRemoteRepository {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth firebaseAuth;
  final CloudinaryService cloudinaryService;

  MessagingFirebaseRemoteRepository(
      {required this.firebaseAuth,
      required this.cloudinaryService,
      required this.firebaseFirestore});

  @override
  Future<List<MessageModel>> getMessages(ChatModel chat) {
    throw UnimplementedError();
  }

  // O(1)
  @override
  Future<void> sendTextMessage(ChatModel chat, MessageModel message) async {
    // add message on firestore
    await firebaseFirestore
        .collection('chats')
        .doc(chat.chatId)
        .collection('messages')
        .add(message.toMap())
        .then((value) {
      message.messageId = value.id;
    });

    // add message to chat
    chat.messages ??= [];
    chat.lastMessage = message;

    _updateChat(chat);
  }

  _updateChat(ChatModel chat) async {
    // update the last message field and new messages field in the chat
    await firebaseFirestore
        .collection('chats')
        .doc(chat.chatId)
        .update({'lastMessage': chat.lastMessage!.toMap()});

    if (chat is GroupModel) {
      for (var id in chat.participantsUId!) {
        if (id != chat.lastMessage!.messageSenderId) {
          // modify the chat last message in firestore
          await firebaseFirestore
              .collection('chats')
              .doc(chat.chatId)
              .update({'newMessages.$id': FieldValue.increment(1)});
        }
      }
    } else {
      // modify the chat last message in firestore
      await firebaseFirestore.collection('chats').doc(chat.chatId).update({
        'newMessages.${chat.participantsUId!.firstWhere((id) => id != chat.lastMessage!.messageSenderId)}':
            FieldValue.increment(1)
      });
    }
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getMessagesInRealTime(
      ChatModel chat) async* {
    yield* firebaseFirestore
        .collection('chats')
        .doc(chat.chatId)
        .collection('messages')
        .orderBy('sendingTime')
        .snapshots();
  }

  // O(1)
  @override
  Future<void> sendImageMessage(ChatModel chat, MessageModel message) async {
    // Note: the image field contains the path, then it will contain the url
    if (message.image == null) return;
    // upload the image to cloudinary
    message.image = await cloudinaryService.uploadImageThenGet(message.image!);

    // if the message has no body
    if (message.body!.isEmpty) {
      message.body = 'Photo.';
    }

    // add message on firestore
    await firebaseFirestore
        .collection('chats')
        .doc(chat.chatId)
        .collection('messages')
        .add(message.toMap())
        .then((value) {
      message.messageId = value.id;
    });

    // add message to chat
    chat.messages ??= [];
    chat.lastMessage = message;
    chat.messages!.insert(0, message);

    // modify the chat last message in firestore
    _updateChat(chat);
  }

  // O(1)
  @override
  Future<void> messagesIsSeen(String chatId, String currentUserId) async {
    await firebaseFirestore.collection('chats').doc(chatId).update({
      'newMessages.$currentUserId': 0,
    });
  }

  @override
  String getCurrentUserUid() {
    return firebaseAuth.currentUser!.uid;
  }
}
