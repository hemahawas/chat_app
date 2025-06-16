import 'package:chat_app/core/utils/cloudinary_service.dart';
import 'package:chat_app/core/utils/user_model.dart';
import 'package:chat_app/features/group/data/model/group_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GroupRepository {
  final CloudinaryService cloudinaryService = CloudinaryService();
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  GroupRepository();

  Future<void> checkIfGroupExists(String chatId) async {
    // Check if the group already exists
    // Check if there is a similar chatId
    await firebaseFirestore
        .collection('chats')
        .where('chatId', isEqualTo: chatId)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        throw Exception();
      }
    });
  }

  Future<void> createGroup(GroupModel group) async {
    // upload the image then assign it
    if (group.groupImageUrl != null) {
      group.groupImageUrl =
          await cloudinaryService.uploadImageThenGet(group.groupImageUrl!);
    }
    // Add to chat
    await firebaseFirestore
        .collection('chats')
        .doc(group.chatId)
        .set((group).toMap());
  }

  Future<void> notifyGroupMembers(GroupModel group) async {
    // Add the new group to users
    await firebaseFirestore
        .collection('users')
        .where('uId', whereIn: group.participantsUId)
        .get()
        .then((users) async {
      for (var user in users.docs) {
        UserModel userModel = UserModel.fromJson(user.data());
        userModel.addedChats ??= [];
        userModel.addedChats!.add(group.chatId!);
        // Update users
        await firebaseFirestore
            .collection('users')
            .doc(userModel.uId)
            .set(userModel.toJson());
      }
    });
  }
}
