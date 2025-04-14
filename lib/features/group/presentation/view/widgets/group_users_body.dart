import 'package:chat_app/core/shared_widgets/icon_item_button.dart';
import 'package:chat_app/core/themes/color_app.dart';
import 'package:chat_app/core/utils/user_model.dart';
import 'package:chat_app/features/group/presentation/view/group_info_body_preview.dart';
import 'package:chat_app/features/home/presentation/view/widgets/image_field.dart';
import 'package:chat_app/features/home/presentation/view/widgets/user_item.dart';
import 'package:chat_app/features/home/presentation/view_model/cubit.dart';
import 'package:chat_app/features/home/presentation/view_model/home_injection_container.dart'
    as home_di;
import 'package:flutter/material.dart';

class GroupUsersBody extends StatefulWidget {
  const GroupUsersBody({super.key});

  @override
  State<GroupUsersBody> createState() => _GroupUsersBodyState();
}

class _GroupUsersBodyState extends State<GroupUsersBody> {
  // Get added Users
  late List<UserModel> _users;

  // Then add the users that will be grouped to list of added group users
  final List<UserModel> _addedGroupUsers = [];

  @override
  void initState() {
    debugPrint("GroupUsersBody: initState");
    _users = _getUsers();
    debugPrint("${_users.length}");
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<UserModel> _getUsers() {
    return home_di.sl<HomeViewModel>().addedUsers;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _addedGroupUsers.isNotEmpty
                ? SizedBox(
                    height: 100,
                    child: RepaintBoundary(
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemCount: _addedGroupUsers.length,
                        itemBuilder: (context, index) => Column(
                          children: [
                            Stack(alignment: Alignment.bottomRight, children: [
                              ImageField(
                                  borderColor: Colors.transparent,
                                  image: _addedGroupUsers[index].image),
                              IconItemButton(
                                icon: Icon(Icons.close),
                                size: 20,
                                onPressed: () {
                                  setState(() {
                                    _users.add(_addedGroupUsers[index]);
                                    _addedGroupUsers
                                        .remove(_addedGroupUsers[index]);
                                  });
                                },
                              ),
                            ]),
                            Text(_addedGroupUsers[index].name!),
                          ],
                        ),
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
            RepaintBoundary(
              child: ListView.builder(
                physics: AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: _users.length,
                itemBuilder: (context, index) => UserItem(
                  model: _users[index],
                  onTap: () {
                    setState(() {
                      _addedGroupUsers.add(_users[index]);
                      _users.remove(_users[index]);
                    });
                  },
                ),
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
                            ),
                        settings: RouteSettings(arguments: context)));
              }
            },
            child: Icon(Icons.arrow_forward),
          ),
        ),
      )
    ]);
  }
}
