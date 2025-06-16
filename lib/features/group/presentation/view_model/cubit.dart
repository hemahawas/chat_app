import 'package:chat_app/core/utils/network_info.dart';
import 'package:chat_app/core/utils/user_model.dart';
import 'package:chat_app/features/group/data/model/group_model.dart';
import 'package:chat_app/features/group/data/repo/group_repository.dart';
import 'package:chat_app/features/group/presentation/view_model/group_arguments.dart';
import 'package:chat_app/features/group/presentation/view_model/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class GroupViewModel extends Cubit<GroupStates> {
  GroupViewModel() : super(GroupInitialState());

  final NetworkInfo networkInfo = NetworkInfo(
      internetConnectionChecker: InternetConnectionChecker.instance);
  final GroupRepository groupRepository = GroupRepository();

  late UserModel currentUser;
  final List<UserModel> users = [];

  void getArguments(GroupArguments arguments) {
    currentUser = arguments.currentUser;
    // To avoid reference assignment
    for (var user in arguments.users) {
      users.add(user);
    }
    emit(GetGroupArgumentsState());
  }

  Future<void> createGroup(GroupModel group) async {
    emit(CreateGroupLoadingState());
    try {
      await groupRepository.checkIfGroupExists(group.chatId!);
    } catch (e) {
      emit(CreateGroupErrorState());
      return;
    }
    // Add current user to group
    group.participants!.add(currentUser);
    group.participantsUId!.add(currentUser.uId!);
    group.newMessages[currentUser.uId!] = 0;

    await groupRepository.createGroup(group).then((value) async {
      emit(CreateGroupSuccessState());
      await groupRepository.notifyGroupMembers(group);
    }).catchError((error) {
      emit(CreateGroupErrorState());
    });
  }
}
