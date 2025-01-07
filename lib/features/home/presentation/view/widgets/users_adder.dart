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
class UsersAdder extends StatefulWidget {
  const UsersAdder({super.key, required this.blocContext});
  final BuildContext blocContext;

  @override
  State<UsersAdder> createState() => _UsersAdderState();
}

class _UsersAdderState extends State<UsersAdder> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        showModalBottomSheet(
            context: context,
            builder: (context) => Padding(
                  padding: EdgeInsets.all(10.0),
                  child: BlocProvider.value(
                    value: BlocProvider.of<HomeViewModel>(widget.blocContext),
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
