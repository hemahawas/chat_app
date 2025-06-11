import 'package:chat_app/core/constants/app_strings.dart';
import 'package:chat_app/core/shared_widgets/custom_snack_bar.dart';
import 'package:chat_app/features/home/presentation/view/widgets/user_item.dart';
import 'package:chat_app/features/home/presentation/view_model/cubit.dart';
import 'package:chat_app/features/home/presentation/view_model/states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UnAddedUsers extends StatelessWidget {
  const UnAddedUsers({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: const Text('Add Users'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: BlocConsumer<HomeViewModel, HomeStates>(
          listener: (context, state) {
            if (state is AddUserToChatLoadingState) {
              CustomSnackBar.show(
                  message: 'Loading', context: context, color: Colors.blueGrey);
            }
            if (state is AddUserToChatSuccessState) {
              CustomSnackBar.show(
                  message: 'User Added Successfully',
                  context: context,
                  color: Colors.green);
            }
            if (state is ConnectionErrorState) {
              CustomSnackBar.show(
                  message: AppStrings.noInternetConnection,
                  context: context,
                  color: Colors.red);
            }
          },
          builder: (context, state) {
            var unAddedUsers =
                BlocProvider.of<HomeViewModel>(context).nonAddedUsers;
            return ConditionalBuilder(
              fallback: (context) => Center(
                child: Text('Wait For Coming Users'),
              ),
              condition: unAddedUsers.isNotEmpty,
              builder: (context) => RepaintBoundary(
                child: ListView.builder(
                  itemExtent: 65,
                  itemBuilder: (context, index) => UserItem(
                    key: ValueKey(unAddedUsers[index].uId),
                    model: unAddedUsers[index],
                  ),
                  itemCount: unAddedUsers.length,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
