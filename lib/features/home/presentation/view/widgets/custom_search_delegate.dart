import 'package:chat_app/core/utils/user_model.dart';
import 'package:chat_app/features/home/data/model/chat_model.dart';
import 'package:chat_app/features/home/presentation/view/widgets/chat_item.dart';
import 'package:chat_app/features/home/presentation/view_model/cubit.dart';
import 'package:chat_app/features/home/presentation/view_model/states.dart';
import 'package:flutter/material.dart';

import 'package:chat_app/features/home/presentation/view_model/home_injection_container.dart'
    as home_di;
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomSearchDelegate extends SearchDelegate {
  // The Users
  List<ChatItem> searchTerms = [];
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
      value: home_di.sl<HomeViewModel>(),
      child: BlocBuilder<HomeViewModel, HomeStates>(
        builder: (context, state) {
          // Get chats
          searchTerms = List.generate(
              home_di.sl<HomeViewModel>().chats.length,
              (index) => ChatItem(
                  chatModel: home_di.sl<HomeViewModel>().chats[index]));

          List<ChatItem> matchQuery = [];
          // get searched chats and add it to matchQuery
          for (var chatItem in searchTerms) {
            var anotherUser = chatItem.chatModel.participants!.firstWhere((e) {
              return e.uId != home_di.sl<HomeViewModel>().currentUser!.uId;
            });
            if ((anotherUser.name!
                .toLowerCase()
                .contains(query.toLowerCase()))) {
              matchQuery.add(chatItem);
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
      value: home_di.sl<HomeViewModel>(),
      child: BlocBuilder<HomeViewModel, HomeStates>(
        builder: (context, state) {
          // Get chats
          searchTerms = List.generate(
              home_di.sl<HomeViewModel>().chats.length,
              (index) => ChatItem(
                  chatModel: home_di.sl<HomeViewModel>().chats[index]));

          List<ChatItem> matchQuery = [];
          // get searched chats and add it to matchQuery
          for (var chatItem in searchTerms) {
            var anotherUser = chatItem.chatModel.participants!.firstWhere((e) {
              return e.uId != home_di.sl<HomeViewModel>().currentUser!.uId;
            });
            if ((anotherUser.name!
                .toLowerCase()
                .contains(query.toLowerCase()))) {
              matchQuery.add(chatItem);
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
