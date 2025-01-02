import 'package:chat_app/core/shared_widgets/icon_item_button.dart';
import 'package:chat_app/core/themes/color_app.dart';
import 'package:chat_app/core/utils/user_model.dart';
import 'package:chat_app/features/group/presentation/view/group_info_body_preview.dart';
import 'package:chat_app/features/home/presentation/view/widgets/image_field.dart';
import 'package:chat_app/features/home/presentation/view/widgets/user_item.dart';
import 'package:chat_app/features/home/presentation/view_model/cubit.dart';
import 'package:chat_app/features/home/presentation/view_model/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chat_app/features/home/presentation/view_model/home_injection_container.dart'
    as home_di;

class GroupUsersBody extends StatefulWidget {
  GroupUsersBody({super.key});

  @override
  State<GroupUsersBody> createState() => _GroupUsersBodyState();
}

class _GroupUsersBodyState extends State<GroupUsersBody> {
  // Get added Users
  late List<UserModel> _groupUsers;

  // Then add the users that will be grouped to list of added group users
  final List<UserModel> _addedGroupUsers = [];

  @override
  void initState() {
    _groupUsers = _getUsers();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<UserModel> _getUsers() {
    return BlocProvider.of<HomeViewModel>(context).addedUsers;
  }

  @override
  Widget build(BuildContext context) {
    return Container();
    /*
    return BlocProvider<HomeViewModel>.value(
      value: BlocProvider.of<HomeViewModel>(context),
      child: BlocConsumer<HomeViewModel, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          // View the results
          return Stack(children: [
            SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _addedGroupUsers.isNotEmpty
                      ? SizedBox(
                          height: 100,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            itemCount: _addedGroupUsers.length,
                            itemBuilder: (context, index) => Column(
                              children: [
                                Stack(
                                    alignment: Alignment.bottomRight,
                                    children: [
                                      ImageField(
                                          borderColor: Colors.transparent,
                                          image: _addedGroupUsers[index].image),
                                      IconItemButton(
                                        icon: Icon(Icons.close),
                                        size: 20,
                                        onPressed: () {
                                          setState(() {
                                            _groupUsers
                                                .add(_addedGroupUsers[index]);
                                            _addedGroupUsers.remove(
                                                _addedGroupUsers[index]);
                                          });
                                        },
                                      ),
                                    ]),
                                Text(_addedGroupUsers[index].name!),
                              ],
                            ),
                          ),
                        )
                      : Container(),
                  SizedBox(
                    height: 2,
                    width: double.infinity,
                    child: Container(
                      height: 1,
                      color: Colors.grey,
                    ),
                  ),
                  ListView.builder(
                    physics: AlwaysScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: _groupUsers.isNotEmpty ? _groupUsers.length : 0,
                    itemBuilder: (context, index) => UserItem(
                      model: _groupUsers[index],
                      onTap: () {
                        setState(() {
                          _addedGroupUsers.add(_groupUsers[index]);
                          _groupUsers.remove(_groupUsers[index]);
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: FloatingActionButton(
                  backgroundColor: ColorApp.primaryColor,
                  onPressed: () {
                    if (_addedGroupUsers.isNotEmpty) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GroupInfoBodyPreview(
                                    addedUsers: _addedGroupUsers,
                                  )));
                    }
                  },
                  child: Icon(Icons.arrow_forward),
                ),
              ),
            )
          ]);
        },
      ),
    );*/
  }
}
