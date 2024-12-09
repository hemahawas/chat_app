// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChatModelAdapter extends TypeAdapter<ChatModel> {
  @override
  final int typeId = 0;

  @override
  ChatModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChatModel(
      lastMessage: fields[2] as MessageModel?,
      messages: (fields[1] as List?)?.cast<MessageModel>(),
      participants: (fields[0] as List?)?.cast<UserModel>(),
      chatId: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ChatModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(3)
      ..write(obj.chatId)
      ..writeByte(0)
      ..write(obj.participants)
      ..writeByte(1)
      ..write(obj.messages)
      ..writeByte(2)
      ..write(obj.lastMessage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChatModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
