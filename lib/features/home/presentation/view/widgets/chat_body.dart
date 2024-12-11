import 'package:chat_app/core/constants/app_strings.dart';
import 'package:chat_app/core/shared_widgets/responsive_sizedbox.dart';
import 'package:chat_app/core/themes/styles.dart';
import 'package:chat_app/features/home/presentation/view/widgets/chat_item.dart';
import 'package:chat_app/features/home/presentation/view/widgets/users_adder.dart';
import 'package:chat_app/features/home/presentation/view_model/cubit.dart';
import 'package:chat_app/features/home/presentation/view_model/states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatBody extends StatelessWidget {
  const ChatBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeViewModel, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              ConditionalBuilder(
                condition:
                    BlocProvider.of<HomeViewModel>(context).chats.isNotEmpty,
                fallback: (context) => Align(
                  alignment: Alignment.center,
                  child: Text(
                    AppStrings.addNewConnectionsForYourChat,
                    style: Styles.textStyle15.copyWith(color: Colors.grey),
                  ),
                ),
                builder: (context) => ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => ChatItem(
                    chatModel:
                        BlocProvider.of<HomeViewModel>(context).chats[index],
                  ),
                  itemCount:
                      BlocProvider.of<HomeViewModel>(context).chats.length,
                  separatorBuilder: (context, index) => ResponsiveSizedBox(
                    sizedBoxContext: context,
                    hasHeight: true,
                    heightFraction: 50,
                  ),
                ),
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
