import 'package:chat_app/core/themes/styles.dart';
import 'package:chat_app/features/group/data/model/group_model.dart';
import 'package:chat_app/features/group/presentation/view/widgets/group_member_item.dart';
import 'package:chat_app/features/home/presentation/view/widgets/image_field.dart';
import 'package:flutter/material.dart';

class GroupMembersView extends StatelessWidget {
  const GroupMembersView({super.key, required this.groupModel});
  final GroupModel groupModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(4.0),
            child: Container(
              color: Colors.grey.shade500,
              height: 1.0,
            )),
        title: Text('Group Info'),
      ),
      body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: 120,
                        maxWidth: 120,
                      ),
                      child: ImageField(
                        borderColor: Colors.transparent,
                        image: groupModel.groupImageUrl,
                      ),
                    ),
                    Text(groupModel.groupName, style: Styles.textStyle24),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 2,
                      color: Colors.grey[400],
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '${groupModel.participants!.length} Members',
                        style: Styles.textStyle24,
                      ),
                    ),
                    RepaintBoundary(
                      child: ListView.builder(
                        itemExtent: 65,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => GroupMemberItem(
                          model: groupModel.participants![index],
                        ),
                        itemCount: groupModel.participants!.length,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
