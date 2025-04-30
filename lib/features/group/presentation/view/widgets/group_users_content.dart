import 'package:chat_app/core/shared_widgets/icon_item_button.dart';
import 'package:chat_app/core/utils/user_model.dart';
import 'package:chat_app/features/group/presentation/view/widgets/group_user_item.dart';
import 'package:chat_app/features/home/presentation/view/widgets/image_field.dart';
import 'package:chat_app/features/home/presentation/view/widgets/user_item.dart';
import 'package:flutter/material.dart';

class GroupUsersContent extends StatelessWidget {
  const GroupUsersContent(
      {super.key,
      required this.users,
      required this.addedGroupUsers,
      required this.onUserAdded,
      required this.onUserRemoved});
  final Function(UserModel) onUserAdded;
  final Function(UserModel) onUserRemoved;
  final List<UserModel> users;
  final List<UserModel> addedGroupUsers;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            addedGroupUsers.isNotEmpty
                ? SizedBox(
                    height: 100,
                    child: RepaintBoundary(
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemCount: addedGroupUsers.length,
                        itemBuilder: (context, index) => Column(
                          children: [
                            Stack(alignment: Alignment.bottomRight, children: [
                              ImageField(
                                  borderColor: Colors.transparent,
                                  image: addedGroupUsers[index].image),
                              IconItemButton(
                                icon: Icon(Icons.close),
                                size: 20,
                                onPressed: () {
                                  onUserRemoved(addedGroupUsers[index]);
                                },
                              ),
                            ]),
                            Text(addedGroupUsers[index].name!),
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
                itemCount: users.length,
                itemBuilder: (context, index) => GroupUserItem(
                  model: users[index],
                  onTap: () {
                    onUserAdded(users[index]);
                  },
                ),
              ),
            ),
          ],
        ),
      )
    ]);
  }
}
