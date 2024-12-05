import 'package:chat_app/core/shared_widgets/responsive_sizedbox.dart';
import 'package:chat_app/features/home/presentation/view/widgets/chat_item.dart';
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
        return ConditionalBuilder(
          condition: BlocProvider.of<HomeViewModel>(context).chats.isNotEmpty,
          fallback: (context) => Center(child: CircularProgressIndicator()),
          builder: (context) => ListView.separated(
            itemBuilder: (context, index) => ChatItem(
                chatModel:
                    BlocProvider.of<HomeViewModel>(context).chats[index]),
            itemCount: BlocProvider.of<HomeViewModel>(context).chats.length,
            separatorBuilder: (context, index) => ResponsiveSizedBox(
              sizedBoxContext: context,
              hasHeight: true,
              heightFraction: 50,
            ),
          ),
        );
      },
    );
  }
}
