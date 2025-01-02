import 'package:chat_app/features/home/presentation/view/widgets/user_item.dart';
import 'package:chat_app/features/home/presentation/view_model/cubit.dart';
import 'package:chat_app/features/home/presentation/view_model/states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_app/features/home/presentation/view_model/home_injection_container.dart'
    as home_di;

// Add new users
class UsersAdder extends StatelessWidget {
  const UsersAdder({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        showModalBottomSheet(
            context: context,
            builder: (context) => BlocProvider(
                  create: (context) => HomeViewModel()..getUsers(),
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: BlocConsumer<HomeViewModel, HomeStates>(
                      listener: (context, state) {
                        // TODO: implement listener
                      },
                      builder: (context, state) {
                        return ConditionalBuilder(
                          fallback: (context) => Center(
                            child: CircularProgressIndicator(),
                          ),
                          condition: BlocProvider.of<HomeViewModel>(context)
                              .nonAddedUsers
                              .isNotEmpty,
                          builder: (context) => ListView.separated(
                            itemBuilder: (context, index) => UserItem(
                              model: BlocProvider.of<HomeViewModel>(context)
                                  .nonAddedUsers[index],
                            ),
                            itemCount: BlocProvider.of<HomeViewModel>(context)
                                .nonAddedUsers
                                .length,
                            separatorBuilder: (context, index) => SizedBox(
                              height: 10,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ));
      },
      icon: Icon(Icons.add),
      label: Text('Add New Users'),
    );
  }
}
