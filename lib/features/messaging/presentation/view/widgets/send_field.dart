import 'package:chat_app/core/shared_widgets/default_formfield.dart';
import 'package:chat_app/core/shared_widgets/icon_item_button.dart';
import 'package:chat_app/core/themes/color_app.dart';
import 'package:chat_app/features/messaging/presentation/view/widgets/attachment_items.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SendField extends StatelessWidget {
  final TextEditingController sendController;

  const SendField({super.key, required this.sendController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: defaultFormField(
          controller: sendController,
          type: TextInputType.text,
          validate: (value) {},
          decoration: InputDecoration(
              suffixIcon: Transform.rotate(
                angle: 45,
                child: IconButton(
                  onPressed: () {
                    showCupertinoModalPopup(
                      context: context,
                      builder: (builder) => AttachmentItems(),
                    );
                  },
                  icon: Icon(Icons.attachment),
                  iconSize: 30,
                  color: Colors.grey,
                ),
              ),
              fillColor: ColorApp.appBackgroundColor,
              filled: true,
              hintText: 'send your message',
              floatingLabelStyle: const TextStyle(color: ColorApp.primaryColor),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0.sp),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0.sp),
              ))),
    );
  }
}
