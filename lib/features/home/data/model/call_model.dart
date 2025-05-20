import 'package:chat_app/core/utils/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CallModel {
  List<UserModel>? participants;
  Timestamp? callTime;
  UserModel? caller;
  String? callingDuration;

  // 1. Constructor
  // 2. from Json
  // 3. to Map
}
