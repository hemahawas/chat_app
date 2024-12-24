import 'package:chat_app/core/constants/app_strings.dart';
import 'package:chat_app/core/shared_widgets/responsive_sizedbox.dart';
import 'package:chat_app/core/themes/styles.dart';
import 'package:chat_app/features/home/presentation/view/widgets/chat_item.dart';
import 'package:chat_app/features/home/presentation/view/widgets/users_adder.dart';
import 'package:chat_app/features/home/presentation/view_model/cubit.dart';
import 'package:chat_app/features/home/presentation/view_model/states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:chat_app/features/home/presentation/view_model/home_injection_container.dart'
    as home_di;

class ChatBody extends StatefulWidget {
  const ChatBody({super.key});

  @override
  State<ChatBody> createState() => _ChatBodyState();
}

class _ChatBodyState extends State<ChatBody> {
  Stream<QuerySnapshot<Map<String, dynamic>>>? _chatSnapshots;
  @override
  void initState() {
    _chatSnapshots = home_di.sl<HomeViewModel>().getChatsInRealTime();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeViewModel, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              StreamBuilder(
                stream: _chatSnapshots,
                builder: (context, snapShot) {
                  switch (snapShot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return Align(
                        alignment: Alignment.center,
                        child: Text(
                          AppStrings.addNewConnectionsForYourChat,
                          style:
                              Styles.textStyle15.copyWith(color: Colors.grey),
                        ),
                      );
                    case ConnectionState.active:
                    case ConnectionState.done:
                      // Before building the listview, we shoul check about
                      // 1. current user is not null
                      // 2. All users exists

                      if (snapShot.hasData) {
                        home_di.sl<HomeViewModel>().setChats(snapShot);
                        return home_di.sl<HomeViewModel>().chats.isNotEmpty
                            ? ListView.separated(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) => ChatItem(
                                  chatModel:
                                      home_di.sl<HomeViewModel>().chats[index],
                                ),
                                itemCount:
                                    home_di.sl<HomeViewModel>().chats.length,
                                separatorBuilder: (context, index) =>
                                    ResponsiveSizedBox(
                                  sizedBoxContext: context,
                                  hasHeight: true,
                                  heightFraction: 50,
                                ),
                              )
                            : Align(
                                alignment: Alignment.center,
                                child: Text(
                                  AppStrings.addNewConnectionsForYourChat,
                                  style: Styles.textStyle15
                                      .copyWith(color: Colors.grey),
                                ));
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                  }
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              UsersAdder(),
            ],
          ),
        );
      },
    );
  }
}
