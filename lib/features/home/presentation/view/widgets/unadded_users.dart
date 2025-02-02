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
    final blocContext =
        ModalRoute.settingsOf(context)!.arguments as BuildContext;
    final cubit = BlocProvider.of<HomeViewModel>(blocContext);
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: const Text('Add Users'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: BlocProvider.value(
          value: cubit,
          child: BlocConsumer<HomeViewModel, HomeStates>(
            listener: (context, state) {
              if (state is NewUserIsAddedState) {
                BlocProvider.of<HomeViewModel>(context)
                    .addedUsers
                    .add(state.newUser);
                BlocProvider.of<HomeViewModel>(context)
                    .nonAddedUsers
                    .remove(state.newUser);
              }
            },
            builder: (context, state) {
              return ConditionalBuilder(
                fallback: (context) => Center(
                  child: Center(
                    child: Text('Wait For Coming Users'),
                  ),
                ),
                condition: BlocProvider.of<HomeViewModel>(context)
                    .nonAddedUsers
                    .isNotEmpty,
                builder: (context) => RepaintBoundary(
                  child: ListView.builder(
                    itemBuilder: (context, index) => UserItem(
                      model: BlocProvider.of<HomeViewModel>(context)
                          .nonAddedUsers[index],
                    ),
                    itemCount: BlocProvider.of<HomeViewModel>(context)
                        .nonAddedUsers
                        .length,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
