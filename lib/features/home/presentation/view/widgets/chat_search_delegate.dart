import 'package:chat_app/core/utils/user_model.dart';
import 'package:chat_app/features/group/data/model/group_model.dart';
import 'package:chat_app/features/home/data/model/chat_model.dart';
import 'package:chat_app/features/home/presentation/view/widgets/chat_item.dart';
import 'package:chat_app/features/home/presentation/view_model/cubit.dart';
import 'package:chat_app/features/home/presentation/view_model/states.dart';
import 'package:flutter/material.dart';

import 'package:chat_app/features/home/presentation/view_model/home_injection_container.dart'
    as home_di;
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
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back));
  }

  // To get the results
  @override
  Widget buildResults(BuildContext context) {
    return BlocProvider<HomeViewModel>.value(
      value: BlocProvider.of<HomeViewModel>(blocContext),
      child: BlocBuilder<HomeViewModel, HomeStates>(
        builder: (context, state) {
          // Get chats
          searchTerms = List.generate(
              BlocProvider.of<HomeViewModel>(context).chats.length,
              (index) => ChatItem(
                  isSearched: true,
                  chatModel:
                      BlocProvider.of<HomeViewModel>(context).chats[index]));

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
                return e.uId !=
                    BlocProvider.of<HomeViewModel>(context).currentUser!.uId;
              });
              if ((anotherUser.name!
                  .toLowerCase()
                  .contains(query.toLowerCase()))) {
                matchQuery.add(chatItem);
              }
            }
          }
          // View the results
          return ListView.builder(
            itemCount: matchQuery.length,
            itemBuilder: (context, index) => matchQuery[index],
          );
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return BlocProvider<HomeViewModel>.value(
      value: BlocProvider.of<HomeViewModel>(blocContext),
      child: BlocBuilder<HomeViewModel, HomeStates>(
        builder: (context, state) {
          // Get chats
          searchTerms = List.generate(
              BlocProvider.of<HomeViewModel>(context).chats.length,
              (index) => ChatItem(
                  isSearched: true,
                  chatModel:
                      BlocProvider.of<HomeViewModel>(context).chats[index]));

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
                return e.uId !=
                    BlocProvider.of<HomeViewModel>(context).currentUser!.uId;
              });
              if ((anotherUser.name!
                  .toLowerCase()
                  .contains(query.toLowerCase()))) {
                matchQuery.add(chatItem);
              }
            }
          }
          // View the results
          return ListView.builder(
            itemCount: matchQuery.length,
            itemBuilder: (context, index) => matchQuery[index],
          );
        },
      ),
    );
  }
}
