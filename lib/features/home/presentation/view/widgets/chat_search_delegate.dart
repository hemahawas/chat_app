import 'package:chat_app/features/group/data/model/group_model.dart';
import 'package:chat_app/features/home/presentation/view/widgets/chat_item.dart';
import 'package:chat_app/features/home/presentation/view_model/cubit.dart';
import 'package:chat_app/features/home/presentation/view_model/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatSearchDelegate extends SearchDelegate {
  // The Users
  List<ChatItem> searchTerms = [];
  // The context arg for cubit
  final BuildContext blocContext;
  ChatSearchDelegate({required this.blocContext});

  // To clear the query
  @override
  List<Widget>? buildActions(BuildContext context) {
    return null;
  }

  //To leave and close the search bar
  @override
  Widget? buildLeading(BuildContext context) {
    return BackButton(
      onPressed: () {
        close(context, null);
      },
    );
  }

  // To get the results
  @override
  Widget buildResults(BuildContext context) {
    return BlocProvider<HomeViewModel>.value(
      value: BlocProvider.of<HomeViewModel>(blocContext),
      child: BlocBuilder<HomeViewModel, HomeStates>(
        builder: (context, state) {
          final cubit = BlocProvider.of<HomeViewModel>(context);
          // Get chats
          searchTerms = List.generate(
              cubit.chats.length,
              (index) =>
                  ChatItem(isSearched: true, chatModel: cubit.chats[index]));

          List<ChatItem> matchQuery = [];
          // get searched chats and add it to matchQuery
          for (var chatItem in searchTerms) {
            if (chatItem.chatModel is GroupModel) {
              if ((chatItem.chatModel as GroupModel)
                  .chatId!
                  .toLowerCase()
                  .contains(query.toLowerCase())) {
                matchQuery.add(chatItem);
              }
            } else {
              var anotherUser =
                  chatItem.chatModel.participants!.firstWhere((e) {
                return e.uId != cubit.currentUser.uId;
              });
              if ((anotherUser.name
                  .toLowerCase()
                  .contains(query.toLowerCase()))) {
                matchQuery.add(chatItem);
              }
            }
          }
          // View the results
          return ListView.builder(
            itemExtent: 65,
            itemCount: matchQuery.length,
            itemBuilder: (context, index) => matchQuery[index],
          );
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return buildResults(context);
  }
}
