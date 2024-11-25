import 'package:chat_app/core/utils/user_model.dart';
import 'package:chat_app/features/home/data/model/chat_model.dart';
import 'package:chat_app/features/home/data/repo/home_repository.dart';
import 'package:chat_app/features/home/presentation/view_model/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeViewModel extends Cubit<HomeStates> {
  HomeViewModel(
      {required this.firebaseHomeRepository, required this.localHomeRepository})
      : super(InitialHomeStates());

  final HomeRepository firebaseHomeRepository;
  final HomeRepository localHomeRepository;

  List<ChatModel> chats = [];
  Future<void> getChats() async {
    emit(GetChatsFromFirebaseLoadingState());
    await firebaseHomeRepository.getChats().then((value) {
      chats = value;
      emit(GetChatsFromFirebaseSuccessState());
    }).catchError((error) {
      emit(GetChatsFromFirebaseErrorState());
    });
  }

  UserModel? currentUser;
  Future<void> getCurrentUser() async {
    emit(GetUserInfoLoadingState());
    await firebaseHomeRepository.getUserInfo().then((value) {
      currentUser = value;
      emit(GetUserInfoSuccessState());
    }).catchError((error) {
      emit(GetUserInfoErrorState());
    });
  }
}
